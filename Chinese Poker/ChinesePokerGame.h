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

typedef NS_ENUM(NSUInteger, GameMode) {
    singlePlayer,
    multiPlayer
};

- (instancetype)initWithPlayers: (NSInteger)count usingGameMode: (GameMode)mode usingDeck:(Deck *)deck;

@property (nonatomic) NSInteger numOfPlayers;

- (void) dealHandToPlayers;

- (void) startRound;
- (void) moveTurnInRound;


- (BOOL) enterPlayToGame: (Player *)player;
- (void) playerIsAtTurnCallPass;
@property (nonatomic) NSArray *currentRoundOrder;
@property (nonatomic) BOOL gameIsActive;
@property (strong, nonatomic) GameRound *currentRound;


- (void)addCardsToPile:(NSMutableArray *)cardsToAdd atTop:(BOOL)atTop;
- (void)addCardsToPile:(NSMutableArray *)cardsToAdd;

- (void)addPlayToPile:(Play *)playToAdd atTop:(BOOL)atTop;
- (void)addPlayToPile:(Play *)playToAdd;
- (NSString *)showPileTop;


- (NSMutableArray *) showPlayers;
- (NSArray *) testShowRoundOrder;

- (Player *) getWinnerOfTheGame;
- (Play *)showPileTopPlay;

@end
