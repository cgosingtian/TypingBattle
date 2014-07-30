//
//  KLBStringSameComparisonDelegate.m
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/30/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBStringSameComparisonDelegate.h"

@implementation KLBStringSameComparisonDelegate

@synthesize delegate;

-(void)compareTwoStrings:(NSString *)string1 AndString:(NSString *)string2
{
    if ([string1 isEqualToString:string2])
    {
        [delegate stringComparisonResult:YES];
    }
    else
    {
        [delegate stringComparisonResult:NO];
    }
}

-(id)delegate
{
    return delegate;
}

- (void)setDelegate:(id<KLBStringFormatProtocol>)aDelegate
{
    if (delegate != aDelegate)
        delegate = aDelegate;
}

@end