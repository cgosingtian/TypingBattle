//
//  KLBWordManager.m
//  TypingBattle
//
//  Created by Chase Gosingtian on 7/24/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBWordManager.h"

@implementation KLBWordManager

//- (id)initWithWords:(NSArray *)w
//{
//    self = [super init];
//    if (self)
//    {
//        for (NSInteger i = 0; i < [w count]; i++)
//        {
//            [words addObject:[w objectAtIndex:i]];
//        }
//    }
//    return self;
//}
//
//- (id)init
//{
//    return [self initWithWords:[NSArray array]];
//}
//

- (void)dealloc
{
    [self release];
    [super dealloc];
}

#pragma mark - Getters/Setters
//- (NSString *)getRandomWord
//{
//    if ([words count] > 0)
//    {
//        return [NSString stringWithFormat:@"%@",
//                [words objectAtIndex:arc4random_uniform([words count])]];
//    }
//    else
//    {
//        NSLog(@"Trying to get a random word from an empty word list!");
//        return @"";
//    }
//}

+ (NSString *)getRandomWordEasy
{
    return [NSString stringWithFormat:@"%@",
                [[[self class]easyWordList] objectAtIndex:arc4random_uniform([[[self class]easyWordList] count])]];
}

+ (NSArray *)easyWordList
{
    static NSArray *wordsDefaultEasy;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        wordsDefaultEasy = @[@"Jay",
//                             @"Chase",
//                             @"Kay",
//                             @"Robert",
//                             @"Geno",
//                             @"Keith",
//                             @"Gerald",
//                             @"Jay Ar",
//                             @"Pam",
//                             @"Lem",
//                             @"Romz",
//                             @"Tan",
//                             @"Joseph",
//                             @"Jeszy",
//                             @"Charm",
//                             @"Yeo"];
//    });
    
    wordsDefaultEasy = @[@"Jay",
                         @"Chase",
                         @"Kay",
                         @"Robert",
                         @"Geno",
                         @"Keith",
                         @"Gerald",
                         @"Jay Ar",
                         @"Pam",
                         @"Lem",
                         @"Romz",
                         @"Tan",
                         @"Joseph",
                         @"Jeszy",
                         @"Charm",
                         @"Yeo"];


    return wordsDefaultEasy;
}

+(bool)checkInListEasy:(NSString *)item
{
    if ([[[self class]easyWordList] containsObject:item])
        return true;
    else return false;
}

@end
