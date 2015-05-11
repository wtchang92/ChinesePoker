//
//  Player.m
//  Chinese Poker
//
//  Created by Tim Chang on 5/8/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import "Player.h"

@implementation Player


- (NSMutableArray *)makePlay {
    NSMutableArray *playCards = [[NSMutableArray alloc]init];

    if (self.playerStatus == (Status)isAtTurn) {
    
        NSMutableArray *playCards;
        
        for (Card *card in self.hand) {
        
            if ([card isChosen]) {
            
                [playCards addObject:card];
            }
        
        }
        
        self.playerStatus = (Status)standBy;
    }
    return playCards;
}


@end
