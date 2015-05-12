//
//  ViewController.h
//  Chinese Poker
//
//  Created by Tim Chang on 5/6/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


//@property (weak, nonatomic) IBOutlet UILabel *testDisplay;


@property (weak, nonatomic) IBOutlet UIButton *playerAction;
@property (weak, nonatomic) IBOutlet UIButton *player1Action;
@property (weak, nonatomic) IBOutlet UIButton *player2Action;
@property (weak, nonatomic) IBOutlet UIButton *player3Action;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSMutableArray *cardsInHand;
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsInHandOtherPlayer1;
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsInHandOtherPlayer2;
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsInHandOtherPlayer3;


@end

