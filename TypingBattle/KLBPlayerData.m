//
//  KLBPlayerData.m
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/24/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBPlayerData.h"
#import "KLBConstants.h"

@implementation KLBPlayerData

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

#pragma mark - Initializers

- (id) initWithScore:(NSInteger)s
{
    self = [super init];
    
    if (self)
    {
        score = s;
        
        //Listen for score updates
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateScore:)
                                                     name:KLB_SUBMIT_CORRECT
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateScore:)
                                                     name:KLB_SUBMIT_WRONG
                                                   object:nil];
    }
    
    return self;
}

- (id) init
{
    return [self initWithScore:KLB_SCORE_STARTING];
}

#pragma mark - Getters/Setters
- (void) setScore:(NSInteger) s
{
    score += s;
    [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SCORE_UPDATED object:nil];
}

- (void) setScoreZero
{
    score = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SCORE_UPDATED object:nil];
}

- (NSInteger) score
{
    return score;
}

- (void) updateScore:(NSNotification *)notice
{
    NSLog(@"%@: Entered updateScore in player", [notice name]);
    //if ([[[notice userInfo] valueForKey:ANSWER_KEY] isEqualToValue:[NSNumber numberWithInt:SCORE_CORRECT]])
    if ([[notice name] isEqualToString:KLB_SUBMIT_CORRECT])
    {
        NSLog(@"attempting to increase score...");
        [self setScore:KLB_SCORE_CORRECT];
    }
    else
    {
        NSLog(@"attempting to reduce score...");
        [self setScore:KLB_SCORE_WRONG_PENALTY];
    }
}

- (void) resetValues
{
    [self setScoreZero];
}

@end
