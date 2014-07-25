//
//  KLBTimer.m
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/24/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBTimer.h"
#import "KLBConstants.h"

@implementation KLBTimer

- (void)dealloc
{
    [timer release];
    timer = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self resetValues];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(stopTimer)
                                                     name:KLB_STOP_TIMER
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(startTimer)
                                                     name:KLB_START_TIMER
                                                   object:nil];
    }
    
    return self;
}

-(int)currentTimeInt
{
    return currentTime;
}

-(void)startTimer
{
    startTimer=true;
    [NSThread detachNewThreadSelector:@selector(countDown) toTarget:self withObject:nil];
}

-(void)stopTimer
{
    startTimer = false;
}

-(void)resetValues
{
    currentTime = KLB_TIME_LIMIT_SECONDS;
    startTimer = false;
}

-(void)countDown
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; // Top-level pool
    
    // Do thread work here.
    while (startTimer)
    {
        currentTime--;
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_TIME_UPDATED object:nil];
        usleep(1000000);
        
        [self checkEndTime];
    }
    
    [pool release];  // Release the objects in the pool.
}

-(void)checkEndTime
{
    if (currentTime <= 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_TIME_DONE object:nil];
    }
}

@end
