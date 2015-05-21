//
//  Play.h
//  Chinese Poker
//
//  Created by Tim Chang on 5/10/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Play : NSObject

typedef NS_ENUM(NSUInteger, PlayType) {
    single,
    deuce,
    triple,
    set
};

typedef NS_ENUM(NSUInteger, SetType) {
    straight,
    flush,
    fullHouse,
    fourOfAKind,
    straightFlush
};

- (instancetype)initWithChosenCards: (NSArray *)chosenCards;

@property (nonatomic) NSArray *chosenCardsInPlay;

@property (nonatomic) NSUInteger numberOfCards;

@property (nonatomic) PlayType playType;

@property (nonatomic) NSUInteger playValue;

@property (nonatomic, getter=isValid) BOOL playValidness;

@property (nonatomic) SetType setType;




@end
