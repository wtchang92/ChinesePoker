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
//            NSLog(@"AFTER the play is made, the user has these in his hand");
            //[self.hand removeObjectsInArray:playCards];
           
//            for (Card *card in self.hand) {
//                NSLog(@"%@", card.contents);
//            }
            NSLog(@"Play was successfully made");
        }
        else {
            NSLog(@"Play is invalid, try again.");
            play = nil;
        }
    }
    
    //return playCards;
    return play;
}

- (void)removeCardsFromPlay: (Play *)enteredPlay {
    
    [self.hand removeObjectsInArray:enteredPlay.chosenCardsInPlay];
    
    for (Card *card in self.hand) {
        NSLog(@"%@", card.contents);
    }
}

-(NSMutableArray *)quickSort:(NSMutableArray *)unsortedDataArray
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

        if ([Player findCardValue:card] < [Player findCardValue:pivotCard])
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
