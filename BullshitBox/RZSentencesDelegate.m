//
//  RZSentencesDelegate.m
//  BullshitBox
//
//  Created by Ambroise Maupate on 23/09/2014.
//  Copyright (c) 2014 REZO ZERO. All rights reserved.
//

#import "RZSentencesDelegate.h"

#import "RZAppDelegate.h"
#import "RZSpeechButton.h"
#import "RZDeleteSentenceButton.h"

@implementation RZSentencesDelegate

- (void)awakeFromNib {
    [super awakeFromNib];
    _appDelegate = (RZAppDelegate *)[NSApp delegate];
    NSLog(@"Finish loading sentences delegate.");
}

// The only essential/required tableview dataSource method
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    
    NSLog(@"%i sentences.", (int)[_appDelegate.sentences count]);
    return [_appDelegate.sentences count];
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    
    NSString *identifier = [tableColumn identifier];
    NSString *sentence = [_appDelegate.sentences objectAtIndex:row];

    NSTableCellView *newCell = [tableView makeViewWithIdentifier:identifier owner:self];
    [newCell.textField setStringValue:@""];
    
    NSUInteger deleteWidth = 38;
    CGRect viewDeleteRect = CGRectMake(0, 0, deleteWidth, deleteWidth);
    CGRect viewRect = CGRectMake(0, 0, 100, 0);
    
    
    
    //  NSLog(@"My row is %i and my text is %@. Column %@", (long)row, sentence, identifier);
    /*
     * Speak button
     */
    RZSpeechButton *myButton = [[RZSpeechButton alloc] initWithFrame: viewRect];
    //RZSpeechButton *myButton = [[RZSpeechButton alloc] init];
    [myButton setBezelStyle:NSRoundedBezelStyle];
    [myButton setButtonType:NSMomentaryPushInButton];
    [myButton setTarget:_appDelegate];
    [myButton setAction:@selector(speakFromButton:)];
    [myButton setTitle: sentence];
    [myButton setFont:[NSFont fontWithName:@"Arial" size:11]];
    myButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [newCell addSubview: myButton];
    
    myButton.speechedSentence = sentence;
    
    
    /*
     * Delete button
     */
    RZDeleteSentenceButton *myDeleteButton = [[RZDeleteSentenceButton alloc] initWithFrame: viewDeleteRect];
    //RZDeleteSentenceButton *myDeleteButton = [[RZDeleteSentenceButton alloc] init];
    //[myDeleteButton setBezelStyle:NSSmallSquareBezelStyle];
    [myDeleteButton setBezelStyle: NSRoundRectBezelStyle];
    [myDeleteButton setImage: [ NSImage imageNamed: NSImageNameRemoveTemplate ]];
    [myDeleteButton setButtonType:NSMomentaryPushInButton];
    [myDeleteButton setTarget:_appDelegate];
    [myDeleteButton setAction:@selector(removeButton:)];
    [myDeleteButton setTitle:@""];
    
    [newCell addSubview: myDeleteButton];
    
    myDeleteButton.refButton = myButton;
    myDeleteButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    /*
     *  Constraints
     */
    NSDictionary *viewsDictionary =
    NSDictionaryOfVariableBindings(myButton, myDeleteButton);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[myButton]-10-[myDeleteButton(20)]-10-|"
                                                                   options:0 metrics:nil views:viewsDictionary];
    [newCell addConstraints:constraints];
    
    NSArray *Vconstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[myButton]-3-|"
                                                                   options:0 metrics:nil views:viewsDictionary];
    [newCell addConstraints:Vconstraints];
    
    NSArray *V2constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[myDeleteButton]-3-|"
                                                                    options:0 metrics:nil views:viewsDictionary];
    [newCell addConstraints:V2constraints];
    
    
    // Return the result
    return newCell;
    
}


@end
