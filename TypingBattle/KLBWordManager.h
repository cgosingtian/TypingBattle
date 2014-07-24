//
//  KLBWordManager.h
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/24/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLBWordManager : NSObject

+(NSArray *)easyWordList;

//-(id)initWithWords:(NSArray *)w;
-(void)dealloc;

+(NSString *)getRandomWordEasy;
+(bool)checkInListEasy:(NSString *)item;

@end
