//
//  KLBStringFormatProtocol.m
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/28/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLBStringFormatProtocol.h"
#import "KLBConstants.h"

@implementation KLBStringFormatProtocol : NSObject

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