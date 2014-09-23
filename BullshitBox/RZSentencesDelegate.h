//
//  RZSentencesDelegate.h
//  BullshitBox
//
//  Created by Ambroise Maupate on 23/09/2014.
//  Copyright (c) 2014 REZO ZERO. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "RZAppDelegate.h"

@interface RZSentencesDelegate : NSObject<NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, retain) IBOutlet NSTableView *tableView;

@property (nonatomic, retain) RZAppDelegate *appDelegate;

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;

@end
