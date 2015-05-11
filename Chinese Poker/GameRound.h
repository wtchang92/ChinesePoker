//
//  GameRound.h
//  Chinese Poker
//
//  Created by Tim Chang on 5/9/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface GameRound : NSObject
- (instancetype)initWithLastRoundWinner: (Player *)lastRoundWinner players:(NSMutableArray *)players;

@property (strong, nonatomic) Player *winnerOfRound;

//property for playType

- (NSArray *) playerOrder;


@end
