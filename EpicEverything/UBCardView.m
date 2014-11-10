//
//  UBCardView.m
//  EpicEverything
//
//  Created by Joel Jacobs on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBCardView.h"
#import "UIView+UBExtensions.h"

@interface UBCardView ()

@property (nonatomic) UILabel *damagePoints;
@property (nonatomic) UILabel *hitPoints;

@end


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
        [self setUpView];
        [self switchToCard];
        [self updateConstraints];
    }
    return self;
}

- (void)setUpView {
    _damagePoints = [({
        UILabel *damage = [[UILabel alloc] init];
        [damage setFont:[UIFont ub_blackCastle]];
        [damage setTextColor:[UIColor whiteColor]];
        damage.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        damage.layer.shadowColor = [UIColor blackColor].CGColor;
        damage.layer.shadowOpacity = 0.5;
        damage.textAlignment = NSTextAlignmentCenter;
        damage.hidden = NO;
        damage;
    }) ub_addToSuperview:self];
    
    _hitPoints = [({
        UILabel *hitPoints = [[UILabel alloc] init];
        [hitPoints setFont:[UIFont ub_blackCastle]];
        [hitPoints setTextColor:[UIColor whiteColor]];
        hitPoints.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        hitPoints.layer.shadowColor = [UIColor blackColor].CGColor;
        hitPoints.layer.shadowOpacity = 0.5;
        hitPoints.textAlignment = NSTextAlignmentCenter;
        hitPoints.hidden = NO;
        hitPoints;
    }) ub_addToSuperview:self];
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
    [self.damagePoints mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(-46);
        make.centerY.equalTo(self.mas_centerY).with.offset(58);
    }];
    [self.hitPoints mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(46);
        make.centerY.equalTo(self.mas_centerY).with.offset(58);
    }];
    [self.delegate cardViewMoved:self withTouch:[[event allTouches] anyObject]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.damagePoints mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(-24);
        make.centerY.equalTo(self.mas_centerY).with.offset(32);
    }];
    
    [self.hitPoints mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(24);
        make.centerY.equalTo(self.mas_centerY).with.offset(32);
    }];
    [self.delegate cardPlaced:self withTouch:[[event allTouches] anyObject]];
}

- (void)switchToPiece{
    [self.currentImageView setImage:[UIImage imageNamed: [self.card.name stringByAppendingString:@".png"]]];
    self.inCardForm = NO;
    self.damagePoints.hidden = NO;
    self.hitPoints.hidden = NO;
    self.damagePoints.text = [NSString stringWithFormat:@"%d",((UBCreature*)self.card).baseAttack];
    self.hitPoints.text = [NSString stringWithFormat:@"%d",((UBCreature*)self.card).totalHitPoints];
}

- (void)switchToCard{
    if (self.playerOneCard) {
        [self.currentImageView setImage:[UIImage imageNamed: [self.card.name stringByAppendingString:@"-card.png"]]];
        self.damagePoints.hidden = YES;
        self.hitPoints.hidden = YES;
    }
    else {
        [self.currentImageView setImage:[UIImage ub_cardBack]];
        self.damagePoints.hidden = YES;
        self.hitPoints.hidden = YES;
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
    
    [self.damagePoints mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(-24);
        make.centerY.equalTo(self.mas_centerY).with.offset(32);
    }];

    [self.hitPoints mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(24);
        make.centerY.equalTo(self.mas_centerY).with.offset(32);
    }];
    [super updateConstraints];
}

@end