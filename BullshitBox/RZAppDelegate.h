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

@property (nonatomic, retain) IBOutlet NSTextField *customTextField;
@property (nonatomic, retain) IBOutlet NSWindow *mainWindow;
@property (nonatomic, retain) IBOutlet NSScrollView *mainScrollView;
@property (nonatomic, retain) IBOutlet NSView *innerScrollView;
@property (nonatomic, retain) IBOutlet NSTableView *tableView;

@property (nonatomic, retain) IBOutlet NSTableColumn *sentenceColumn;

@property (nonatomic, retain) NSSpeechSynthesizer *synth;
@property (nonatomic, retain) NSMutableArray *sentences;
@property (nonatomic, retain) NSMutableArray *buttons;

- (void)saveSentences;

@end
