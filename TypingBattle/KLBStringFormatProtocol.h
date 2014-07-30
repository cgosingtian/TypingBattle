//
//  KLBStringFormatProtocol.h
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/28/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLBConstants.h"

@protocol KLBStringFormatProtocol <NSObject>

-(void)stringComparisonResult:(bool)result;

@end

@interface KLBStringFormatProtocol : NSObject

@property (assign,nonatomic) id<KLBStringFormatProtocol> delegate;

-(void)compareTwoStrings:(NSString *)string1 AndString:(NSString *)string2;

@end

