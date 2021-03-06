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
#import "KLBHighScoreManager.h"
#import "KLBStringFormatProtocol.h"

@implementation KLBAppDelegate

@synthesize formattingDelegate;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [labelQuizStringDisplay release];
    [labelTimeUntilEnd release];
    [labelScore release];
    [labelHighestScore release];
    [tfAnswerField release];
    [player release];
    [timer release];
    [formattingDelegate release];
    [self release];
    
    // avoid dangling pointers by setting to nil
    labelQuizStringDisplay = nil;
    labelTimeUntilEnd = nil;
    labelScore = nil;
    labelHighestScore = nil;
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
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkSubmittedString:)
                                                 name:KLB_SUBMIT_NOTIFICATION
                                               object:nil];*/
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
    /*NSDictionary * message = @{KLB_ANSWER_KEY : [tfAnswerField stringValue]};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SUBMIT_NOTIFICATION
                                                        object:nil
                                                      userInfo:message];*/
    
    [self delegateStringComparison:[tfAnswerField stringValue] AndString:[labelQuizStringDisplay stringValue]];
}

- (void)changeQuizString:(id)sender
{
    [labelQuizStringDisplay setStringValue:[NSString stringWithFormat:@"%@",[KLBWordManager getRandomWordEasy]]];

    // empty the answer field's contents
    [self focusAnswerField:true];
}

/*-(void)checkSubmittedString:(NSNotification *)notification
{
    if ([[labelQuizStringDisplay stringValue] isEqualToString:[tfAnswerField stringValue]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_CHANGE_QUIZ_STRING_NOTICE
                                                            object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SUBMIT_CORRECT
                                                            object:nil];
        // empty the answer field's contents
        [self focusAnswerField:true];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SUBMIT_WRONG
                                                            object:nil];
        // we don't empty the answer field's contents if wrong to allow quick editing
    }
}*/

-(void)updateScore
{
    [labelScore setStringValue:[NSString stringWithFormat:@"%ld",[player score]]];
}

-(void)updateTime
{
    [labelTimeUntilEnd setStringValue:[NSString stringWithFormat:@"%d",[timer currentTimeInt]]];
}

-(bool)checkAndUpdateHighScore
{
    return [KLBHighScoreManager verifyHighScore:[player score] WriteToFile:YES];
}

-(void)endGame
{
    // keep a reference to self so that we don't deallocate
    [self retain];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KLB_STOP_TIMER
                                                        object:nil];
    
    //prevent input to answer text field
    [self setAnswerFieldStatus:false];
    [self focusAnswerField:false];
    
    bool highScore = [self checkAndUpdateHighScore];
    
    NSString *scoreMessage = @"";
    if (highScore)
    {
        scoreMessage = [NSString stringWithFormat:@"HIGH SCORE! Your score was %ld", (long)[player score]];
        [labelHighestScore setStringValue:[NSString stringWithFormat:@"%ld", (long)[player score]]];
    }
    else
    {
        scoreMessage = [NSString stringWithFormat:@"Your score was %ld", (long)[player score]];
    }
    
    //show ending alert; run this on the main queue to prevent occasional crashing
    dispatch_async(dispatch_get_main_queue(), ^{
            NSAlert *alert = [[NSAlert alloc] init];
            [alert addButtonWithTitle:@"New Game"];
            [alert addButtonWithTitle:@"Exit"];
            [alert setMessageText:@"GAME OVER"];
            [alert setInformativeText:[NSString stringWithFormat:@"%@",scoreMessage]];
            [alert setAlertStyle:NSWarningAlertStyle];
        
            if ([alert runModal] == NSAlertFirstButtonReturn) {
                [self newGame]; // new game
            } else [[NSApplication sharedApplication] terminate:nil]; // exit
            [scoreMessage release];
            [alert release];
        });
}

-(void) newGame
{
    [self changeQuizString:nil]; // display a quiz word
    [labelHighestScore setStringValue:
        [NSString stringWithFormat:@"%ld", [KLBHighScoreManager readScoreFromFile]]];
    if (!player)
    {
        player = [[KLBPlayerData alloc] init];
    } else [player resetValues];
    
    if (!timer)
    {
        timer = [[KLBTimer alloc]init];
    } else [timer resetValues];
    
    //activate answer text field
    [self setAnswerFieldStatus:true];
    [self focusAnswerField:true];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KLB_START_TIMER
                                                        object:nil];
}

- (void)focusAnswerField:(bool)focus
{
    [tfAnswerField setStringValue:@""];
    if (focus)
    {
        [tfAnswerField becomeFirstResponder];
    } else
    {
        [[tfAnswerField window] makeFirstResponder:nil];
    }
}

- (void)setAnswerFieldStatus:(bool)flag
{
    [tfAnswerField setSelectable:flag];
    [tfAnswerField setEditable:flag];
}

#pragma mark - KLBStringFormatProtocol

-(void)stringDidCompareWithResult:(bool)result
{
    //NSLog(@"KLBStringFormatProtocol was followed!");
    if (result)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_CHANGE_QUIZ_STRING_NOTICE
                                                            object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SUBMIT_CORRECT
                                                            object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SUBMIT_WRONG
                                                            object:nil];
    }
}

-(void)delegateStringComparison:(NSString *)string1
               AndString:(NSString *)string2
{
    if (!formattingDelegate)
    {
        formattingDelegate = [[KLBStringSameComparisonDelegate alloc] init];
    }
    [formattingDelegate setDelegate:self];
    
    if ([formattingDelegate respondsToSelector:@selector(compareTwoStrings:AndString:)])
    {
       [formattingDelegate compareTwoStrings:string1 AndString:string2];
    }
}

@end
