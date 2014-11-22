//
//  RZSentenceView.m
//  BullshitBox
//
//  Created by Ambroise Maupate on 22/11/2014.
//  Copyright (c) 2014 REZO ZERO. All rights reserved.
//

#import "RZSentenceView.h"

#import "RZAppDelegate.h"

@implementation RZSentenceView

- (void)awakeFromNib {
    [super awakeFromNib];
    _appDelegate = (RZAppDelegate *)[NSApp delegate];
    NSLog(@"Finish loading sentences delegate.");
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (IBAction)onSentenceClicked:(id)sender {
    NSString *sentence = self.speakButton.title;
    [_appDelegate.synth startSpeakingString:sentence];
}
- (IBAction)onRemovedClicked:(id)sender
{
    for(id item in _appDelegate.sentences) {
        if([item isEqual:(self.speakButton.title)]) {
            [_appDelegate.sentences removeObject:item];
            break;
        }
    }
    
    [_appDelegate saveSentences];
    [_appDelegate.tableView reloadData];
}

@end
