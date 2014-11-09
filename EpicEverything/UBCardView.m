//
//  UBCardView.m
//  EpicEverything
//
//  Created by Joel Jacobs on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBCardView.h"
#import "UIView+UBExtensions.h"


@implementation UBCardView

- (id)initWithCard:(UBCard*)card forPlayerOne:(BOOL)player {
    self = [super init];
    if (self){
        _card = card;
        _inCardForm = YES;
        _playerOneCard = player;
        _currentImageView = [[UIImageView alloc] init];
        self.currentImageView.contentMode = UIViewContentModeScaleAspectFill;
        if(_playerOneCard){
            self.currentImageView.userInteractionEnabled = YES;
        }
        [_currentImageView ub_addToSuperview:self];
        [self switchToCard];
        [self updateConstraints];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.inCardForm) {
        [self.delegate cardPressed:self withCard:self.card];
    }
    else {
        [self.delegate piecePressed:self withCard:self.card];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate cardViewMoved:self withTouch:[[event allTouches] anyObject]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate cardPlaced:self withTouch:[[event allTouches] anyObject]];
}

- (void)switchToPiece{
    [self.currentImageView setImage:[UIImage imageNamed: [self.card.name stringByAppendingString:@".png"]]];
    self.inCardForm = NO;
    
}

- (void)switchToCard{
    if (self.playerOneCard) {
        [self.currentImageView setImage:[UIImage imageNamed: [self.card.name stringByAppendingString:@"-card.png"]]];
    }
    else {
        [self.currentImageView setImage:[UIImage ub_cardBack]];
    }
    self.inCardForm = YES;
    
}

- (void)updateConstraints{
    [self.currentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
    }];
    [super updateConstraints];
}

@end