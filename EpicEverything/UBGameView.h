//
//  UBGameView.h
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBGame.h"
#import "UBCardView.h"
#import "UBGameViewController.h"


@protocol UBGameViewDelegate;

@interface UBGameView : UIView<UBCardViewDelegate>

@property (nonatomic, weak) id<UBGameViewDelegate> delegate;
@property (nonatomic) UBBoard *board;
@property (nonatomic) UBGame *game;
@property (nonatomic) UIImageView *playerHealth;
@property (nonatomic) UIImageView *opponentHealth;
@property (nonatomic) UIImageView *playerCards;
@property (nonatomic) UIImageView *opponentCards;
@property (nonatomic) UIImageView *playerMana;
@property (nonatomic) UIImageView *opponentMana;

@property (nonatomic) UILabel *playerHealthLabel;
@property (nonatomic) UILabel *opponentHealthLabel;
@property (nonatomic) UILabel *playerCardsLabel;
@property (nonatomic) UILabel *opponentCardsLabel;
@property (nonatomic) UILabel *playerManaLabel;
@property (nonatomic) UILabel *opponentManaLabel;

@property (nonatomic) UIButton *endTurn;

- (id)initWithFrame:(CGRect)frame andGame:(UBGame*)game;

- (void) updateBoardConstraints;

- (void) updateBoard;

- (UBCardView*)setUpNewCard:(UBCard*)card playerOne:(BOOL)player;

@end

@protocol UBGameViewDelegate <NSObject>

- (void)endTurnPressed:(id)sender;


@end
