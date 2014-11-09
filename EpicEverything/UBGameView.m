//
//  UBGameView.m
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBGameView.h"
#import "UIView+UBExtensions.h"

@interface UBGameView ()

@property (nonatomic) UIButton *next;
@property (nonatomic) UIImageView *background;


@end

@implementation UBGameView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubviews];
        [self updateConstraints];
    }
    return self;
}

- (void)createSubviews {
    _game = [[UBGame alloc] initTestGame];
    [_game startGame];
    for(int i=0; i<8; i++){
        [[self.game.board spaceAtIndex:i].view ub_addToSuperview:self];
    }
    for(int i=0; i<[self.game.playerOne.hand count]; i++){
        [((UBCard*)(self.game.playerOne.hand[i])).cardImageView ub_addToSuperview:self];
    }
    
    for(int i=0; i<[self.game.playerTwo.hand count]; i++){
        [((UBCard*)(self.game.playerTwo.hand[i])).cardImageView ub_addToSuperview:self];
    }
    
    
    _background = [({
        UIImageView *background = [[UIImageView alloc] init];
        [background setImage:[UIImage ub_gameBackground]];
        background;
    }) ub_addToBackOfSuperview:self];
    
   /* _playerHealth = [({
        UIImageView *health = [[UIImageView alloc] init];
        [health setImage:[UIImage ub_hp]];
        health;
    }) ub_addToSuperview:self]; */
    
    /*_next = [({
        UIButton *start = [[UIButton alloc] init];
        [start setTitle:@"Next" forState:UIControlStateNormal];
        start.backgroundColor = [UIColor redColor];
        //[start.titleLabel setFont:[UIFont ub_textFont]];
        [start addTarget:_delegate action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        start;
    }) ub_addToSuperview:self]; */
    
}

- (void)updateConstraints {
    
    [self.background mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    /* [self.next mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([UIView ub_buttonWidth]);
        make.height.equalTo([UIView ub_buttonHeight]);
    }]; */
    
    /* [self.playerHealth mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(20.0);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([UIView ub_buttonWidth]);
        make.height.equalTo([UIView ub_buttonHeight]);
    }]; */
     

    
    for (int i = 0; i < 8; i+=2){
        [[self.game.board spaceAtIndex:i].view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).with.offset(-200.0 + 50.0*i);
            make.centerY.equalTo(self.mas_centerY).with.offset(40.0);
            make.width.equalTo(@100);
            make.height.equalTo(@100);
        }];
        [[self.game.board spaceAtIndex:i+1].view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).with.offset(-150.0 + 50.0*i);
            make.centerY.equalTo(self.mas_centerY).with.offset(-40.0);
            make.width.equalTo(@100);
            make.height.equalTo(@100);
        }];
    }
    
    for (int i = 0; i < [self.game.playerOne.hand count]; i++){
        [((UBCard*)(self.game.playerOne.hand[i])).cardImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_left).with.offset(100.0 + 50.0*i);
            make.centerY.equalTo(self.mas_bottom).with.offset(-30.0);
            make.width.equalTo(@75);
            make.height.equalTo(@113);
        }];
    }
    
    for (int i = 0; i < [self.game.playerTwo.hand count]; i++){
        [((UBCard*)(self.game.playerTwo.hand[i])).cardImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_left).with.offset(100.0 + 50.0*i);
            make.centerY.equalTo(self.mas_top).with.offset(-30.0);
            make.width.equalTo(@75);
            make.height.equalTo(@113);
        }];
    }
    
    [super updateConstraints];
}

@end

