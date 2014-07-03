//
//  RZSpeechButton.h
//  BullshitBox
//
//  Created by Ambroise Maupate on 03/07/2014.
//  Copyright (c) 2014 REZO ZERO. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RZSpeechButton : NSButton
{
    NSString* speechedSentence;
}

@property (nonatomic, retain) NSString* speechedSentence;

@end
