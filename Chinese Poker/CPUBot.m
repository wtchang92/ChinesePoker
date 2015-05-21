//
//  CPUBot.m
//  Chinese Poker
//
//  Created by Tim Chang on 5/19/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import "CPUBot.h"
@interface CPUBot()
@property (strong, nonatomic) GameRound *currentRound;


@end

@implementation CPUBot

-(instancetype)initToPlayFor: (Player *)player inThisRound: (GameRound *)thisRound withPileTopPlay: (Play *) pileTopPlay{
    self = [super init];
    if (self) {
        self.playerCPUisPlayingFor = player;
        self.hand = player.hand;
        self.currentRound = thisRound;
        
    }
    
    return self;
}


-(BOOL)choosePlayFromHand: (NSArray *) hand playToBeat: (Play *)playToBeat {
    BOOL cpuChoseAPlay = YES;
    
    //cpu choose a play that has diamond 3 in it
    if (!playToBeat && self.currentRound.isFirstRound) {
        if (![self chooseSetPlayIncludeDiamond3:self.hand withTriesNumber:75 aimForPlayType:(PlayType)set]) {
            if (![self chooseSetPlayIncludeDiamond3:self.hand withTriesNumber:30 aimForPlayType:(PlayType)triple]) {
                if (![self chooseSetPlayIncludeDiamond3:self.hand withTriesNumber:45 aimForPlayType:(PlayType)deuce]) {
                    [self chooseSetPlayIncludeDiamond3:self.hand withTriesNumber:1 aimForPlayType:(PlayType)single];
                }
                
            }
        }
        
    }
    //CPU winner plays anything
    else if (!playToBeat && self.currentRound.isFirstRound == NO) {
        if ([hand count] >= 10) {
            if (![self chooseSetPlayFreeChoice:self.hand withTriesNumber:75 aimForPlayType:(PlayType)set]) {
                if (![self chooseSetPlayFreeChoice:self.hand withTriesNumber:30 aimForPlayType:(PlayType)triple]) {
                    if (![self chooseSetPlayFreeChoice:self.hand withTriesNumber:45 aimForPlayType:(PlayType)deuce]) {
                        [self chooseSetPlayFreeChoice:self.hand withTriesNumber:1 aimForPlayType:(PlayType)single];
                    }
                    
                }
            }
        }
        else if ([hand count] >= 8) {
            if (![self chooseSetPlayFreeChoice:self.hand withTriesNumber:50 aimForPlayType:(PlayType)set]) {
                if (![self chooseSetPlayFreeChoice:self.hand withTriesNumber:25 aimForPlayType:(PlayType)triple]) {
                    if (![self chooseSetPlayFreeChoice:self.hand withTriesNumber:40 aimForPlayType:(PlayType)deuce]) {
                        [self chooseSetPlayFreeChoice:self.hand withTriesNumber:1 aimForPlayType:(PlayType)single];
                    }
                    
                }
            }
        }
        else if ([hand count] >= 5) {
            if (![self chooseSetPlayFreeChoice:self.hand withTriesNumber:35 aimForPlayType:(PlayType)set]) {
                if (![self chooseSetPlayFreeChoice:self.hand withTriesNumber:18 aimForPlayType:(PlayType)triple]) {
                    if (![self chooseSetPlayFreeChoice:self.hand withTriesNumber:35 aimForPlayType:(PlayType)deuce]) {
                        [self chooseSetPlayFreeChoice:self.hand withTriesNumber:1 aimForPlayType:(PlayType)single];
                    }
                    
                }
            }
        }
        else if ([hand count] > 1) {
                if (![self chooseSetPlayFreeChoice:self.hand withTriesNumber:15 aimForPlayType:(PlayType)triple]) {
                    if (![self chooseSetPlayFreeChoice:self.hand withTriesNumber:20 aimForPlayType:(PlayType)deuce]) {
                        [self chooseSetPlayFreeChoice:self.hand withTriesNumber:1 aimForPlayType:(PlayType)single];
                    }
                    
                }
        }
        else {
            //NO SET PLAYER SHOULD PASS
            NSLog(@"should not go here if hand has more than 5 cards");
            Card *card = [self.playerCPUisPlayingFor.hand objectAtIndex:0];
            card.chosen = YES;
        }
        

    }
    //CPU player has to play by playtype set by the winner of the round
    else {
        NSLog(@"PLAYER HAS TO PLAY BY PLAYED TYPE"
              );
        NSLog(@"PLAYER HAS TO PLAY BY PLAYED TYPE");
        NSLog(@"PLAYER HAS TO PLAY BY PLAYED TYPE");
        NSLog(@"PLAYER HAS TO PLAY BY PLAYED TYPE");
        NSLog(@"PLAYER HAS TO PLAY BY PLAYED TYPE");
        if (playToBeat.playType == (PlayType)single) {
            if ([self chooseSetPlay:self.playerCPUisPlayingFor.hand withTriesNumber:30 needsToBeat:playToBeat aimForPlayType: (PlayType)single]) {
                NSLog(@"sucessful single play search set from  cards!!!");
            }
            else {
                NSLog(@"unsucessful single play search from  cards");
                cpuChoseAPlay = NO;
            }
        }
        else if (playToBeat.playType == (PlayType)deuce) {
            if ([self chooseSetPlay:self.playerCPUisPlayingFor.hand withTriesNumber:75 needsToBeat:playToBeat aimForPlayType: (PlayType)deuce]) {
                NSLog(@"sucessful search set from 10+ cards!!!");
            }
            else {
                NSLog(@"unsucessful search set from 10+ cards");
                cpuChoseAPlay = NO;
            }
        }
        else if (playToBeat.playType == (PlayType)triple) {
            if ([self chooseSetPlay:self.playerCPUisPlayingFor.hand withTriesNumber:60 needsToBeat:playToBeat aimForPlayType: (PlayType)triple]) {
                NSLog(@"sucessful search set from 10+ cards!!!");
            }
            else {
                NSLog(@"unsucessful search set from 10+ cards");
                cpuChoseAPlay = NO;
            }
        }
        else {
            if ([hand count] >= 10) {
                
                if ([self chooseSetPlay:self.playerCPUisPlayingFor.hand withTriesNumber:100 needsToBeat:playToBeat aimForPlayType: (PlayType)set]) {
                    NSLog(@"sucessful search set from 10+ cards!!!");
                }
                else {
                    NSLog(@"unsucessful search set from 10+ cards");
                    cpuChoseAPlay = NO;
                }
            }
            else if ([hand count] >= 8) {
                if ([self chooseSetPlay:self.playerCPUisPlayingFor.hand withTriesNumber:75 needsToBeat:playToBeat aimForPlayType: (PlayType)set]) {
                    NSLog(@"sucessful search set from 8+ cards!!!");
                }
                else {
                    NSLog(@"unsucessful search set from 8+ cards");
                    cpuChoseAPlay = NO;
                }
            }
            else if ([hand count] >= 5) {
                if ([self chooseSetPlay:self.playerCPUisPlayingFor.hand withTriesNumber:45 needsToBeat:playToBeat aimForPlayType: (PlayType)set]) {
                    NSLog(@"sucessful search set from 5+ cards!!!");
                }
                else {
                    NSLog(@"unsucessful search set from 5+ cards");
                    cpuChoseAPlay = NO;
                }
            }
            else {
                
                //NO SET PLAYER SHOULD PASS
                NSLog(@"Doesn't have enough cards to play a set");
                cpuChoseAPlay = NO;
            }
        }
    }
    return cpuChoseAPlay;
    
}

-(BOOL) chooseSetPlay: (NSArray *) hand withTriesNumber: (NSUInteger)triesNumber needsToBeat: (Play *)playToBeat aimForPlayType: (PlayType)playType {
    BOOL setFound = YES;
    
    NSUInteger numberOfCardsInPlay;
    switch (playType) {
        case (PlayType)single:
            numberOfCardsInPlay = 1;
            break;
        case (PlayType)deuce:
            numberOfCardsInPlay = 2;
            break;
        case (PlayType)triple:
            numberOfCardsInPlay = 3;
            break;
        case (PlayType)set:
            numberOfCardsInPlay = 5;
            break;
        default:
            break;
    }
    
    if (numberOfCardsInPlay > 1) {
        NSMutableArray *possiblePlays = [[NSMutableArray alloc]init];
    
    
        for (NSUInteger i = 0; i < triesNumber; i++) {
            NSMutableArray *cardsChosenByBot = [[NSMutableArray alloc]init];
            NSMutableArray *usedIndex = [[NSMutableArray alloc]init];
            for (NSUInteger i = 0; i < [hand count]; i++) {
                NSString *tmpNum = [NSString stringWithFormat:@"%lu",(unsigned long)i];
                [usedIndex addObject:tmpNum];
            }
            for (NSUInteger i = 0; i < numberOfCardsInPlay; i++) {

                
                unsigned index = arc4random() % [usedIndex count];
                NSString *randomChosenIndex = [usedIndex objectAtIndex:index];
                NSNumber *number = [NSNumber numberWithLongLong: randomChosenIndex.longLongValue];
                NSUInteger indexToChooseRandomCard =  number.unsignedIntegerValue;
                Card *randomCard = nil;
                randomCard = [hand objectAtIndex:indexToChooseRandomCard];
                [usedIndex removeObjectAtIndex:index];
                NSLog(@"randomCard has a value of: %@", randomCard.contents);
                [cardsChosenByBot addObject:randomCard];
                
            }
            //if play is valid then break and add the play to an array of plays
            Play *checkPlay = [[Play alloc]initWithChosenCards:[cardsChosenByBot copy]];
            NSLog(@"checkPlay: %@", checkPlay);
            NSLog(@"play has this number of cards: %lu", [checkPlay.chosenCardsInPlay count]);
            for (Card *card in checkPlay.chosenCardsInPlay) {
                NSLog(@"This play includes: %@", card.contents);
            }
            
            if (checkPlay.isValid) {
                [possiblePlays addObject:checkPlay];
                NSLog(@"Play added");
            }
            [cardsChosenByBot removeAllObjects];
            [usedIndex removeAllObjects];
        }
        if ([possiblePlays count] > 1) {
            [CPUBot quickSortPossbilePlays:possiblePlays];
            for (Play *possiblePlay in possiblePlays) {
                if (possiblePlay.playValue > playToBeat.playValue) {
                    for (Card *card in self.playerCPUisPlayingFor.hand) {
                        if ([possiblePlay.chosenCardsInPlay containsObject:card]) {
                            card.chosen= YES;
                        }
                    }
                    setFound = YES;
                    break;
                }
                else {
                    setFound = NO;
                }
            }
        }
        else if ([possiblePlays count] == 1) {
            Play *lowestValuedPlay = [possiblePlays objectAtIndex:0];
            if (lowestValuedPlay.playValue > playToBeat.playValue){
                for (Card *card in self.playerCPUisPlayingFor.hand) {
                    if ([lowestValuedPlay.chosenCardsInPlay containsObject:card]) {
                        card.chosen= YES;
                    }
                }
                setFound = YES;
            }
            else {
                setFound = NO;
            }
        }
        else {
            NSLog(@"no set found by CPU player");
            setFound = NO;
        }
    }
    
    else {
        
        for (Card * card in hand) {
            if ([card findCardValue] > playToBeat.playValue) {
                card.chosen = YES;
                setFound = YES;
                break;
            }
            else {
                setFound = NO;
            }
        }
    }

    return setFound;
}



-(BOOL) chooseSetPlayIncludeDiamond3: (NSArray *) hand withTriesNumber: (NSUInteger)triesNumber aimForPlayType: (PlayType)playType {
    
    BOOL playFound = NO;
    
    NSUInteger numberOfCardsInPlay;
    switch (playType) {
        case (PlayType)single:
            numberOfCardsInPlay = 0;
            break;
        case (PlayType)deuce:
            numberOfCardsInPlay = 1;
            break;
        case (PlayType)triple:
            numberOfCardsInPlay = 2;
            break;
        case (PlayType)set:
            numberOfCardsInPlay = 4;
            break;
        default:
            break;
    }
    
    if (numberOfCardsInPlay == 0) {
        for (Card *card in self.playerCPUisPlayingFor.hand) {
            if ([card.contents isEqualToString:@"3♦"]) {
                card.chosen= YES;
                playFound = YES;
                break;
            }
        }
    }
    else {
    
        NSMutableArray *possiblePlays = [[NSMutableArray alloc]init];
        for (NSUInteger i = 0; i < triesNumber; i++) {
            NSMutableArray *cardsChosenByBot = [[NSMutableArray alloc]init];
            NSMutableArray *usedIndex = [[NSMutableArray alloc]init];
            for (NSUInteger i = 0; i < [hand count]; i++) {
                NSString *tmpNum = [NSString stringWithFormat:@"%lu",(unsigned long)i];
                [usedIndex addObject:tmpNum];
            }
            for (Card *card in self.playerCPUisPlayingFor.hand) {
                if ([card.contents isEqualToString:@"3♦"]) {
                    [cardsChosenByBot addObject:card];
                    [usedIndex removeObjectAtIndex: [hand indexOfObject:card]];
                    break;
                }
            }
            for (NSUInteger i = 0; i < numberOfCardsInPlay; i++) {
                
                
                unsigned index = arc4random() % [usedIndex count];
                NSString *randomChosenIndex = [usedIndex objectAtIndex:index];
                NSNumber *number = [NSNumber numberWithLongLong: randomChosenIndex.longLongValue];
                NSUInteger indexToChooseRandomCard =  number.unsignedIntegerValue;
                Card *randomCard = nil;
                randomCard = [hand objectAtIndex:indexToChooseRandomCard];
                [usedIndex removeObjectAtIndex:index];
                NSLog(@"randomCard has a value of: %@", randomCard.contents);
                [cardsChosenByBot addObject:randomCard];
                
            }
            //if play is valid then break and add the play to an array of plays
            Play *checkPlay = [[Play alloc]initWithChosenCards:[cardsChosenByBot copy]];
            NSLog(@"checkPlay: %@", checkPlay);
            NSLog(@"play has this number of cards: %lu", [checkPlay.chosenCardsInPlay count]);
            for (Card *card in checkPlay.chosenCardsInPlay) {
                NSLog(@"This play includes: %@", card.contents);
            }
            
            if (checkPlay.isValid) {
                [possiblePlays addObject:checkPlay];
                NSLog(@"Play added");
            }
            [cardsChosenByBot removeAllObjects];
            [usedIndex removeAllObjects];
        }
        if ([possiblePlays count] > 1) {
            [CPUBot quickSortPossbilePlays:possiblePlays];
            Play *lowestValuedPlay = [possiblePlays objectAtIndex:0];
            if (lowestValuedPlay.isValid) {
                NSLog(@"lowestValuedPlay is valid");
            }
            else {
                NSLog(@"lowestValuedPlay is NOT valid");
            }
            NSLog(@"the CPU's chosen play settype is: %lu", (unsigned long)lowestValuedPlay.setType);
            for (Card *card in lowestValuedPlay.chosenCardsInPlay) {
                NSLog(@"lowestValueplay has card: %@", card.contents);
            }
            for (Card *card in self.playerCPUisPlayingFor.hand) {
                if ([lowestValuedPlay.chosenCardsInPlay containsObject:card]) {
                    card.chosen= YES;
                }
            }
            playFound = YES;
        }
        else if ([possiblePlays count] == 1) {
            Play *lowestValuedPlay = [possiblePlays objectAtIndex:0];
            for (Card *card in self.playerCPUisPlayingFor.hand) {
                if ([lowestValuedPlay.chosenCardsInPlay containsObject:card]) {
                    card.chosen= YES;
                }
            }
            playFound = YES;
        }
        else {
            NSLog(@"no set found by CPU player");
            playFound = NO;
        }
    }
    
    return playFound;
}


-(BOOL) chooseSetPlayFreeChoice: (NSArray *) hand withTriesNumber: (NSUInteger)triesNumber aimForPlayType: (PlayType)playType {
    
    BOOL playFound = NO;
    
    NSUInteger numberOfCardsInPlay;
    switch (playType) {
        case (PlayType)single:
            numberOfCardsInPlay = 0;
            break;
        case (PlayType)deuce:
            numberOfCardsInPlay = 2;
            break;
        case (PlayType)triple:
            numberOfCardsInPlay = 3;
            break;
        case (PlayType)set:
            numberOfCardsInPlay = 5;
            break;
        default:
            break;
    }
    
    if (numberOfCardsInPlay == 0) {
        for (Card *card in self.playerCPUisPlayingFor.hand) {
                card.chosen= YES;
                playFound = YES;
                break;
        }
    }
    else {
        
        NSMutableArray *possiblePlays = [[NSMutableArray alloc]init];
        for (NSUInteger i = 0; i < triesNumber; i++) {
            NSMutableArray *cardsChosenByBot = [[NSMutableArray alloc]init];
            NSMutableArray *usedIndex = [[NSMutableArray alloc]init];
            for (NSUInteger i = 0; i < [hand count]; i++) {
                NSString *tmpNum = [NSString stringWithFormat:@"%lu",(unsigned long)i];
                [usedIndex addObject:tmpNum];
            }
            
            for (NSUInteger i = 0; i < numberOfCardsInPlay; i++) {
                
                
                unsigned index = arc4random() % [usedIndex count];
                NSString *randomChosenIndex = [usedIndex objectAtIndex:index];
                NSNumber *number = [NSNumber numberWithLongLong: randomChosenIndex.longLongValue];
                NSUInteger indexToChooseRandomCard =  number.unsignedIntegerValue;
                Card *randomCard = nil;
                randomCard = [hand objectAtIndex:indexToChooseRandomCard];
                [usedIndex removeObjectAtIndex:index];
                NSLog(@"randomCard has a value of: %@", randomCard.contents);
                [cardsChosenByBot addObject:randomCard];
                
            }
            //if play is valid then break and add the play to an array of plays
            Play *checkPlay = [[Play alloc]initWithChosenCards:[cardsChosenByBot copy]];
            NSLog(@"checkPlay: %@", checkPlay);
            NSLog(@"play has this number of cards: %lu", [checkPlay.chosenCardsInPlay count]);
            for (Card *card in checkPlay.chosenCardsInPlay) {
                NSLog(@"This play includes: %@", card.contents);
            }
            
            if (checkPlay.isValid) {
                [possiblePlays addObject:checkPlay];
                NSLog(@"Play added");
            }
            [cardsChosenByBot removeAllObjects];
            [usedIndex removeAllObjects];
        }
        if ([possiblePlays count] > 1) {
            [CPUBot quickSortPossbilePlays:possiblePlays];
            Play *lowestValuedPlay = [possiblePlays objectAtIndex:0];
            if (lowestValuedPlay.isValid) {
                NSLog(@"lowestValuedPlay is valid");
            }
            else {
                NSLog(@"lowestValuedPlay is NOT valid");
            }
            NSLog(@"the CPU's chosen play settype is: %lu", (unsigned long)lowestValuedPlay.setType);
            for (Card *card in lowestValuedPlay.chosenCardsInPlay) {
                NSLog(@"lowestValueplay has card: %@", card.contents);
            }
            for (Card *card in self.playerCPUisPlayingFor.hand) {
                if ([lowestValuedPlay.chosenCardsInPlay containsObject:card]) {
                    card.chosen= YES;
                }
            }
            playFound = YES;
        }
        else if ([possiblePlays count] == 1) {
            Play *lowestValuedPlay = [possiblePlays objectAtIndex:0];
            for (Card *card in self.playerCPUisPlayingFor.hand) {
                if ([lowestValuedPlay.chosenCardsInPlay containsObject:card]) {
                    card.chosen= YES;
                }
            }
            playFound = YES;
        }
        else {
            NSLog(@"no set found by CPU player");
            playFound = NO;
        }
    }
    
    return playFound;
}



+(NSMutableArray *)quickSortPossbilePlays:(NSMutableArray *)unsortedDataArray
{
    
    NSMutableArray *lessArray = [[NSMutableArray alloc]init];
    NSMutableArray *greaterArray = [[NSMutableArray alloc]init];
    if ([unsortedDataArray count] <1)
    {
        return nil;
    }
    int randomPivotPoint = arc4random() % [unsortedDataArray count];
    Play *pivotPlay = [unsortedDataArray objectAtIndex:randomPivotPoint];
    [unsortedDataArray removeObjectAtIndex:randomPivotPoint];
    
    for (Play *play in unsortedDataArray) {
        
        if (play.playValue < pivotPlay.playValue)
        {
            [lessArray addObject:play];
        }
        else
        {
            [greaterArray addObject:play];
        }
        
    }
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc]init];
    [sortedArray addObjectsFromArray:[self quickSortPossbilePlays:lessArray]];
    [sortedArray addObject:pivotPlay];
    [sortedArray addObjectsFromArray:[self quickSortPossbilePlays:greaterArray]];
    return sortedArray;
}





@end
