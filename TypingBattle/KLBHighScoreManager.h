//
//  KLBHighScoreManager.h
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/25/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *docPath();
NSString *highScorePath();

@interface KLBHighScoreManager : NSObject

+ (bool)verifyHighScore:(NSInteger)score WriteToFile:(bool)write;
+ (void)saveScoreToFile:(NSInteger)score;
+ (NSInteger)readScoreFromFile;

@end
