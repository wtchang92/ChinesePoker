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
                for (Card *card in chosenCards) {
                    NSLog(@"CHOSEN CARDS INCLUDE: %@", card.contents);
                }
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
                NSString *suit = [card.contents  substringFromIndex:[card.contents length]-1];
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
                if ([card.contents length]>2){
                    rank = [card.contents substringToIndex:2];
                }
                else {
                    rank = [card.contents substringToIndex:1];
                }
                if ([rank isEqualToString: @"2"]) {rankValue = 150;}
                else if ([rank isEqualToString: @"A"]) {rankValue = 140;}
                else if ([rank isEqualToString: @"K"]) {rankValue = 130;}
                else if ([rank isEqualToString: @"Q"]) {rankValue = 120;}
                else if ([rank isEqualToString: @"J"]) {rankValue = 110;}
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
                NSString *suit = [card.contents  substringFromIndex:[card.contents length]-1];
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
                
                if ([card.contents length]>2){
                    rank = [card.contents substringToIndex:2];
                }
                else {
                    rank = [card.contents substringToIndex:1];
                }
                
                if ([rank isEqualToString: @"2"]) {rankValue = 150;}
                else if ([rank isEqualToString: @"A"]) {rankValue = 140;}
                else if ([rank isEqualToString: @"K"]) {rankValue = 130;}
                else if ([rank isEqualToString: @"Q"]) {rankValue = 120;}
                else if ([rank isEqualToString: @"J"]) {rankValue = 110;}
                else {rankValue = [rank intValue] * 10;}
                cardValue = suitValue + rankValue;
                value += cardValue;
            }
            break;
        case 3:
            self.playType = (PlayType)triple;
            for (Card *card in chosenCards) {
                NSUInteger suitValue;
                NSUInteger rankValue;
                NSUInteger cardValue;
                NSString *suit = [card.contents  substringFromIndex:[card.contents length]-1];
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
                else if ([rank isEqualToString: @"J"]) {rankValue = 110;}
                else {rankValue = [rank intValue] * 10;}
                cardValue = suitValue + rankValue;
                value += cardValue;
            }
            break;
        case 5:
            self.playType = (PlayType)set;
            if (self.setType == (SetType)straight)
            {
                NSUInteger indicatorValue = [(Card *)[chosenCards objectAtIndex:0] findCardValue];
                for (NSUInteger i = 1; i < 5; i++){
                    if ([(Card *)[chosenCards objectAtIndex:i] findCardValue] > indicatorValue){
                        indicatorValue = [(Card *)[chosenCards objectAtIndex:i] findCardValue];
                    }
                }
                value = 1000 + indicatorValue;
                NSLog(@"straight was played");
            }
            else if (self.setType == (SetType)flush)
            {
                NSUInteger indicatorValue = [(Card *)[chosenCards objectAtIndex:0] findCardValue];
                for (NSUInteger i = 1; i < 5; i++){
                    if ([(Card *)[chosenCards objectAtIndex:i] findCardValue] > indicatorValue){
                        indicatorValue = [(Card *)[chosenCards objectAtIndex:i] findCardValue];
                    }
                }
                value = 2000 + indicatorValue;
                NSLog(@"flush was played");
                
               
            }
            else if (self.setType == (SetType)fullHouse)
            {
                NSUInteger indicatorValue;
                if ([[(Card *)[chosenCards objectAtIndex:0] findRank] isEqualToString:[(Card *)[chosenCards objectAtIndex:1] findRank]] &&
                    [[(Card *)[chosenCards objectAtIndex:0] findRank] isEqualToString:
                    [(Card *)[chosenCards objectAtIndex:2] findRank]]) {
                    indicatorValue = [(Card *)[chosenCards objectAtIndex:0] findCardValue];
                }
                else if ([[(Card *)[chosenCards objectAtIndex:4] findRank] isEqualToString: [(Card *)[chosenCards objectAtIndex:3] findRank]] &&
                         [[(Card *)[chosenCards objectAtIndex:4] findRank] isEqualToString:
                         [(Card *)[chosenCards objectAtIndex:2] findRank]]){
                    indicatorValue = [(Card *)[chosenCards objectAtIndex:0] findCardValue];
                }
                value = 3000 + indicatorValue;
                NSLog(@"fullhouse was played");
            }
            else if (self.setType == (SetType)fourOfAKind)
            {
                
                NSUInteger indicatorValue;
                if ([[(Card *)[chosenCards objectAtIndex:0] findRank] isEqualToString:[(Card *)[chosenCards objectAtIndex:1] findRank]] &&
                    [[(Card *)[chosenCards objectAtIndex:0] findRank] isEqualToString:
                     [(Card *)[chosenCards objectAtIndex:2] findRank]] &&
                    [[(Card *)[chosenCards objectAtIndex:0] findRank] isEqualToString:
                     [(Card *)[chosenCards objectAtIndex:3] findRank]])
                {
                        indicatorValue = [(Card *)[chosenCards objectAtIndex:0] findCardValue];
                    }
                else if ([[(Card *)[chosenCards objectAtIndex:4] findRank] isEqualToString: [(Card *)[chosenCards objectAtIndex:3] findRank]] &&
                         [[(Card *)[chosenCards objectAtIndex:4] findRank] isEqualToString:
                          [(Card *)[chosenCards objectAtIndex:2] findRank]] &&
                         [[(Card *)[chosenCards objectAtIndex:4] findRank] isEqualToString:
                          [(Card *)[chosenCards objectAtIndex:1] findRank]])
                {
                             indicatorValue = [(Card *)[chosenCards objectAtIndex:4] findCardValue];
                         }
                value = 4000 + indicatorValue;
                NSLog(@"4ofaKind was played");
            }
            else if (self.setType == (SetType)straightFlush)
            {
                NSUInteger indicatorValue = [(Card *)[chosenCards objectAtIndex:0] findCardValue];
                for (NSUInteger i = 1; i < 5; i++){
                    if ([(Card *)[chosenCards objectAtIndex:i] findCardValue] > indicatorValue){
                        indicatorValue = [(Card *)[chosenCards objectAtIndex:i] findCardValue];
                    }
                }
                value = 5000 + indicatorValue;
                NSLog(@"straight FLUSH was played");
                
            }
            break;
        default:
            break;
    }
    
    
    return value;
}

- (BOOL) checkPlayValidness: (NSArray *) chosenCards{
    BOOL validness = NO;
    Card *cardUsedtoCheck = [chosenCards objectAtIndex: 0 ];
    NSString *rankValue = [cardUsedtoCheck findRank];
    switch (self.numberOfCards) {
        case 1:
            validness = YES;
            break;
        case 2:
            for (Card *card in chosenCards) {
                if ([[card findRank] isEqualToString:rankValue]) {
                    validness = YES;
                }
                else {
                    validness = NO;
                    break;
                }
            }
            break;
        case 3:
            for (Card *card in chosenCards) {
                if ([[card findRank] isEqualToString:rankValue]) {
                    validness = YES;
                }
                else {
                    validness = NO;
                    break;
                }
            }
            break;
        case 5:
            if ([Play isFlush:chosenCards] && [Play isStraight:chosenCards]) {
                validness = YES;
                self.setType = (SetType)straightFlush;
            }
            else if ([Play isStraight:chosenCards] && ![Play isFlush:chosenCards]) {
                validness = YES;
                self.setType = (SetType)straight;
            }
            else if ([Play isFlush:chosenCards] && ![Play isStraight:chosenCards]) {
                validness = YES;
                self.setType = (SetType)flush;
            }
            else if ([Play isFourOfAKind:chosenCards]){
                validness = YES;
                self.setType = (SetType)fourOfAKind;
            }
            else if ([Play isFullHouse:chosenCards]){
                validness = YES;
                self.setType = (SetType)fullHouse;
            }
            break;
        default:
            break;
    
    }
    self.playValidness = validness;
    return self.playValidness;
}

+ (BOOL) isFlush: (NSArray *) chosenCards {
    NSLog(@"is flush checker runs");
    BOOL isFlushResult = NO;
    for (NSUInteger i = 0; i < [chosenCards count]-1; i ++)
    {
        
        Card *cardAtIndex = [chosenCards objectAtIndex:i];
        Card *nextCard = [chosenCards objectAtIndex:i+1];
        NSLog(@"test: %@ matches %@", [cardAtIndex.contents  substringFromIndex:[cardAtIndex.contents length]-1], [nextCard.contents  substringFromIndex:[nextCard.contents length]-1] );
        if ([[cardAtIndex.contents  substringFromIndex:[cardAtIndex.contents length]-1] isEqualToString: [nextCard.contents  substringFromIndex:[nextCard.contents length]-1]]) {
            NSLog(@"this message should print 4 times");
            isFlushResult = YES;
        } else {
            isFlushResult = NO;
            break;
        }
        
    }
    if (!isFlushResult) {
        NSLog (@"this should be false flush");
    }
    return isFlushResult;
}

+ (BOOL) isStraight: (NSArray *) chosenCards {
    NSLog(@"is straight runs");
    BOOL isStraightResult = NO;
    NSMutableArray *cardValues = [[NSMutableArray alloc]init];
    NSNumber *cardRank;
    
    for (Card *card in chosenCards) {
        if ([card.contents length]>2){
            cardRank = @([ [card.contents substringToIndex:2] intValue]);
            [cardValues addObject:cardRank];
        }
        else {
            
                if ([[card.contents substringToIndex:1] isEqualToString: @"2"]) {cardRank = [NSNumber numberWithUnsignedInteger:15];
                    [cardValues addObject:cardRank];
                }
                else if ([[card.contents substringToIndex:1] isEqualToString: @"A"]) {cardRank = [NSNumber numberWithUnsignedInteger:14];
                    [cardValues addObject:cardRank];
                }
                else if ([[card.contents substringToIndex:1] isEqualToString: @"K"]) {cardRank = [NSNumber numberWithUnsignedInteger:13];
                    [cardValues addObject:cardRank];
                }
                else if ([[card.contents substringToIndex:1] isEqualToString: @"Q"]) {cardRank = [NSNumber numberWithUnsignedInteger:12];
                    [cardValues addObject:cardRank];
                }
                else if ([[card.contents substringToIndex:1] isEqualToString: @"J"]) {cardRank = [NSNumber numberWithUnsignedInteger:11];
                    [cardValues addObject:cardRank];
                }
                else {
                    cardRank = @([ [card.contents substringToIndex:1] intValue]);
                    
                    [cardValues addObject:cardRank];
                }
        }
    }
    //sort cardValues
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [cardValues sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    
    NSLog(@"number of items in chosenCards should be 5: %lu", (unsigned long)[cardValues count]);
    
    for (NSNumber *valuesInStraight in cardValues) {
        NSLog(@"valuesInStraight: %d", [valuesInStraight intValue]);
    }
    
    for (NSInteger i = 1; i < 5; i++) {
        NSNumber *smallestCard = [cardValues objectAtIndex:0];
        NSNumber *cardBeingCheckedAgainst = [cardValues objectAtIndex:i];
        if ((cardBeingCheckedAgainst.integerValue - smallestCard.integerValue) == i) {
            isStraightResult = YES;
        } else {
            isStraightResult = NO;
            break;
        }
    }
    
    return isStraightResult;
}

+ (BOOL) isFourOfAKind: (NSArray *) chosenCards {
    BOOL is4OfAKindResult = YES;
    chosenCards = [[Play quickSort: [chosenCards mutableCopy]] copy];
    NSMutableArray *cardValues = [[NSMutableArray alloc]init];
    NSNumber *cardRank;
    
    for (Card *card in chosenCards) {
        if ([card.contents length]>2){
            cardRank = @([ [card.contents substringToIndex:2] intValue]);
            [cardValues addObject:cardRank];
        }
        else {
            
            if ([[card.contents substringToIndex:1] isEqualToString: @"2"]) {cardRank = [NSNumber numberWithUnsignedInteger:15];
                [cardValues addObject:cardRank];
            }
            else if ([[card.contents substringToIndex:1] isEqualToString: @"A"]) {cardRank = [NSNumber numberWithUnsignedInteger:14];
                [cardValues addObject:cardRank];
            }
            else if ([[card.contents substringToIndex:1] isEqualToString: @"K"]) {cardRank = [NSNumber numberWithUnsignedInteger:13];
                [cardValues addObject:cardRank];
            }
            else if ([[card.contents substringToIndex:1] isEqualToString: @"Q"]) {cardRank = [NSNumber numberWithUnsignedInteger:12];
                [cardValues addObject:cardRank];
            }
            else if ([[card.contents substringToIndex:1] isEqualToString: @"J"]) {cardRank = [NSNumber numberWithUnsignedInteger:11];
                [cardValues addObject:cardRank];
            }
            else {
                cardRank = @([ [card.contents substringToIndex:1] intValue]);
                
                [cardValues addObject:cardRank];
            }
        }
    }
    //NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    //[cardValues sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    
    
    for (NSUInteger i = 1; i < 4; i++) {
        NSLog(@"4ofaKind: %lu", (unsigned long)i);
        NSNumber *biggestCard = [cardValues objectAtIndex:0];
        NSNumber *cardBeingCheckedAgainst = [cardValues objectAtIndex:i];
        if (biggestCard.intValue != cardBeingCheckedAgainst.intValue) {
            is4OfAKindResult = NO;
        }
    }
    
    if (!is4OfAKindResult) {
        for (NSUInteger i = 3; i > 0; i--) {
            NSNumber *smallestCard = [cardValues objectAtIndex:4];
            NSNumber *cardBeingCheckedAgainst = [cardValues objectAtIndex:i];
            if (smallestCard.intValue == cardBeingCheckedAgainst.intValue) {
                is4OfAKindResult = NO;
            }
        }
    }
    NSLog(@"4 of a kind number of items in chosenCards should be 5: %lu", (unsigned long)[cardValues count]);
    
    NSLog(@"4 of a kind checker ran");
    return is4OfAKindResult;
}

+ (BOOL) isFullHouse: (NSArray *) chosenCards {
    BOOL isFullHouse = NO;
    NSMutableArray *cardValues = [[NSMutableArray alloc]init];
    NSNumber *cardRank;
    
    for (Card *card in chosenCards) {
        if ([card.contents length]>2){
            cardRank = @([ [card.contents substringToIndex:2] intValue]);
            [cardValues addObject:cardRank];
        }
        else {
            
            if ([[card.contents substringToIndex:1] isEqualToString: @"2"]) {cardRank = [NSNumber numberWithUnsignedInteger:15];
                [cardValues addObject:cardRank];
            }
            else if ([[card.contents substringToIndex:1] isEqualToString: @"A"]) {cardRank = [NSNumber numberWithUnsignedInteger:14];
                [cardValues addObject:cardRank];
            }
            else if ([[card.contents substringToIndex:1] isEqualToString: @"K"]) {cardRank = [NSNumber numberWithUnsignedInteger:13];
                [cardValues addObject:cardRank];
            }
            else if ([[card.contents substringToIndex:1] isEqualToString: @"Q"]) {cardRank = [NSNumber numberWithUnsignedInteger:12];
                [cardValues addObject:cardRank];
            }
            else if ([[card.contents substringToIndex:1] isEqualToString: @"J"]) {cardRank = [NSNumber numberWithUnsignedInteger:11];
                [cardValues addObject:cardRank];
            }
            else {
                cardRank = @([ [card.contents substringToIndex:1] intValue]);
                
                [cardValues addObject:cardRank];
            }
        }
    }
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    [cardValues sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    
    for (NSUInteger i = 1; i < 4; i++) {
        NSNumber *biggestCard = [cardValues objectAtIndex:0];
        NSNumber *smallerCard = [cardValues objectAtIndex:4];
        NSNumber *cardBeingCheckedAgainst = [cardValues objectAtIndex:i];
        if (i < 3){
            if (biggestCard.intValue == cardBeingCheckedAgainst.intValue) {
                isFullHouse = YES;
            } else {
                isFullHouse = NO;
                break;
            }
        }
        else {
            if (cardBeingCheckedAgainst.intValue == smallerCard.intValue) {
                isFullHouse = YES;
            } else {
                isFullHouse = NO;
                break;
            }
        }
    }
    if (!isFullHouse) {
        for (NSUInteger i = 3; i > 0; i--) {
            NSNumber *smallestCard = [cardValues objectAtIndex:4];
            NSNumber *lastCard = [cardValues objectAtIndex:0];
            NSNumber *cardBeingCheckedAgainst = [cardValues objectAtIndex:i];
            if (i > 1) {
                if (smallestCard.intValue == cardBeingCheckedAgainst.intValue) {
                    isFullHouse = YES;
                }
                else {
                    isFullHouse = NO;
                    break;
                }
            }
            else {
                if (lastCard.intValue == cardBeingCheckedAgainst.intValue) {
                    isFullHouse = YES;
                }
                else {
                    isFullHouse = NO;
                    break;
                }
            }
        }
    }
    
    
    return isFullHouse;
    
}

+(NSMutableArray *)quickSort:(NSMutableArray *)unsortedDataArray
{
    
    NSMutableArray *lessArray = [[NSMutableArray alloc]init];
    NSMutableArray *greaterArray = [[NSMutableArray alloc]init];
    if ([unsortedDataArray count] <1)
    {
        return nil;
    }
    int randomPivotPoint = arc4random() % [unsortedDataArray count];
    Card *pivotCard = [unsortedDataArray objectAtIndex:randomPivotPoint];
    [unsortedDataArray removeObjectAtIndex:randomPivotPoint];
    
    for (Card *card in unsortedDataArray) {
        
        if ([Play findCardValue:card] < [Play findCardValue:pivotCard])
        {
            [lessArray addObject:card];
        }
        else
        {
            [greaterArray addObject:card];
        }
        
    }
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc]init];
    [sortedArray addObjectsFromArray:[self quickSort:lessArray]];
    [sortedArray addObject:pivotCard];
    [sortedArray addObjectsFromArray:[self quickSort:greaterArray]];
    return sortedArray;
}

+ (NSUInteger) findCardValue: (Card *)card {
    NSUInteger suitValue;
    NSUInteger rankValue;
    NSUInteger cardValue;
    NSString *suit = [card.contents  substringFromIndex:[card.contents length]-1];
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
    if ([card.contents length]>2){
        rank = [card.contents substringToIndex:2];
    }
    else {
        rank = [card.contents substringToIndex:1];
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




@end
