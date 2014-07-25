//
//  KLBWordManager.h
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/24/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSArray *wordsDefaultEasy;

@interface KLBWordManager : NSObject

- (void)dealloc;
+ (NSArray *)easyWordList;
+ (NSString *)getRandomWordEasy;
+ (bool)checkInListEasy:(NSString *)item;

@end
