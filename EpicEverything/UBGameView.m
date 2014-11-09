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
    _topSpaces = [NSMutableArray arrayWithCapacity:4];
    _bottomSpaces = [NSMutableArray arrayWithCapacity:4];
    for(int i=0; i<8; i+=2){
        [_topSpaces addObject:[[self.game.board spaceAtIndex:i].image ub_addToSuperview:self]];
        [_bottomSpaces addObject:[[self.game.board spaceAtIndex:i+1].image ub_addToSuperview:self]];
    }
    
    
    
    _next = [({
        UIButton *start = [[UIButton alloc] init];
        [start setTitle:@"Next" forState:UIControlStateNormal];
        start.backgroundColor = [UIColor redColor];
        //[start.titleLabel setFont:[UIFont ub_textFont]];
        [start addTarget:_delegate action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        start;
    }) ub_addToSuperview:self];
    
    _background = [({
        UIImageView *background = [[UIImageView alloc] init];
        [background setImage:[UIImage ub_gameBackground]];
        background;
    }) ub_addToBackOfSuperview:self];
    
    _playerHealth = [({
        UIImageView *health = [[UIImageView alloc] init];
        [health setImage:[UIImage ub_hp]];
        health;
    }) ub_addToSuperview:self];
    
}

- (void)updateConstraints {
    
    [self.background mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    [self.next mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([UIView ub_buttonWidth]);
        make.height.equalTo([UIView ub_buttonHeight]);
    }];
    
    [self.playerHealth mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(20.0);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([UIView ub_buttonWidth]);
        make.height.equalTo([UIView ub_buttonHeight]);
    }];
    
    [self.topSpaces[0] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(20.0);
        make.centerY.equalTo(self.mas_centerY).with.offset(20.0);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    for (int i = 0; i < 4; i++){
        
    }
    
    [super updateConstraints];
}

@end

