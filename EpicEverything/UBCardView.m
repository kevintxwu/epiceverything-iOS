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
@property (nonatomic) UILabel *secondsUntilAttack;
@property (nonatomic) NSMutableArray *effectIcons;
@property (nonatomic) UIImageView *swords;

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
    
    _secondsUntilAttack = [({
        UILabel *hitPoints = [[UILabel alloc] init];
        [hitPoints setFont:[UIFont ub_blackCastleBigger]];
        [hitPoints setTextColor:[UIColor whiteColor]];
        hitPoints.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        hitPoints.layer.shadowColor = [UIColor blackColor].CGColor;
        hitPoints.layer.shadowOpacity = 0.5;
        hitPoints.textAlignment = NSTextAlignmentCenter;
        hitPoints.hidden = NO;
        hitPoints;
    }) ub_addToSuperview:self];
    
    _effectIcons = [[NSMutableArray alloc] init];
    
    if(((UBCreature*)self.card).hasBlock){
        UIImageView *blockIcon = [({
            UIImageView *blockIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block"]];
            blockIcon;
        }) ub_addToSuperview:self];
        [self.effectIcons addObject:blockIcon];
    }
    
    if(((UBCreature*)self.card).hasSpeed){
        UIImageView *speedIcon = [({
            UIImageView *speedIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"speed"]];
            speedIcon;
        }) ub_addToSuperview:self];
        [self.effectIcons addObject:speedIcon];
    }
    
    if(((UBCreature*)self.card).hasRange){
        UIImageView *rangeIcon = [({
            UIImageView *rangeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"range"]];
            rangeIcon;
        }) ub_addToSuperview:self];
        [self.effectIcons addObject:rangeIcon];
    }
    
    self.swords = [({
        UIImageView *rangeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"swords"]];
        rangeIcon;
    }) ub_addToSuperview:self];
    
    [self.swords setHidden:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.playerOneCard){
        return;  //Cannot use opponent cards
    }
    if (self.inCardForm) {
        //[self.delegate cardPressed:self withCard:self.card];
    }
    else {
        [self.delegate piecePressed:self withTouch:[[event allTouches] anyObject]];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.playerOneCard){
        return;  //Cannot use opponent cards
    }
    if (self.inCardForm){
        [self.damagePoints mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).with.offset([UIView ub_widthScaled:-46]);
            make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:58]);
        }];
        [self.hitPoints mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).with.offset([UIView ub_widthScaled:-46]);
            make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:58]);
        }];
        for (int i = 0; i < [self.effectIcons count]; i++){
            [self.effectIcons[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_left).with.offset([UIView ub_widthScaled:5.0*1.55]);
                if([self.effectIcons count] > 2){
                    make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:(-32 + i * 12)*1.55]);
                }
                else if([self.effectIcons count] > 1){
                    make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:(-28 + i * 16)*1.55]);
                }
                else{
                    make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:-20*1.55]);
                }
                
                make.width.equalTo([UIView ub_selectedStatusIconWidth]);
                make.height.equalTo([UIView ub_selectedStatusIconWidth]);
            }];
            ((UIView*)self.effectIcons[i]).hidden = NO;
        }
        [self.delegate cardViewMoved:self withTouch:[[event allTouches] anyObject]];
    }
    else if (((UBCreature*)self.card).canAttackNow){
        //if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
            [self.delegate drawAttackPath:self withTouch:[[event allTouches] anyObject]];
        //}
    }
   
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.playerOneCard){
        return;  //Cannot use opponent cards
    }
    if (self.inCardForm && self.playerOneCard){
        if([self.delegate cardPlaced:self withTouch:[[event allTouches] anyObject]]){
            /*[self.damagePoints mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX).with.offset([UIView ub_widthScaled:-24]);
                make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:32]);
            }];
            
            [self.hitPoints mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX).with.offset([UIView ub_widthScaled:24]);
                make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:32]);
            }];
            for (int i = 0; i < [self.effectIcons count]; i++){
                [self.effectIcons[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.mas_left).with.offset([UIView ub_widthScaled:8.5]);
                    if([self.effectIcons count] > 2){
                        make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:(-20 + i * 20)]);
                    }
                    else if([self.effectIcons count] > 1){
                        make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:(-40 + i * 26)]);
                    }
                    else{
                        make.centerY.equalTo(self.mas_centerY);
                    }
                    make.width.equalTo([UIView ub_statusIconWidth]);
                    make.height.equalTo([UIView ub_statusIconWidth]);
                }];*/
            
            //}
            [self switchToPiece];
        }

    }
    else {
        [self.delegate cardAttack:self withTouch:[[event allTouches] anyObject]];
    }
}

- (void)switchToPiece{
    [self.currentImageView setImage:[UIImage imageNamed: [self.card.name stringByAppendingString:@".png"]]];
    
    [self.damagePoints mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset([UIView ub_widthScaled:-24]);
        make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:32]);
     }];
     
     [self.hitPoints mas_updateConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(self.mas_centerX).with.offset([UIView ub_widthScaled:24]);
         make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:32]);
     }];
    self.inCardForm = NO;
    self.damagePoints.hidden = NO;
    self.hitPoints.hidden = NO;
    UBCreature * creature = ((UBCreature*)self.card);
    self.damagePoints.text = [NSString stringWithFormat:@"%d",creature.baseAttack];
    self.hitPoints.text = [NSString stringWithFormat:@"%d", creature.hitPoints];
    if (creature.secondsSinceLastAttack >= creature.cooldown){
        //self.secondsUntilAttack.text = @"0";
        [self.secondsUntilAttack setHidden:YES];
        [self.swords setHidden:NO];
    }
    else {
        self.secondsUntilAttack.text = [NSString stringWithFormat:@"%d", creature.cooldown - creature.secondsSinceLastAttack];
        [self.secondsUntilAttack setHidden:NO];
        [self.swords setHidden:YES];
    }
    for (int i = 0; i < [self.effectIcons count]; i++){
        [self.effectIcons[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_left).with.offset([UIView ub_widthScaled:8.5]);
            if([self.effectIcons count] > 2){
                make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:(-20 + i * 20)]);
            }
            else if([self.effectIcons count] > 1){
                make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:(-11 + i * 22)]);
            }
            else{
                make.centerY.equalTo(self.mas_centerY);
            }
            make.width.equalTo([UIView ub_statusIconWidth]);
            make.height.equalTo([UIView ub_statusIconWidth]);
        }];
        
        ((UIView*)self.effectIcons[i]).hidden = NO;
    }
   
}

- (void)switchToCard{
    if (self.playerOneCard) {
        [self.currentImageView setImage:[UIImage imageNamed: [self.card.name stringByAppendingString:@"-card.png"]]];
        self.damagePoints.hidden = YES;
        self.hitPoints.hidden = YES;
        for (int i = 0; i < [self.effectIcons count]; i++){
            [self.effectIcons[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_left).with.offset([UIView ub_widthScaled:5]);
                if([self.effectIcons count] > 2){
                    make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:(-32 + i * 12)]);
                }
                else if([self.effectIcons count] > 1){
                    make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:(-28 + i * 16)]);
                }
                else{
                    make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:-20]);
                }
                
                make.width.equalTo([UIView ub_smallerStatusIconWidth]);
                make.height.equalTo([UIView ub_smallerStatusIconWidth]);
            }];
            ((UIView*)self.effectIcons[i]).hidden = NO;
        }
    }
    else {
        [self.currentImageView setImage:[UIImage ub_cardBack]];
        self.damagePoints.hidden = YES;
        self.hitPoints.hidden = YES;
        for (int i = 0; i < [self.effectIcons count]; i++){
            [self.effectIcons[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@10);
                make.height.equalTo(@10);
            }];
            ((UIView*)self.effectIcons[i]).hidden = YES;
        }
    }
    self.inCardForm = YES;
    
}

- (void)tempViewCard{
    [self.currentImageView setImage:[UIImage imageNamed: [self.card.name stringByAppendingString:@"-card.png"]]];
}



- (void)updateConstraints{
    [self.currentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
    }];
    
    [self.damagePoints mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset([UIView ub_widthScaled:-24]);
        make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:32]);
    }];

    [self.hitPoints mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset([UIView ub_widthScaled:24]);
        make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:32]);
    }];
    
    [self.secondsUntilAttack mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.swords mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([UIView ub_swordsWidth]);
        make.height.equalTo([UIView ub_swordsWidth]);
    }];
    [super updateConstraints];
}

- (BOOL)isPlayed{
    //NSLog(@"SECONDS PLAYED: %d for %@", ((UBCreature*)self.card).secondsInPlay, self.card.name);
    return ((UBCreature*)self.card).secondsInPlay >= 0;
}

- (BOOL)isAlive{
    return !((UBCreature*)self.card).isDead;
}

@end