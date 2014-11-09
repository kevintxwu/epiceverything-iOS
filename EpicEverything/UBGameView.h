//
//  UBGameView.h
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBGame.h"


@protocol UBGameViewDelegate;

@interface UBGameView : UIView

@property (nonatomic, weak) id<UBGameViewDelegate> delegate;
@property (nonatomic) NSMutableArray *topSpaces;
@property (nonatomic) NSMutableArray *bottomSpaces;
@property (nonatomic) UBBoard *board;
@property (nonatomic) UBGame *game;
@property (nonatomic) UIImageView *playerHealth;
@property (nonatomic) UIImageView *opponentHealth;
@property (nonatomic) UIImageView *playerCards;
@property (nonatomic) UIImageView *opponentCards;
@property (nonatomic) UIImageView *playerMana;
@property (nonatomic) UIImageView *opponentMana;

@end

@protocol UBGameViewDelegate <NSObject>

- (void)nextButtonPressed:(id)sender;

@end
