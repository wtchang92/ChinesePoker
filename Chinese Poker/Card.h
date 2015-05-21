//
//  Card.h
//  Chinese Poker
//
//  Created by Tim Chang on 5/6/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface Card : NSObject

@property (nonatomic, strong) NSString *contents;


@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;


- (int)match:(NSArray *)otherCards;
- (NSUInteger) findCardValue;
- (NSString *) findRank;
- (NSString *) findSuit;

@end
