//
//  GameRound.m
//  Chinese Poker
//
//  Created by Tim Chang on 5/9/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import "GameRound.h"


@interface GameRound()
@property (strong, nonatomic) NSMutableArray *roundPlayOrder;

@end

@implementation GameRound

- (NSMutableArray *)roundPlayOrder
{
    if (!_roundPlayOrder)_roundPlayOrder = [[NSMutableArray alloc]init];
    return _roundPlayOrder;
}



- (instancetype)initWithLastRoundWinner: (Player *)lastRoundWinner players:(NSMutableArray *)players {
    [self.roundPlayOrder removeAllObjects];
    self = [super init];
    
    if (self) {
        
        if (lastRoundWinner) {
            int playerIndex = 0;
        
            for (Player * player in players) {
            
                if (lastRoundWinner == player) {
                
                    break;
                }
                else {
                
                    playerIndex++;
                }
            }
//            int playerOrderAdded = 0;
//            for (int i = playerIndex; i<4; i++) {
//                if (playerOrderAdded ==4) {
//                    playerOrderAdded = 0;
//                    break;
//                }
//                [self.roundPlayOrder addObject: [players objectAtIndex: i]];
//                if (i == 3) {
//                
//                    i = 0;
//                }
//                playerOrderAdded++;
//            }
            for (int i = 0; i<4; i++) {
                
                NSLog(@"this should print with last round winnder player first: %@", [players objectAtIndex:playerIndex]);
                [self.roundPlayOrder addObject: [players objectAtIndex: playerIndex]];
                
                if (playerIndex == 3) {
                    playerIndex = 0;
                }
                else {
                    playerIndex++;
                }
                
                
            }
            self.passedCount = 0;
            
            
        }
        else {
            int playerIndex = 0;
            Player *diamond3PLayer = [self findDiamond3Player:players];
            
            for (Player * player in players) {
                
                if (diamond3PLayer== player) {
                    NSLog(@"diamond 3 player found in players");
                    break;
                }
                else {
                    
                    playerIndex++;
                }
            }
            
            for (int i = 0; i<4; i++) {
               
                NSLog(@"this should print with d3 paler first: %@", [players objectAtIndex:playerIndex]);
                [self.roundPlayOrder addObject: [players objectAtIndex: playerIndex]];
                
                if (playerIndex == 3) {
                    playerIndex = 0;
                }
                else {
                    playerIndex++;
                }
                
                
            }
            self.passedCount = 0;
        
        }
    
    }
    NSLog(@"round play order is: %@", self.roundPlayOrder);
    return self;
}

//return play order
- (NSArray *) playerOrder {
    NSArray *playOrder =  [self.roundPlayOrder copy];
    return playOrder;

}

- (Player *) findDiamond3Player: (NSMutableArray *) thisRoundPlayers {
    Player *playerWithDiamond3;
    int playerNumber = 0;
    
    for (Player *player in thisRoundPlayers) {
    
        for (Card *card in player.hand) {
            NSLog(@"checking card %@ in player %d's hand against 3♦", card.contents, playerNumber);
            if ([card.contents  isEqualToString: @"3♦"]) {
                NSLog(@"It is a match");
                playerWithDiamond3 = player;
                break;
            }
        }
        playerNumber++;
    }
    NSLog(@"find D3 Player: %@", playerWithDiamond3);
    return playerWithDiamond3;
}

@end
