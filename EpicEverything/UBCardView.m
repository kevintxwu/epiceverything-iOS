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

- (id)initWithCard:(UBCard*)card {
    self = [super init];
    if (self){
        _card = card;
        _inCardForm = YES;
        _currentImageView = [[UIImageView alloc] init];
        self.currentImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.currentImageView.userInteractionEnabled = YES;
        [_currentImageView ub_addToSuperview:self];
        [self switchToCard];
        [self updateConstraints];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touched!");
    if(self.inCardForm){
        [_delegate cardPressed:self withCard:self.card];
    }
    else{
        [_delegate piecePressed:self withCard:self.card];
    }
}



- (void)switchToPiece{
    [self.currentImageView setImage:[UIImage imageNamed: [self.card.name stringByAppendingString:@".png"]]];
    self.inCardForm = NO;
    
}

- (void)switchToCard{
    [self.currentImageView setImage:[UIImage imageNamed: [self.card.name stringByAppendingString:@"-card.png"]]];
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