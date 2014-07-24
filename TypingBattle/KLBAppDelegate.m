//
//  KLBAppDelegate.m
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/24/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBAppDelegate.h"
#import "KLBPlayerData.h"
#import "KLBWordManager.h"
#import "KLBConstants.h"

@implementation KLBAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application    
    
    [self setupIBNotifications];
    
    [self changeQuizString:nil];
    
    
    player = [[KLBPlayerData alloc] init];
    NSLog(@"%ld",(long)[player getScore]);
}

-(IBAction)submitTypedChars:(id)sender
{
    NSDictionary * message = @{ANSWER_KEY : [tfAnswerField stringValue]};
    
    NSLog(@"Trying to send answer \"%@\"...",[message valueForKey:ANSWER_KEY]);
    
    [[NSNotificationCenter defaultCenter]
        postNotificationName:SUBMIT_NOTIFICATION
                      object:nil
                    userInfo:message];
}
- (void)changeQuizString:(id)sender
{
    [labelQuizStringDisplay setStringValue:[NSString stringWithFormat:@"%@",[KLBWordManager getRandomWordEasy]]];
}

-(void)setupIBNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeQuizString:)
                                                 name:KLB_CHANGE_QUIZ_STRING_NOTICE
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkSubmittedString:)
                                                 name:SUBMIT_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateScore)
                                                 name:SCORE_UPDATED
                                               object:nil];
}
-(void)checkSubmittedString:(NSNotification *)notification
{
    NSLog(@"Checking submitted string...");
    if ([[labelQuizStringDisplay stringValue] isEqualToString:[tfAnswerField stringValue]])
    {
        NSLog(@"submitted string matched!");
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_CHANGE_QUIZ_STRING_NOTICE object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:SUBMIT_CORRECT object:nil];
        [tfAnswerField setStringValue:@""];
        [tfAnswerField becomeFirstResponder];
    }
    else
    {
        NSLog(@"submitted string didn't match!");
        [[NSNotificationCenter defaultCenter] postNotificationName:SUBMIT_WRONG object:nil];
    }
}
-(void)updateScore
{
    NSLog(@"Updating score visually");
    [labelScore setStringValue:[NSString stringWithFormat:@"%ld",(long)[player getScore]]];
}

// dealloc: remove all observers

@end
