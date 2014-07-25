//
//  KLBHighScoreManager.m
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/25/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBHighScoreManager.h"

NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [pathList objectAtIndex:0];
}

NSString *highScorePath()
{
    return [NSString stringWithFormat:@"%@",[docPath() stringByAppendingPathComponent:@"highscore.txt"]];
}

@implementation KLBHighScoreManager

+ (bool)verifyHighScore:(NSInteger)score WriteToFile:(bool)write
{
    NSInteger score2 = [self readScoreFromFile];
    NSLog (@"Comparing %ld to score from file %ld",score,score2);
    if (score > score2)
    {
        if (write)
        {
            [self saveScoreToFile:score];
        }
        return true;
    }
    else
    {
        return false;
    }
}

+ (void)saveScoreToFile:(NSInteger)score
{
    NSString *msg = [NSString stringWithFormat:@"%ld",(long)score];
    [msg writeToFile:highScorePath() atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [msg release];
}

+ (NSInteger)readScoreFromFile
{
    NSError *error=nil;
    NSString *msg = [NSString stringWithContentsOfFile:highScorePath()
                                              encoding:NSUTF8StringEncoding
                                                 error:&error];
    if (error)
    {
        NSString *defaultFileMessage = @"0";
        NSLog(@"Read file error. Creating empty file, then returning 0. %@", [error description]);
        NSData *fileContents = [defaultFileMessage dataUsingEncoding:NSUTF8StringEncoding];
        [[NSFileManager defaultManager] createFileAtPath:highScorePath()
                                                contents:fileContents
                                              attributes:nil];
        return 0;
    }
    
    NSInteger score = [msg integerValue];
    
    [error release];
    [msg release];
    
    return score;
}

@end
