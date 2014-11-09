//
//  UBCardView.h
//  EpicEverything
//
//  Created by Joel Jacobs on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBGame.h"

@protocol UBCardViewDelegate;

@interface UBCardView : UIView

@property (nonatomic) UIImageView* currentImageView;
@property (nonatomic) UBCard* card;
@property (nonatomic) BOOL inCardForm;
@property (nonatomic) BOOL playerOneCard; //as opposed to opponent card
@property (nonatomic, weak) id<UBCardViewDelegate> delegate;

- (id)initWithCard:(UBCard*)card forPlayerOne:(BOOL)player;

- (void)switchToPiece;

- (void)switchToCard;

@end

@protocol UBCardViewDelegate <NSObject>

- (void)cardPressed:(id)sender withCard:(UBCard*)card;
- (void)piecePressed:(id)sender withCard:(UBCard*)card;
- (void)cardViewMoved:(UIView *)view withTouch:(UITouch *)touch;
- (void)cardPlaced:(UIView *)view withTouch:(UITouch *)touch;

@end
