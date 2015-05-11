//
//  PlayingCard.h
//  Chinese Poker
//
//  Created by Tim Chang on 5/6/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card


//typedef NS_ENUM(NSInteger, Suit) {
//    diamond,
//    clover,
//    heart,
//    spade
//};
//@property (nonatomic) Suit *cardSuit;

@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
