//
//  KLBStringFormatProtocol.h
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/28/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLBConstants.h"

@class KLBStringFormatter;

@protocol KLBStringFormatProtocol <NSObject>

-(bool)compareTwoStrings:(NSString *)string1 AndString:(NSString *)string2;

@end

@interface KLBStringFormatter : NSObject

@property (assign,nonatomic) id<KLBStringFormatProtocol> delegate;

@end

@implementation KLBStringFormatter : NSObject

@synthesize delegate;

-(bool)compareTwoStrings:(NSString *)string1 AndString:(NSString *)string2
{
    if ([string1 isEqualToString:string2])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_CHANGE_QUIZ_STRING_NOTICE
                                                            object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SUBMIT_CORRECT
                                                            object:nil];
        return true;
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KLB_SUBMIT_WRONG
                                                            object:nil];
        // we don't empty the answer field's contents if wrong to allow quick editing
        return false;
    }
}

- (void)setDelegate:(id<KLBStringFormatProtocol>)aDelegate
{
    if (delegate != aDelegate)
        delegate = aDelegate;
}

@end