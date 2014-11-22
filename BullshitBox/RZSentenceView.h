//
//  RZSentenceView.h
//  BullshitBox
//
//  Created by Ambroise Maupate on 22/11/2014.
//  Copyright (c) 2014 REZO ZERO. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RZAppDelegate.h"

@interface RZSentenceView : NSTableCellView


@property (nonatomic, retain) RZAppDelegate *appDelegate;

@property (nonatomic, retain) IBOutlet NSButton *speakButton;
@property (nonatomic, retain) IBOutlet NSButton *removeButton;

@end
