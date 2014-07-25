//
//  KLBTimer.h
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/24/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLBConstants.h"

@interface KLBTimer : NSObject
{
    NSThread *timer;
    int currentTime;
    bool startTimer;
}
- (void)dealloc;
- (int)currentTimeInt;
- (void)startTimer;
- (void)stopTimer;
- (void)resetValues;
- (void)countDown;
- (void)checkEndTime;
@end
