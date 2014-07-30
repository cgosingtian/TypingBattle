//
//  KLBStringSameComparisonDelegate.h
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/30/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLBStringFormatProtocol.h"

@interface KLBStringSameComparisonDelegate : NSObject

@property (assign,nonatomic) id<KLBStringFormatProtocol> delegate;

-(void)compareTwoStrings:(NSString *)string1 AndString:(NSString *)string2;

@end
