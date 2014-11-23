//
//  RZSentencesDelegate.m
//  BullshitBox
//
//  Created by Ambroise Maupate on 23/09/2014.
//  Copyright (c) 2014 REZO ZERO. All rights reserved.
//

#import "RZSentencesDelegate.h"

#import "RZAppDelegate.h"
#import "RZSentenceView.h"

@implementation RZSentencesDelegate

- (void)awakeFromNib {
    [super awakeFromNib];
    _appDelegate = (RZAppDelegate *)[NSApp delegate];
    //NSLog(@"Finish loading sentences delegate.");
}

// The only essential/required tableview dataSource method
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    
    //NSLog(@"%i sentences.", (int)[_appDelegate.sentences count]);
    return [_appDelegate.sentences count];
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    [tableView setTarget:self];
    
    RZSentenceView *newCell = [tableView makeViewWithIdentifier:[tableColumn identifier]
                                                           owner:self];
    
    [[newCell speakButton] setTitle:[_appDelegate.sentences objectAtIndex:row]];

    
    // Return the result
    return newCell;
}


@end
