//
//  Card.m
//  Chinese Poker
//
//  Created by Tim Chang on 5/6/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import "Card.h"


@implementation Card


- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) { // fast enumeration
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

- (NSUInteger) findCardValue {
    NSUInteger suitValue;
    NSUInteger rankValue;
    NSUInteger cardValue;
    NSString *suit = [self.contents  substringFromIndex:[self.contents length]-1];
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
    NSString *rank;
    if ([self.contents length]>2){
        rank = [self.contents substringToIndex:2];
    }
    else {
        rank = [self.contents substringToIndex:1];
    }
    if ([rank isEqualToString: @"2"]) {rankValue = 150;}
    else if ([rank isEqualToString: @"A"]) {rankValue = 140;}
    else if ([rank isEqualToString: @"K"]) {rankValue = 130;}
    else if ([rank isEqualToString: @"Q"]) {rankValue = 120;}
    else if ([rank isEqualToString: @"J"]) {rankValue = 110;}
    else {rankValue = [rank intValue] * 10;}
    cardValue = suitValue + rankValue;
    return cardValue;
}

- (NSString *) findRank{
    NSString *rank;
    if ([self.contents length]>2){
        rank = [self.contents substringToIndex:2];
    }
    else {
        rank = [self.contents substringToIndex:1];
    }
    return rank;
}


- (NSString *) findSuit{
    NSString *suit = [self.contents  substringFromIndex:[self.contents length]-1];
    return suit;
}



@end
