//
//  PlayingCardDeck.m
//  Chinese Poker
//
//  Created by Tim Chang on 5/7/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h" //THIS IS NEEDED

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                
                // add card
                [self addCard:card];
            }
        }
    }
    
    return self;
}


@end
