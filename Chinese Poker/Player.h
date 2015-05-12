//
//  Player.h
//  Chinese Poker
//
//  Created by Tim Chang on 5/8/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Play.h"

@interface Player : NSObject

@property(strong, nonatomic) NSMutableArray *hand;

typedef NS_ENUM(NSUInteger, Status) {
    isAtTurn,
    standBy,
    passed
};
@property (nonatomic) Status playerStatus;

// sort hand method
//play hand method
//- (NSMutableArray *)makePlay;
- (Play *)makePlay;

@end
