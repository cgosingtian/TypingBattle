//
//  KLBAppDelegate.h
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/24/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

/*
 * Typing Battle:
 *  The player must be able to type the word displayed within the time limit
 *   Success grants 1 point
 *   Failure grants -1 point
 *  
 
 
 */

#import <Cocoa/Cocoa.h>
#import "KLBPlayerData.h"

@interface KLBAppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSTextField *labelQuizStringDisplay;
    IBOutlet NSTextField *labelTimeUntilEnd;
    IBOutlet NSTextField *labelScore;
    IBOutlet NSTextField *tfAnswerField;
    
    KLBPlayerData *player;
}

@property (assign) IBOutlet NSWindow *window;

- (void)setupIBNotifications;
- (IBAction)submitTypedChars:(id)sender;
- (void)changeQuizString:(id)sender;

@end
