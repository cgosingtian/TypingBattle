//
//  KLBPlayerData.h
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/24/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLBPlayerData : NSObject
{
    NSInteger score;
}

- (id)initWithScore:(NSInteger)s;

- (void) setScore:(NSInteger)s;
- (NSInteger) getScore;

- (void) dealloc;

@end
