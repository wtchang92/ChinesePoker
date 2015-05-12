//
//  Play.m
//  Chinese Poker
//
//  Created by Tim Chang on 5/10/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import "Play.h"

@implementation Play

- (instancetype) initWithChosenCards:(NSArray *)chosenCards {

    self = [super init];
    
    if (self) {
        self.numberOfCards = chosenCards.count;
        
        switch (self.numberOfCards) {
            case 1:
                if ([self checkPlayValidness:chosenCards]) {
                    self.chosenCardsInPlay = chosenCards;
                    self.playType = (PlayType)single;
                    self.playValue = [self calculatePlayValue:chosenCards];
                }
                break;
            case 2:
                if ([self checkPlayValidness:chosenCards]) {
                    self.chosenCardsInPlay = chosenCards;
                    self.playType = (PlayType)deuce;
                    self.playValue = [self calculatePlayValue:chosenCards];
                }
                break;
            case 3:
                if ([self checkPlayValidness:chosenCards]) {
                    self.chosenCardsInPlay = chosenCards;
                    self.playType = (PlayType)triple;
                    self.playValue = [self calculatePlayValue:chosenCards];
                }
                break;
            case 5:
                if ([self checkPlayValidness:chosenCards]) {
                    self.chosenCardsInPlay = chosenCards;
                    self.playType = (PlayType)set;
                    self.playValue = [self calculatePlayValue:chosenCards];
                }
                break;
            default:
                self.playValidness = NO;
                break;
        }
        
    }
    return self;
}

- (NSUInteger) calculatePlayValue: (NSArray *) chosenCards {
    NSUInteger value = 0;
    
    
    switch (self.numberOfCards) {
        case 1:
            for (Card *card in chosenCards) {
                NSUInteger suitValue;
                NSUInteger rankValue;
                NSUInteger cardValue;
                NSString *suit = [card.contents substringFromIndex:1];
                if ([suit isEqualToString:@"♠"]) {
                    suitValue = 8;
                }
                else if ([suit isEqualToString:@"♥"]){
                    suitValue = 4;
                }
                else if ([suit isEqualToString:@"♣"]){
                    suitValue = 2;
                }
                else {
                    suitValue = 0;
                }
                NSString *rank = [card.contents substringToIndex:1];
                if ([rank isEqualToString: @"2"]) {rankValue = 150;}
                else if ([rank isEqualToString: @"A"]) {rankValue = 140;}
                else if ([rank isEqualToString: @"K"]) {rankValue = 130;}
                else if ([rank isEqualToString: @"Q"]) {rankValue = 120;}
                else if ([rank isEqualToString: @"K"]) {rankValue = 110;}
                else {rankValue = [rank intValue] * 10;}
                cardValue = suitValue + rankValue;
                value += cardValue;
            }
            break;
        case 2:
            self.playType = (PlayType)deuce;
            for (Card *card in chosenCards) {
                NSUInteger suitValue;
                NSUInteger rankValue;
                NSUInteger cardValue;
                NSString *suit = [card.contents substringFromIndex:1];
                if ([suit isEqualToString:@"♠"]) {
                    suitValue = 8;
                }
                else if ([suit isEqualToString:@"♥"]){
                    suitValue = 4;
                }
                else if ([suit isEqualToString:@"♣"]){
                    suitValue = 2;
                }
                else {
                    suitValue = 0;
                }
                NSString *rank = [card.contents substringToIndex:1];
                if ([rank isEqualToString: @"2"]) {rankValue = 150;}
                else if ([rank isEqualToString: @"A"]) {rankValue = 140;}
                else if ([rank isEqualToString: @"K"]) {rankValue = 130;}
                else if ([rank isEqualToString: @"Q"]) {rankValue = 120;}
                else if ([rank isEqualToString: @"K"]) {rankValue = 110;}
                else {rankValue = [rank intValue] * 10;}
                cardValue = suitValue + rankValue;
                value += cardValue;
            }
            break;
        case 3:
            self.playType = (PlayType)triple;
            break;
        case 5:
            self.playType = (PlayType)set;
            break;
        default:
            break;
    }
    
    
    return value;
}

- (BOOL) checkPlayValidness: (NSArray *) chosenCards{
    BOOL validness = YES;
    Card *cardUsedtoCheck = [chosenCards objectAtIndex: 0 ];
    NSString *rankValue = [cardUsedtoCheck.contents substringToIndex:1];
    switch (self.numberOfCards) {
        case 2:
        case 3:
            for (Card *card in chosenCards) {
                
                if (![[card.contents substringToIndex:1] isEqual:rankValue]) {
                    
                    validness = NO;
                }
            }
            break;

        default:
            break;
    
    }
    self.playValidness = validness;
    return self.playValidness;
}



@end
