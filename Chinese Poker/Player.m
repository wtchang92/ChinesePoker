//
//  Player.m
//  Chinese Poker
//
//  Created by Tim Chang on 5/8/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import "Player.h"

@implementation Player


- (Play *)makePlay {
    Play *play;
    NSLog(@"BEFORE the play is made, the user has these in his hand");
    for (Card *card in self.hand) {
        NSLog(@"%@", card.contents);
    }
    
    NSMutableArray *playCards = [[NSMutableArray alloc]init];
      NSLog(@"These are the chosen play cards:");

    if (self.playerStatus == (Status)isAtTurn) {
 
        for (Card *card in self.hand) {
        
            if ([card isChosen]) {
                NSLog(@"%@", card.contents);
                [playCards addObject:card];
            }
        }
        play = [[Play alloc]initWithChosenCards:[playCards copy]];
        
        
        if (play.isValid) {
            NSLog(@"AFTER the play is made, the user has these in his hand");
            [self.hand removeObjectsInArray:playCards];
           
            for (Card *card in self.hand) {
                NSLog(@"%@", card.contents);
            }
            
            
        }
        else {
            NSLog(@"Play is invalid, try again.");
            play = nil;
        }
    }
    
    //return playCards;
    return play;
}


@end
