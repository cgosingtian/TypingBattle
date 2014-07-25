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
#import "KLBTimer.h"

@implementation KLBAppDelegate

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [labelQuizStringDisplay release];
    [labelTimeUntilEnd release];
    [labelScore release];
    [tfAnswerField release];
    [player release];
    [timer release];
    [self release];
    
    // the reason why we nil these objects is to prevent crashing
    // in case these objects are referred to - doing something to
    // nil does nothing in objective-c
    labelQuizStringDisplay = nil;
    labelTimeUntilEnd = nil;
    labelScore = nil;
    tfAnswerField = nil;
    player = nil;
    timer = nil;
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application    
    [self setupIBNotifications];
    
    //Activate the window of our application so that the alert below will not be minimized
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"New Game"];
        [alert addButtonWithTitle:@"Exit"];
        [alert setMessageText:@"WELCOME TO TYPING BATTLE"];
        [alert setInformativeText: [NSString stringWithFormat:@"Type the words that you see in the text field within the time limit. Press ENTER to submit."]];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        if ([alert runModal] == NSAlertFirstButtonReturn) {
            [self newGame];
        } else [[NSApplication sharedApplication] terminate:nil];
        [alert release];
    });
}

-(void)setupIBNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeQuizString:)
                                                 name:KLB_CHANGE_QUIZ_STRING_NOTICE
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkSubmittedString:)
                                                 name:KLB_SUBMIT_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateScore)
                                                 name:KLB_SCORE_UPDATED
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTime)
                                                 name:KLB_TIME_UPDATED
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(endGame)
                                                 name:KLB_TIME_DONE
                                               object:nil];
}

-(IBAction)submitTypedChars:(id)sender
{
    NSDictionary * message = @{KLB_ANSWER_KEY : [tfAnswerField stringValue]};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SUBMIT_NOTIFICATION
                                                        object:nil
                                                      userInfo:message];
}

- (void)changeQuizString:(id)sender
{
    [labelQuizStringDisplay setStringValue:[NSString stringWithFormat:@"%@",[KLBWordManager getRandomWordEasy]]];
}

-(void)checkSubmittedString:(NSNotification *)notification
{
    if ([[labelQuizStringDisplay stringValue] isEqualToString:[tfAnswerField stringValue]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_CHANGE_QUIZ_STRING_NOTICE
                                                            object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SUBMIT_CORRECT
                                                            object:nil];
        [tfAnswerField setStringValue:@""];
        [tfAnswerField becomeFirstResponder];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SUBMIT_WRONG
                                                            object:nil];
    }
}

-(void)updateScore
{
    [labelScore setStringValue:[NSString stringWithFormat:@"%ld",(long)[player score]]];
}

-(void)updateTime
{
    [labelTimeUntilEnd setStringValue:[NSString stringWithFormat:@"%ld",(long)[timer currentTimeInt]]];
}

-(void)endGame
{
    // keep a reference to self so that we don't deallocate
    [self retain];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KLB_STOP_TIMER
                                                        object:nil];
    
    //prevent input
    [tfAnswerField setSelectable:false];
    [tfAnswerField setEditable:false];
    [[tfAnswerField window] makeFirstResponder:nil];
    
    //show ending alert; run this on the main queue to prevent occasional crashing
    dispatch_async(dispatch_get_main_queue(), ^{
            NSAlert *alert = [[NSAlert alloc] init];
            [alert addButtonWithTitle:@"New Game"];
            [alert addButtonWithTitle:@"Exit"];
            [alert setMessageText:@"GAME OVER"];
            [alert setInformativeText:[NSString stringWithFormat:@"Your score was %ld",(long)[player score]]];
            [alert setAlertStyle:NSWarningAlertStyle];
        
            if ([alert runModal] == NSAlertFirstButtonReturn) {
                [self newGame]; // new game
            } else [[NSApplication sharedApplication] terminate:nil]; // exit
            [alert release];
        });
    }

-(void) newGame
{
    [self changeQuizString:nil];
 
    if (!player)
    {
        player = [[KLBPlayerData alloc] init];
    } else [player resetValues];
    
    if (!timer)
    {
        timer = [[KLBTimer alloc]init];
    } else [timer resetValues];
    
    [tfAnswerField setSelectable:true];
    [tfAnswerField setEditable:true];
    [tfAnswerField setStringValue:@""];
    [tfAnswerField becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KLB_START_TIMER
                                                        object:nil];
}

@end
