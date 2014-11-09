//
//  UBGameView.m
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBGameView.h"
#import "UBCardView.h"
#import "UIView+UBExtensions.h"

@interface UBGameView ()

@property (nonatomic) UIButton *next;
@property (nonatomic) UIImageView *background;
@property (nonatomic) NSMutableArray *myHand;
@property (nonatomic) NSMutableArray *opponentHand;


@end

@implementation UBGameView


- (id)initWithFrame:(CGRect)frame andGame:(UBGame*)game{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _game = game;
        [self createSubviews];
        [self updateConstraints];
    }
    return self;
}

- (void)createSubviews {
    [_game startGame];
    for(int i=0; i<8; i++){
        [[self.game.board spaceAtIndex:i].view ub_addToSuperview:self];
    }
    
    _myHand = [NSMutableArray array];
    for(int i=0; i<[self.game.playerOne.hand count]; i++){
         UBCard *card = ((UBCard*)(self.game.playerOne.hand[i]));
        [self setUpNewCard:card playerOne:YES];
    }
    
    _opponentHand = [NSMutableArray array];
    for(int i=0; i < [self.game.playerTwo.hand count]; i++){
        UBCard *card = ((UBCard*)(self.game.playerTwo.hand[i]));
        [self setUpNewCard:card playerOne:NO];
    }
    
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
    
    /*_next = [({
        UIButton *start = [[UIButton alloc] init];
        [start setTitle:@"Next" forState:UIControlStateNormal];
        start.backgroundColor = [UIColor redColor];
        //[start.titleLabel setFont:[UIFont ub_textFont]];
        [start addTarget:_delegate action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        start;
    }) ub_addToSuperview:self]; */
    
    _playerMana = [({
        UIImageView *mana = [[UIImageView alloc] init];
        [mana setImage:[UIImage ub_mana]];
        mana;
    }) ub_addToSuperview:self];
    
    _playerCards = [({
        UIImageView *cards = [[UIImageView alloc] init];
        [cards setImage:[UIImage ub_cards]];
        cards;
    }) ub_addToSuperview:self];
    
    _opponentHealth = [({
        UIImageView *health = [[UIImageView alloc] init];
        [health setImage:[UIImage ub_hp]];
        health;
    }) ub_addToSuperview:self];
    
    _opponentMana = [({
        UIImageView *mana = [[UIImageView alloc] init];
        [mana setImage:[UIImage ub_mana]];
        mana;
    }) ub_addToSuperview:self];
    
    _opponentCards = [({
        UIImageView *cards = [[UIImageView alloc] init];
        [cards setImage:[UIImage ub_cards]];
        cards;
    }) ub_addToSuperview:self];
    
    _playerHealthLabel = [({
        UILabel *title = [[UILabel alloc] init];
        [title setFont:[UIFont ub_blackCastle]];
        [title setText:@"20"];
        [title setTextColor:[UIColor whiteColor]];
        title.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        title.layer.shadowColor = [UIColor blackColor].CGColor;
        title.layer.shadowOpacity = 0.5;
        title.textAlignment = NSTextAlignmentCenter;
        title;
    }) ub_addToSuperview:self];
    
    _playerManaLabel = [({
        UILabel *title = [[UILabel alloc] init];
        [title setFont:[UIFont ub_blackCastle]];
        [title setText:@"1"];
        [title setTextColor:[UIColor whiteColor]];
        title.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        title.layer.shadowColor = [UIColor blackColor].CGColor;
        title.layer.shadowOpacity = 0.5;
        title.textAlignment = NSTextAlignmentCenter;
        title;
    }) ub_addToSuperview:self];
    
    _playerCardsLabel = [({
        UILabel *title = [[UILabel alloc] init];
        [title setFont:[UIFont ub_blackCastle]];
        [title setText:@"15"];
        [title setTextColor:[UIColor whiteColor]];
        title.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        title.layer.shadowColor = [UIColor blackColor].CGColor;
        title.layer.shadowOpacity = 0.5;
        title.textAlignment = NSTextAlignmentCenter;
        title;
    }) ub_addToSuperview:self];
    
    _opponentHealthLabel = [({
        UILabel *title = [[UILabel alloc] init];
        [title setFont:[UIFont ub_blackCastle]];
        [title setText:@"20"];
        [title setTextColor:[UIColor whiteColor]];
        title.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        title.layer.shadowColor = [UIColor blackColor].CGColor;
        title.layer.shadowOpacity = 0.5;
        title.textAlignment = NSTextAlignmentCenter;
        title;
    }) ub_addToSuperview:self];
    
    _opponentManaLabel = [({
        UILabel *title = [[UILabel alloc] init];
        [title setFont:[UIFont ub_blackCastle]];
        [title setText:@"1"];
        [title setTextColor:[UIColor whiteColor]];
        title.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        title.layer.shadowColor = [UIColor blackColor].CGColor;
        title.layer.shadowOpacity = 0.5;
        title.textAlignment = NSTextAlignmentCenter;
        title;
    }) ub_addToSuperview:self];
    
    _opponentCardsLabel = [({
        UILabel *title = [[UILabel alloc] init];
        [title setFont:[UIFont ub_blackCastle]];
        [title setText:@"15"];
        [title setTextColor:[UIColor whiteColor]];
        title.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        title.layer.shadowColor = [UIColor blackColor].CGColor;
        title.layer.shadowOpacity = 0.5;
        title.textAlignment = NSTextAlignmentCenter;
        title;
    }) ub_addToSuperview:self];
    
    _endTurn = [({
        UIButton *start = [[UIButton alloc] init];
        [start setTitle:@"End Turn " forState:UIControlStateNormal];
        start.backgroundColor = [UIColor clearColor];
        [start.titleLabel setFont:[UIFont ub_endTurn]];
        start.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        start.layer.shadowColor = [UIColor blackColor].CGColor;
        start.layer.shadowOpacity = 0.5;
        start;
    }) ub_addToSuperview:self];
}

- (void)setUpNewCard:(UBCard*)card playerOne:(BOOL)player {
    UBCardView *cardView = [[UBCardView alloc] initWithCard:card forPlayerOne:player];
    cardView.delegate = self;
    [cardView ub_addToSuperview:self];
    if (player) {
       [self.myHand addObject: cardView];
    }
    else {
        [self.opponentHand addObject: cardView];
    }
}

- (void)removeCardView:(UBCardView*)cardView{
    [cardView removeFromSuperview];
    [self.myHand removeObject: cardView];
}

#pragma mark - UBCardViewDelegate Methods

- (void)cardViewMoved:(UIView *)view withTouch:(UITouch *)touch {
    CGPoint location = [touch locationInView:self];
    if (CGRectContainsPoint(self.bounds, location)) {
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(location.x - 15));
            make.top.equalTo(@(location.y - 110));
            // I h8 this
            make.height.equalTo(@186.5);
            make.width.equalTo(@116);
        }];
        
    }
}

- (void)cardPlaced:(UIView *)view withTouch:(UITouch *)touch {
    [self setNeedsUpdateConstraints];
}

- (void)cardPressed:(id)sender withCard:(UBCard*)card{
    
}

- (void)piecePressed:(id)sender withCard:(UBCard*)card{
    
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
    

    
    for (int i = 0; i < 8; i+=2){
        [[self.game.board spaceAtIndex:i].view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).with.offset(-175.0 + 50.0*i);
            make.centerY.equalTo(self.mas_centerY).with.offset(32.0);
            make.width.equalTo(@100);
            make.height.equalTo(@100);
        }];
        [[self.game.board spaceAtIndex:i+1].view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).with.offset(-125.0 + 50.0*i);
            make.centerY.equalTo(self.mas_centerY).with.offset(-55.0);
            make.width.equalTo(@100);
            make.height.equalTo(@100);
        }];
    }
    
    for (int i = 0; i < [self.myHand count]; i++){
        [self.myHand[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(180 + 40 * i));
            make.centerY.equalTo(self.mas_bottom).with.offset(-10.0);
            make.width.equalTo(@75);
            make.height.equalTo(@120.6);
        }];
    }
    
    for (int i = [self.opponentHand count] - 1; i >= 0; i--){
        [self.opponentHand[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-180 - 50 * i));
            make.centerY.equalTo(self.mas_top);
            make.width.equalTo(@70);
            make.height.equalTo(@108.3);
        }];
    }
    
    [self.playerHealth mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.bottom.equalTo(@-15);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.playerHealthLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.bottom.equalTo(@-14);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.playerMana mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.bottom.equalTo(@-15);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.playerManaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.bottom.equalTo(@-14);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.playerCards mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@120);
        make.bottom.equalTo(@-15);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.playerCardsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@120);
        make.bottom.equalTo(@-14);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.opponentHealth mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-108);
        make.top.equalTo(@7);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.opponentHealthLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-108);
        make.top.equalTo(@8);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.opponentMana mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-58);
        make.top.equalTo(@7);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.opponentManaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-58);
        make.top.equalTo(@8);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.opponentCards mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-8);
        make.top.equalTo(@7);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.opponentCardsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-8);
        make.top.equalTo(@8);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [self.endTurn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-12);
        make.bottom.equalTo(@-5);
    }];
    
    [super updateConstraints];
}

    
@end
