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
@property (nonatomic) Player *playerAtTurn;

@property (strong, nonatomic) NSMutableArray *cardsPile;
@property (strong, nonatomic) GameRound *currentRound;

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
    if (self.lastRoundWinner) {
        NSLog(@"Last round winner is: %@", self.lastRoundWinner);
    }
    self.currentRound = [[GameRound alloc]initWithLastRoundWinner:self.lastRoundWinner players:self.players];
    //GameRound *round = [[GameRound alloc]initWithLastRoundWinner:self.lastRoundWinner players:self.players];
    
    self.roundIsActive = YES;
    self.currentRoundOrder = [self.currentRound playerOrder];
    NSUInteger playerStatusHelperCount = 0;
    for (Player *player in self.currentRoundOrder) {
        if (playerStatusHelperCount == 0) {
        
            player.playerStatus = (Status)isAtTurn;
            if (player.playerStatus == (Status)isAtTurn) {
                NSLog(@"round winner go first message");
            }
            
        } else {
        
            player.playerStatus = (Status)standBy;
        }
        playerStatusHelperCount++;
    }
   
}


- (BOOL) enterPlayToGame: (Player *)player {
    Play *enteredPlay = [player makePlay];
    if (enteredPlay) {
        NSLog(@"the play exist");
    }
    BOOL isSuccessfulPlay = NO;
    NSLog(@"again this should print null from game class: %@", enteredPlay);
    Play *pileTop = [self.cardsPile firstObject];
    if (pileTop) {
        NSLog(@"pile top exist");
        if (enteredPlay && (enteredPlay.playValue > pileTop.playValue) && self.currentRound.roundPlayType == enteredPlay.playType) {
            NSLog(@"wtf");
            [self addPlayToPile:enteredPlay atTop:YES];
            [self moveTurnInRound];
            isSuccessfulPlay = YES;
            [player removeCardsFromPlay:enteredPlay];
        }
        else {
            NSLog(@"there is a value issue");
            NSLog(@"Piletop value is %lu and playValue is %lu", (unsigned long)pileTop.playValue, (unsigned long)enteredPlay.playValue    );
        }
    }
    else {
        if (enteredPlay) {
            NSLog(@"wtf");
            [self addPlayToPile:enteredPlay atTop:YES];
            [self moveTurnInRound];
            isSuccessfulPlay = YES;
            [player removeCardsFromPlay:enteredPlay];
            self.currentRound.roundPlayType = enteredPlay.playType;
        }
    }
    if (isSuccessfulPlay) {
        self.currentRound.lastPlayPlaymaker = player;
        self.currentRound.passedCount = 0;
    }
    return isSuccessfulPlay;
}

- (void) playerIsAtTurnCallPass {
//    Player *playerCalledPass;
//    NSMutableArray *checkedOutRoundOrder;
//    for (NSUInteger i = 0; i < [self.currentRoundOrder count]; i++ ) {
//        Player *playerBeingChecked = [self.currentRoundOrder objectAtIndex: i];
//        if (playerBeingChecked.playerStatus == (Status)isAtTurn) {
//            playerCalledPass = playerBeingChecked;
//        }
//        [self moveTurnInRound];
//        checkedOutRoundOrder = [self.currentRoundOrder mutableCopy];
//        [checkedOutRoundOrder removeObject:playerCalledPass];
//        self.currentRoundOrder = [checkedOutRoundOrder copy];
//    }
    for (NSUInteger i = 0; i < [self.currentRoundOrder count]; i++ ) {
        Player *player = [self.currentRoundOrder objectAtIndex:i];
        
        if (player.playerStatus == (Status)isAtTurn) {
            if (i != ([self.currentRoundOrder count]-1)) {
                Player *playerNext = [self.currentRoundOrder objectAtIndex:(i+1)];
                playerNext.playerStatus = (Status)isAtTurn;
                player.playerStatus = (Status)standBy;
                break;
            }
            else {
                Player *playerNext = [self.currentRoundOrder objectAtIndex:(0)];
                playerNext.playerStatus = (Status)isAtTurn;
                player.playerStatus = (Status)standBy;
                break;
            }
        }
        
        
    }
    self.currentRound.passedCount++;
    if (self.currentRound.passedCount == 3) {
        self.lastRoundWinner = self.currentRound.lastPlayPlaymaker;
        if (self.lastRoundWinner) {
            NSLog(@"Last round winner is: %@", self.lastRoundWinner);
        } else {
            NSLog(@"last round winner did not get recorded");
        }
        if(self.lastRoundWinner == (Status)isAtTurn){NSLog(@"last round winner is at turn");}
        
        
        self.roundIsActive = NO;
//        Player *nextRoundStarter = [self.currentRoundOrder objectAtIndex:0];
//        if (nextRoundStarter.playerStatus == (Status)isAtTurn) {
//            NSLog(@"last round winner is at turn");}
        NSLog(@"round should be over");
        [self.cardsPile removeAllObjects];
    }
    
}




- (void) moveTurnInRound {
    NSLog(@"move in turn called");
    for (NSUInteger i = 0; i < [self.currentRoundOrder count]; i++ ) {
        Player *player = [self.currentRoundOrder objectAtIndex:i];
        
        if (player.playerStatus == (Status)isAtTurn) {
            if (i != ([self.currentRoundOrder count]-1)) {
                Player *playerNext = [self.currentRoundOrder objectAtIndex:(i+1)];
                playerNext.playerStatus = (Status)isAtTurn;
                player.playerStatus = (Status)standBy;
                break;
            }
            else {
                Player *playerNext = [self.currentRoundOrder objectAtIndex:(0)];
                playerNext.playerStatus = (Status)isAtTurn;
                player.playerStatus = (Status)standBy;
                break;
            }
        }
        
    
    }
    
}



- (void)addCardsToPile:(NSMutableArray *)cardsToAdd
{
    [self addCardsToPile:cardsToAdd atTop:NO];
}

- (void)addCardsToPile:(NSMutableArray *)cardsToAdd atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cardsPile insertObject:cardsToAdd atIndex:0];
    } else {
        [self.cardsPile addObject:cardsToAdd];
    }
}

- (void)addPlayToPile:(Play *)playToAdd
{
    [self addPlayToPile:playToAdd atTop:NO];
}

- (void)addPlayToPile:(Play *)playToAdd atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cardsPile insertObject:playToAdd atIndex:0];
    } else {
        [self.cardsPile addObject:playToAdd];
    }
}

- (NSString *)showPileTop {
    Play *pileTop = [self.cardsPile firstObject];
    NSString *pileTopResult = [[NSString alloc]init];
    BOOL firstCard = YES;
    for (Card *card in pileTop.chosenCardsInPlay) {
        
        if (firstCard) {
            pileTopResult = [NSString stringWithFormat:@"%@",card.contents];
            firstCard = NO;
        }
        else {
            pileTopResult = [NSString stringWithFormat:@"%@, %@",pileTopResult,card.contents];

        }
    }
    return pileTopResult;
}

- (NSArray *) testShowRoundOrder {
    
    NSArray *returnOrder = self.currentRoundOrder;

    return returnOrder;
}
    


    



@end
