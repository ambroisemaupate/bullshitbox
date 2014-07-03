//
//  RZDeleteSentenceButton.h
//  BullshitBox
//
//  Created by Ambroise Maupate on 03/07/2014.
//  Copyright (c) 2014 REZO ZERO. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RZSpeechButton.h"

@interface RZDeleteSentenceButton : NSButton
{
    RZSpeechButton* refButton;
}

@property (nonatomic, retain) RZSpeechButton* refButton;

@end
