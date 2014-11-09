//
//  UBEndView.m
//  EpicEverything
//
//  Created by Varun Rau on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBEndView.h"
#import "UIView+UBExtensions.h"

@interface UBEndView ()

@property (nonatomic) UIImageView *background;
@property (nonatomic) UILabel *title;
@property (nonatomic) UIButton *playAgainButton;
@property (nonatomic) UIButton *returnButton;

@end


@implementation UBEndView

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
    
    _background = [({
        UIImageView *background = [[UIImageView alloc] init];
        [background setImage:[UIImage ub_menuBackground]];
        background;
    }) ub_addToBackOfSuperview:self];
    
    _title = [({
        UILabel *title = [[UILabel alloc] init];
        [title setFont:[UIFont ub_adventure]];
        [title setText:@"Victory!"];
        //TODO: change the text depends on if you win
        [title setTextColor:[UIColor whiteColor]];
        title.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        title.layer.shadowColor = [UIColor blackColor].CGColor;
        title.layer.shadowOpacity = 0.5;
        title;
    }) ub_addToSuperview:self];
    
    _playAgainButton = [({
        UIButton *playAgainButton = [[UIButton alloc] init];
        [playAgainButton setTitle:@"Play Again" forState:UIControlStateNormal];
        playAgainButton.backgroundColor = [UIColor clearColor];
        [playAgainButton.titleLabel setFont:[UIFont ub_uchiyama]];
        [playAgainButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [playAgainButton.layer setBorderWidth:[UIView ub_borderWidth]];
        [playAgainButton.layer setCornerRadius:[UIView ub_borderRadius]];
        playAgainButton.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        playAgainButton.layer.shadowColor = [UIColor blackColor].CGColor;
        playAgainButton.layer.shadowOpacity = 0.5;
        [playAgainButton addTarget:_delegate action:@selector(playAgainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        playAgainButton;
    }) ub_addToSuperview:self];
    
    _returnButton = [({
        UIButton *returnButton = [[UIButton alloc] init];
        [returnButton setTitle:@"Return" forState:UIControlStateNormal];
        returnButton.backgroundColor = [UIColor clearColor];
        [returnButton.titleLabel setFont:[UIFont ub_uchiyama]];
        [returnButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [returnButton.layer setBorderWidth:[UIView ub_borderWidth]];
        [returnButton.layer setCornerRadius:[UIView ub_borderRadius]];
        returnButton.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        returnButton.layer.shadowColor = [UIColor blackColor].CGColor;
        returnButton.layer.shadowOpacity = 0.5;
        [returnButton addTarget:_delegate action:@selector(returnButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        returnButton;
    }) ub_addToSuperview:self];
}

- (void)updateConstraints {
    
    [self.background mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.playAgainButton.mas_top).with.offset([[UIView ub_titlePadding] floatValue]);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset([[UIView ub_titlePadding] floatValue]);
    }];
    
    [self.playAgainButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).with.offset(20);
        make.width.equalTo([UIView ub_buttonWidth]);
    }];
    
    [self.returnButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.playAgainButton.mas_centerX);
        make.top.equalTo(self.playAgainButton.mas_bottom).with.offset([[UIView ub_padding] floatValue]);
        make.width.equalTo([UIView ub_buttonWidth]);
    }];
    
    [super updateConstraints];
}


@end
