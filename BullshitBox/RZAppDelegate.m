//
//  RZAppDelegate.m
//  BullshitBox
//
//  Created by Ambroise Maupate on 01/07/2014.
//  Copyright (c) 2014 REZO ZERO. All rights reserved.
//

#import "RZAppDelegate.h"

#import "RZSentencesDelegate.h"

@implementation RZAppDelegate

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
        NSLog(@"%lu sentence(s) available.", [_sentences count]);
    }
}

- (NSURL *)sentencesStoreFile
{
    return [[self applicationFilesDirectory] URLByAppendingPathComponent:@"sentences.plist"];
}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "ambroisemaupate.BullshitBox" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"ambroisemaupate.BullshitBox"];
}

@end
