//
//  RZAppDelegate.m
//  BullshitBox
//
//  Created by Ambroise Maupate on 01/07/2014.
//  Copyright (c) 2014 REZO ZERO. All rights reserved.
//

#import "RZAppDelegate.h"

#import "RZSentencesDelegate.h"
#import "RZSpeechButton.h"
#import "RZDeleteSentenceButton.h"

@implementation RZAppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize sentences = _sentences;
@synthesize synth = _synth;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    _synth = [[NSSpeechSynthesizer alloc] init]; //start with default voice
    _sentences = [[NSMutableArray alloc] init];
    
    [self loadSentences];
}

- (IBAction)speakCustom:(id)sender
{
    NSString *sentence = self.customTextField.stringValue;
    [_synth startSpeakingString:sentence];
}

- (IBAction)addCustomSentence:(id)sender
{
    NSString *sentence = self.customTextField.stringValue;
    if ([sentence length] > 0) {
        [_sentences addObject:sentence];
        
        [self.customTextField setStringValue:@""];
        [_tableView reloadData];
        [self saveSentences];
    }
}


- (IBAction)speakFromButton:(id)sender
{
    NSString *sentence = ((RZSpeechButton*)sender).speechedSentence;
    [_synth startSpeakingString:sentence];
}


- (IBAction)removeButton:(id)sender
{
    RZSpeechButton *refButton = ((RZDeleteSentenceButton*)sender).refButton;
    
    for(id item in _sentences) {
        if([item isEqual:(refButton.speechedSentence)]) {
            [_sentences removeObject:item];
            break;
        }
    }
    
    [self saveSentences];
    [_tableView reloadData];
}

- (void)removeAllButton
{
    for(id item in _buttons) {
        [item removeFromSuperview];
    }
    
    [_buttons removeAllObjects];
    [_tableView reloadData];
}


- (void)saveSentences
{
    NSFileManager *myManager =[NSFileManager defaultManager];
    
    NSURL *storeFolder = [self applicationFilesDirectory];
    NSURL *storeURL = [self sentencesStoreFile];
    
    if (![myManager fileExistsAtPath:[storeFolder path]])
    {
        NSLog(@"Error: Folder does not exist %@", [storeFolder path]);
        if(![myManager createDirectoryAtPath:[storeFolder path] withIntermediateDirectories:YES attributes:nil error:NULL])
        {
            NSLog(@"Error: Create folder failed %@", [storeFolder path]);
        }
    }
    
    [_sentences writeToURL:storeURL atomically:YES];
}

- (void)loadSentences
{
    NSFileManager *myManager =[NSFileManager defaultManager];
    NSURL *storeURL = [self sentencesStoreFile];
    
    if ([myManager fileExistsAtPath:[storeURL path]])
    {
         NSLog(@"Confirm: Loading %@", [storeURL path]);
        _sentences = [NSMutableArray arrayWithContentsOfURL:storeURL];
       
        [_tableView reloadData];
        int count = [_sentences count];
        NSLog(@"Table delegate is %i.", (int)count);
    }
}

- (NSURL *)sentencesStoreFile
{
    return [[self applicationFilesDirectory] URLByAppendingPathComponent:@"sentences.plist"];
}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "rezo-zero.BullshitBox" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"rezo-zero.BullshitBox"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BullshitBox" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    } else {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"BullshitBox.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _persistentStoreCoordinator = coordinator;
    
    return _persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) 
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];

    return _managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (!_managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {

        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

@end
