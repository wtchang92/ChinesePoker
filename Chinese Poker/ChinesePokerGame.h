//
//  ChinesePokerGame.h
//  Chinese Poker
//
//  Created by Tim Chang on 5/8/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
#import "Player.h"
#import "GameRound.h"


@interface ChinesePokerGame : NSObject

- (instancetype)initWithPlayers: (NSInteger)count usingDeck:(Deck *)deck;

@property (nonatomic) NSInteger numOfPlayers;

- (void) dealHandToPlayers;

- (void) startRound;


- (void)addCardsToPile:(NSArray *)cardsToAdd atTop:(BOOL)atTop;
- (void)addCardsToPile:(NSArray *)cardsToAdd;


- (NSMutableArray *) showPlayers;
- (NSArray *) testShowRoundOrder;

@end
