//
//  CPUBot.h
//  Chinese Poker
//
//  Created by Tim Chang on 5/19/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "GameRound.h"

@interface CPUBot : Player

-(instancetype)initToPlayFor: (Player *)player inThisRound: (GameRound *)thisRound withPileTopPlay: (Play *) pileTopPlay;

@property (nonatomic) Player *playerCPUisPlayingFor;
-(BOOL)choosePlayFromHand: (NSArray *) hand playToBeat: (Play *)playToBeat;

@end
