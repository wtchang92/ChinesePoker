//
//  ChinesePokerGame.m
//  Chinese Poker
//
//  Created by Tim Chang on 5/8/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import "ChinesePokerGame.h"
@interface ChinesePokerGame()
@property (nonatomic, strong) NSMutableArray *gameDeck;
@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic) NSUInteger roundNumber;
@property (nonatomic, strong) Player *lastRoundWinner;
@property (nonatomic) BOOL roundIsActive;
@property (nonatomic) Player *playerAtTurn;
@property (nonatomic) NSArray *currentRoundOrder;
@property (strong, nonatomic) NSMutableArray *cardsPile;

@end

@implementation ChinesePokerGame

- (NSMutableArray *)cardsPile
{
    if (!_cardsPile) _cardsPile = [[NSMutableArray alloc] init]; // lazy instantiation
    return _cardsPile;
}

- (NSMutableArray *)gameDeck
{
    if (!_gameDeck)_gameDeck = [[NSMutableArray alloc]init];
    return _gameDeck;
}
- (NSMutableArray *)players
{
    if (!_players)_players = [[NSMutableArray alloc]init];
    return _players;
}

- (instancetype)initWithPlayers: (NSInteger)count usingDeck:(Deck *)deck {

    self = [super init];
    
    
    
    if (self) {
    
        for (int i = 0;i < 52; i++){
        
            Card *card = [deck drawRandomCard];
            if (card) {
            
                [self.gameDeck addObject:card];
                //NSLog(@"test: %@", self.gameDeck);
                
            }
            else {
            
                self = nil;
                break;
                
            }
        
        }
        
        self.numOfPlayers = count;
        for (int i = 0; i < self.numOfPlayers; i++) {
            Player *player = [[Player alloc]init];
            [self.players addObject:player];
        }
    
    }
    return self;
}

- (NSMutableArray *) dealHand: (NSUInteger)countOfCards startRange:(NSUInteger) startRange;
{
    NSMutableArray *dealtHand;
    NSRange theRange;
    theRange.location = startRange-1;
    theRange.length = countOfCards;
    
    
    //NSLog(@"hiiiiii: %@", [[self.gameDeck objectAtIndex:1] contents]);
    dealtHand = [[self.gameDeck subarrayWithRange:NSMakeRange(startRange, countOfCards)] mutableCopy];
    
    return dealtHand;
}

- (void) dealHandToPlayers
{
    NSUInteger countOfCards = 52/self.numOfPlayers;
    NSUInteger count = 0;
    
    for (Player *player in self.players) {
        player.hand = [self dealHand:countOfCards startRange:count  ];
        count = count +13;
        NSLog(@"%lu", (unsigned long)count);
    }

}

- (NSMutableArray *) showPlayers {

    return self.players;

}

- (void) startRound {
    if (!self.lastRoundWinner) {
        NSLog(@"Last round winner is nobody");
    }
    GameRound *round = [[GameRound alloc]initWithLastRoundWinner:self.lastRoundWinner players:self.players];
    
    self.roundIsActive = YES;
    self.currentRoundOrder = [round playerOrder];
    NSUInteger playerStatusHelperCount = 0;
    for (Player *player in self.currentRoundOrder) {
        if (playerStatusHelperCount == 0) {
        
            player.playerStatus = (Status)isAtTurn;
            
        } else {
        
            player.playerStatus = (Status)standBy;
        }
        playerStatusHelperCount++;
    }
   
}


- (void)addCardsToPile:(NSMutableArray *)cardsToAdd
{
    [self addCardsToPile:cardsToAdd atTop:NO];
}

- (void)addCardsToPile:(Card *)cardsToAdd atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cardsPile insertObject:cardsToAdd atIndex:0];
    } else {
        [self.cardsPile addObject:cardsToAdd];
    }
}



- (NSArray *) testShowRoundOrder {
    
    NSArray *returnOrder = self.currentRoundOrder;

    return returnOrder;
}
    


    



@end
