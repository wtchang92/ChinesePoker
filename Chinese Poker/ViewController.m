//
//  ViewController.m
//  Chinese Poker
//
//  Created by Tim Chang on 5/6/15.
//  Copyright (c) 2015 Tim Chang. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "ChinesePokerGame.h"

//#import "PlayingCard.h"


@interface ViewController ()

//- (IBAction)testButton:(UIButton *)sender;
//
//@property (nonatomic) int count;
//@property (weak, nonatomic) IBOutlet UIButton *testButtonLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsInHand;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsInHandOtherPlayer1;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsInHandOtherPlayer2;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsInHandOtherPlayer3;


@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) ChinesePokerGame * game;
@end


@implementation ViewController
-(ChinesePokerGame *)game
{
    
    if (!_game) _game = [[ChinesePokerGame alloc]initWithPlayers:4 usingDeck:[self createDeck]];
    return _game;
    
    
}

-(PlayingCardDeck *)createDeck
{

    return [[PlayingCardDeck alloc]init];

}

- (IBAction)startRound:(UIButton *)sender {
    [self.game startRound];
}



- (IBAction)chooseCard:(UIButton *)sender {
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //NSLog(@"%@",[self.deck drawRandomCard].contents);
    [self.game dealHandToPlayers];
//    int counttest = 0;
//    for (Player *player in [self.game showPlayers]) {
//        NSLog(@"player %d has the following hand: ", counttest++);
//        for (Card *card in player.hand) {
//            NSLog(@"%@", card.contents);
//        }
//    }
    Player * player = [[self.game showPlayers] objectAtIndex:0];
    int count = 0;
    for (Card *card in player.hand) {
    
        [[self.cardsInHand objectAtIndex: count++] setTitle:card.contents forState:UIControlStateNormal];
    }
    Player * player1 = [[self.game showPlayers] objectAtIndex:1];
    int count1 = 0;
    for (Card *card in player1.hand) {
        
        [[self.cardsInHandOtherPlayer1 objectAtIndex: count1++] setTitle:card.contents forState:UIControlStateNormal];
    }
    Player * player2 = [[self.game showPlayers] objectAtIndex:2];
    int count2 = 0;
    for (Card *card in player2.hand) {
        
        [[self.cardsInHandOtherPlayer2 objectAtIndex: count2++] setTitle:card.contents forState:UIControlStateNormal];
    }
    Player * player3 = [[self.game showPlayers] objectAtIndex:3];
    int count3 = 0;
    for (Card *card in player3.hand) {
        
        [[self.cardsInHandOtherPlayer3 objectAtIndex: count3++] setTitle:card.contents forState:UIControlStateNormal];
    }
    
    
    
    NSLog(@"%@", [self.game testShowRoundOrder]);
    
    
    
    
//    for (int i = 0; i < 13; i++) {
//        NSLog(@"%@",[[[self.game dealHand:4] objectAtIndex:i] contents]);
//    }
//
//    PlayingCardDeck *newDeck = [[PlayingCardDeck alloc]init];
//    
//    NSLog(@"%@",[newDeck drawRandomCard].contents);
//    [_cardInHand setTitle:[newDeck drawRandomCard].contents forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view, typically from a nib.
//    _testDisplay.text = @"LOL";
//    Card *card = [[Card alloc]init];
//    Card *card2 = [[Card alloc]init];
//    card.cardSuit = (Suit)diamond;
//    card2.cardSuit = (Suit)spade;
//    if ([card suitMatch:card2]) {
//        NSLog(@"they matched");
//    }
//    else {
//        
//        NSLog(@"they didn't match");
//    
//    }
}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (IBAction)testButton:(UIButton *)sender {
//    
//    self.count++;
//    NSString* myNewString = [NSString stringWithFormat:@"%i", self.count];
//    [sender setTitle: myNewString forState:UIControlStateNormal];
//}

@end
