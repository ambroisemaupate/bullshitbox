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
}


- (IBAction)onSentenceClicked:(id)sender {
    NSString *sentence = self.speakButton.title;
    
    NSDataDetector *detect = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [detect matchesInString:sentence options:0 range:NSMakeRange(0, [sentence length])];
 
    if ([matches count] > 0) {
        // Found an url, launch it in default browser
        NSURL *url = [[matches objectAtIndex:0] URL];
        [[NSWorkspace sharedWorkspace] openURL:url];
    } else {
        // No url just speek it
        [_appDelegate.synth startSpeakingString:sentence];
    }
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
