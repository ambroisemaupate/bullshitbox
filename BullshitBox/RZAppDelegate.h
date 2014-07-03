//
//  RZAppDelegate.h
//  BullshitBox
//
//  Created by Ambroise Maupate on 01/07/2014.
//  Copyright (c) 2014 REZO ZERO. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RZAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet NSTextField *customTextField;
@property (nonatomic, retain) IBOutlet NSWindow *mainWindow;
@property (nonatomic, retain) IBOutlet NSScrollView *mainScrollView;
@property (nonatomic, retain) IBOutlet NSView *innerScrollView;
@property (nonatomic, retain) NSSpeechSynthesizer *synth;
@property (nonatomic, retain) NSMutableArray *sentences;
@property (nonatomic, retain) NSMutableArray *buttons;

- (IBAction)saveAction:(id)sender;
- (IBAction)speakFromButton:(id)sender;

@end
