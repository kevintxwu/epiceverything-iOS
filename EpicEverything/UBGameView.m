//
//  UBGameView.m
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBGameView.h"
#import "UBCardView.h"
#import "UBGameViewController.h"
#import "UIView+UBExtensions.h"
#define kArrowPointCount 7

@interface UBGameView ()

@property (nonatomic) UIButton *next;
@property (nonatomic) UIImageView *background;
@property (nonatomic) NSMutableArray *spaces;
@property (nonatomic) NSMutableArray *allCards;
@property (nonatomic) NSMutableArray *playedCards;
@property (nonatomic) UIImageView *drawLayer;
@property (nonatomic) CGPoint location;
@property (nonatomic) UBCardView *selectedCard;
@property (nonatomic) UBCardView *animatingCard;
@property (nonatomic) UBCardView *dyingCard;
@property (nonatomic) UBCardView *attackingCardView;
@property (nonatomic) UILabel *secondsLeftLabel;
@property (nonatomic) BOOL firstUpdate;

@property (nonatomic) int playerHandSize;
@property (nonatomic) int opponentHandSize;
@property (nonatomic) double sizeMultiplier;


@end

@implementation UBGameView


- (id)initWithFrame:(CGRect)frame andGame:(UBGame*)game {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _game = game;
        _allCards = [NSMutableArray array];
        _firstUpdate = YES;
        [self createSubviews];
        [self updateConstraints];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.sizeMultiplier = 2.0;
        }
        else{
            self.sizeMultiplier = 1;
        }
    }
    return self;
}

- (void)createSubviews {
    _spaces = [NSMutableArray arrayWithCapacity:8];
    for(int i=0; i<8; i++){
        UBSpaceView* spaceView = [[UBSpaceView alloc] initWithSpace:[self.game.board spaceAtIndex:i]];
        [spaceView ub_addToSuperview:self];
        [self.spaces addObject:spaceView];
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
        [cards setImage:[UIImage imageNamed:@"hourglass"]];
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
        [cards setImage:[UIImage imageNamed:@"hourglass"]];
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
        [title setText:@"0"];
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
        [title setText:@"0"];
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
    
    /*_endTurn = [({
        UIButton *start = [[UIButton alloc] init];
        [start setTitle:@"End Turn " forState:UIControlStateNormal];
        start.backgroundColor = [UIColor clearColor];
        [start.titleLabel setFont:[UIFont ub_endTurn]];
        start.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        start.layer.shadowColor = [UIColor blackColor].CGColor;
        start.layer.shadowOpacity = 0.5;
        start;
    }) ub_addToSuperview:self];*/
    
    /*_secondsLeftLabel = [({
        UILabel *title = [[UILabel alloc] init];
        [title setFont:[UIFont ub_endTurn]];
        [title setText:@"Next Turn: 15"];
        [title setTextColor:[UIColor whiteColor]];
        title.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        title.layer.shadowColor = [UIColor blackColor].CGColor;
        title.layer.shadowOpacity = 0.5;
        title.textAlignment = NSTextAlignmentCenter;
        title;
    }) ub_addToSuperview:self];*/
    
    
    _drawLayer = [({
        UIImageView *drawLayer = [[UIImageView alloc] init];
        self.drawLayer.clearsContextBeforeDrawing = YES;
        drawLayer;
    }) ub_addToSuperview:self];
    
    
    //[self.endTurn addTarget:self.delegate action:@selector(endTurnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (UBCardView*)setUpNewCard:(UBCard*)card playerOne:(BOOL)player{
    UBCardView *cardView = [[UBCardView alloc] initWithCard:card forPlayerOne:player];
    cardView.delegate = self;
    [cardView ub_addToSuperview:self];
    [self bringSubviewToFront:cardView];
    [self drawCardAnimation:cardView playerOne:player];
    return cardView;
}

- (void)drawCardAnimation:(UBCardView*)card playerOne:(BOOL)player {

    
    if(player){
        [card switchToCard];
        [card mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_right).with.offset([UIView ub_widthSpacingScaled:-10.0]);
            make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:20.0]);
            make.width.equalTo([UIView ub_cardWidth]);
            make.height.equalTo([UIView ub_cardHeight]);
        }];
        [card layoutIfNeeded];
        
        
        [card mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset([UIView ub_widthScaled:(140 + 40 * [self.game.playerOne.hand count])]);
            make.centerY.equalTo(self.mas_bottom).with.offset(-10.0);
            make.width.equalTo([UIView ub_cardWidth]);
            make.height.equalTo([UIView ub_cardHeight]);
        }];
        
        
        
        [UIView animateWithDuration:.5 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void) {
                             [card layoutIfNeeded];
                         }
                         completion:^(BOOL finished){
                             [self.allCards addObject:card];
                             [self bringSubviewToFront:card];
                         }
         ];

        
    }
    
    else{
        [card switchToCard];
        [card mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset([UIView ub_widthSpacingScaled:10.0]);
            make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:-20.0]);
            make.width.equalTo([UIView ub_opponentCardWidth]);
            make.height.equalTo([UIView ub_opponentCardHeight]);
        }];
        [card layoutIfNeeded];
        
        [card mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset([UIView ub_widthScaled:(-180 - 50 * self.opponentHandSize)]);
            make.centerY.equalTo(self.mas_top);
            make.width.equalTo([UIView ub_cardWidth]);
            make.height.equalTo([UIView ub_cardHeight]);
        }];
        
        [UIView animateWithDuration:.5 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void) {
                             [card layoutIfNeeded];
                         }
                         completion:^(BOOL finished){
                             [self.allCards addObject:card];
                             [self bringSubviewToFront:card];
                         }
         ];

        
        
    }
}





#pragma mark - UBCardViewDelegate Methods


- (void)cardViewMoved:(UBCardView *)view withTouch:(UITouch *)touch {
    CGPoint location = [touch locationInView:self];
    self.selectedCard = view;
    if (CGRectContainsPoint(self.bounds, location)) {
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(location.x - [UIView ub_widthScaled:15]));
            make.top.equalTo(@(location.y - [UIView ub_heightScaled:110]));
            // I h8 this
            make.height.equalTo([UIView ub_selectedCardHeight]);
            make.width.equalTo([UIView ub_selectedCardWidth]);
        }];
    }
}

- (BOOL)cardPlaced:(UBCardView *)view withTouch:(UITouch *)touch {
    // Check if we are on a space
    self.selectedCard = nil;
    CGPoint location = [touch locationInView:self];
    UBSpaceView *spaceView = [self locationOnSpace:location];
    NSLog(@"INDEX %d", [spaceView.space getIndex]);
    if (spaceView && [self.game.playerOne canPlayCard:view.card atSpace:spaceView.space.position]) {
        // Play card
        [self.game.playerOne playCard:view.card atSpace:[spaceView.space getIndex]];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(spaceView.mas_left);
            make.right.equalTo(spaceView.mas_right);
            make.top.equalTo(spaceView.mas_top);
            make.bottom.equalTo(spaceView.mas_bottom);
            make.centerY.equalTo(spaceView.mas_centerY);
            make.centerX.equalTo(spaceView.mas_centerX);
            make.width.equalTo([UIView ub_spaceWidth]);
            make.height.equalTo([UIView ub_spaceWidth]);
        }];
        return YES;
    } else {
        //[self updateBoard];
        return NO;
    }
}

- (void)piecePressed:(UBCardView *)view withTouch:(UITouch *)touch{
    self.location = [touch locationInView:self];
}


- (void)drawAttackPath:(UBCardView *)view withTouch:(UITouch *)touch{
    //NSLog(@"Draw");
    CGPoint currentLocation = [touch locationInView:self];
    UBSpaceView *spaceView = [self locationOnSpace:currentLocation];
    UBCreature *selectedCreature = (UBCreature *) view.card;
    self.drawLayer.image = nil;
    self.attackingCardView = view;
    CGRect rect = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    UIGraphicsBeginImageContext(rect.size); //now it's here.
    [[UIColor colorWithRed:84/255.0 green:194/255.0 blue:197/255.0 alpha:1.0] setStroke];
    if (spaceView && view.playerOneCard &&[selectedCreature canAttackSpace:spaceView.space]) {
        [[UIColor colorWithRed:239/255.0 green:87/255.0 blue:88/255.0 alpha:1.0] setStroke];
    }
    UIBezierPath *bezier = [self dqd_bezierPathWithArrowFromPoint:self.location toPoint:currentLocation tailWidth:[UIView  ub_widthScaled:4.0f] headWidth:[UIView  ub_widthScaled:25.0f] headLength:[UIView  ub_widthScaled:15.0f]];
    
    [bezier setLineJoinStyle:kCGLineJoinMiter];
    [bezier setLineCapStyle:kCGLineCapButt];
    [bezier setLineWidth:[UIView  ub_widthScaled:12.0f]];
    [bezier stroke];

    self.drawLayer.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsPopContext();
    UIGraphicsEndImageContext();
    
}

- (void)cardAttack:(UBCardView *)view withTouch:(UITouch *)touch {
    self.drawLayer.image = nil;
    self.attackingCardView = nil;
    [self bringSubviewToFront:self.drawLayer];
    CGPoint location = [touch locationInView:self];
    UBSpaceView *spaceView = [self locationOnSpace:location];
    UBCreature *selectedCreature = (UBCreature *) view.card;
    /*if(spaceView && spaceView.space == ((UBCreature *)view.card).space){
        [self bringSubviewToFront:view];
        NSLog(@"Showing card");
        [view tempViewCard];
        
    }*/
    if (spaceView && view.playerOneCard &&[selectedCreature canAttackSpace:spaceView.space]) {
        [self attackCardAnimation:view andTargetPosition:spaceView.space.position];
        
        //[self updateBoard];
    } else {
        //[self updateBoard];
    }
}

- (UIBezierPath *)dqd_bezierPathWithArrowFromPoint:(CGPoint)startPoint
                                           toPoint:(CGPoint)endPoint
                                         tailWidth:(CGFloat)tailWidth
                                         headWidth:(CGFloat)headWidth
                                        headLength:(CGFloat)headLength {
    CGFloat length = hypotf(endPoint.x - startPoint.x, endPoint.y - startPoint.y);
    
    CGPoint points[kArrowPointCount];
    [self dqd_getAxisAlignedArrowPoints:points
                              forLength:length
                              tailWidth:tailWidth
                              headWidth:headWidth
                             headLength:headLength];
    
    CGAffineTransform transform = [self dqd_transformForStartPoint:startPoint
                                                          endPoint:endPoint
                                                            length:length];
    
    CGMutablePathRef cgPath = CGPathCreateMutable();
    CGPathAddLines(cgPath, &transform, points, sizeof points / sizeof *points);
    CGPathCloseSubpath(cgPath);
    
    UIBezierPath *uiPath = [UIBezierPath bezierPathWithCGPath:cgPath];
    CGPathRelease(cgPath);
    return uiPath;
}

- (void)dqd_getAxisAlignedArrowPoints:(CGPoint[kArrowPointCount])points
                            forLength:(CGFloat)length
                            tailWidth:(CGFloat)tailWidth
                            headWidth:(CGFloat)headWidth
                           headLength:(CGFloat)headLength {
    CGFloat tailLength = length - headLength;
    points[0] = CGPointMake(0, tailWidth / 2);
    points[1] = CGPointMake(tailLength, tailWidth / 2);
    points[2] = CGPointMake(tailLength, headWidth / 2);
    points[3] = CGPointMake(length, 0);
    points[4] = CGPointMake(tailLength, -headWidth / 2);
    points[5] = CGPointMake(tailLength, -tailWidth / 2);
    points[6] = CGPointMake(0, -tailWidth / 2);
}

- (CGAffineTransform)dqd_transformForStartPoint:(CGPoint)startPoint
                                       endPoint:(CGPoint)endPoint
                                         length:(CGFloat)length {
    CGFloat cosine = (endPoint.x - startPoint.x) / length;
    CGFloat sine = (endPoint.y - startPoint.y) / length;
    return (CGAffineTransform){ cosine, sine, -sine, cosine, startPoint.x, startPoint.y };
}


- (void)cardPressed:(id)sender withCard:(UBCard*)card {
    
}




- (void)attackCardAnimation:(UBCardView*)card andTargetPosition:(int)targetPosition{
    UBSpaceView *target_space = self.spaces[targetPosition];
    NSLog(@"TARGET: %d", targetPosition);
    UBSpaceView *curr_space = self.spaces[((UBCreature *)card.card).space.position];
    //double angle = atan(((double)(space.center.x - card.center.x)) / (space.center.y - card.center.y));
    //[self bringSubviewToFront:card];
    self.animatingCard = card;
    [self bringSubviewToFront:card];
    //NSAssert(card && curr_space && target_space, @"SPACES AND CARD SHOULD EXIST");
    [card mas_remakeConstraints:^(MASConstraintMaker *make) {
        if(targetPosition % 2 == 0){
            NSLog(@"ATTACKING BOTTOM");
            make.bottom.equalTo(target_space.mas_centerY).with.offset([UIView ub_heightScaled:20]);
        }
        else{
            make.top.equalTo(target_space.mas_centerY).with.offset([UIView ub_heightScaled:-20]);
        }
        if(targetPosition > curr_space.space.position){
            make.right.equalTo(target_space.mas_centerX).with.offset([UIView ub_widthScaled:20]);
        }
        else{
            make.left.equalTo(target_space.mas_centerX).with.offset([UIView ub_widthScaled:-20]);
        }
        
        make.width.equalTo([UIView ub_spaceWidth]);
        make.height.equalTo([UIView ub_spaceHeight]);
        
    }];
    
    
    
    [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         [card layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                         UBCardView* enemy = [self getCardViewAtSpace:targetPosition];
                         
                         [(UBCreature*)card.card attackSpace:target_space.space];
                         
                         if(((UBCreature*)card.card).hitPoints <= 0){
                             [self deathAnimation:card attacker:YES];
                         }
                         else{
                             [card mas_remakeConstraints:^(MASConstraintMaker *make) {
                                 make.left.equalTo(curr_space.mas_left);
                                 make.right.equalTo(curr_space.mas_right);
                                 make.top.equalTo(curr_space.mas_top);
                                 make.bottom.equalTo(curr_space.mas_bottom);
                                 make.width.equalTo([UIView ub_spaceWidth]);
                                 make.height.equalTo([UIView ub_spaceHeight]);
                             }];
                             
                             
                             
                             [UIView animateWithDuration:.7 animations:^{
                                 [card layoutIfNeeded];
                                 self.animatingCard = nil;
                             }];
                         }
                         
                         if(enemy && ((UBCreature*)enemy.card).hitPoints <= 0){
                             self.dyingCard = enemy;
                            [self deathAnimation:enemy attacker:NO];
                         }
                         

                     }];
    
    
}


- (UBCardView *)getCardViewAtSpace:(int)spacePosition{
    for(UBCardView* card in self.playedCards){
        if(((UBCreature *)card.card).space.position == spacePosition){
            return card;
        }
    }
    return nil;
}

- (void) deathAnimation:(UBCardView*)card attacker:(BOOL)isAttacker{
    
    
    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         [card setAlpha:0.0];
                     }
                     completion:^(BOOL finished){
                         
                         if(isAttacker){
                            self.animatingCard = nil;
                         }
                         else{
                             self.dyingCard = nil;
                         }
                         
                         if(self.attackingCardView && card == self.attackingCardView){
                             self.attackingCardView = nil;
                             self.drawLayer.image = nil;
                         }
                         
                     }];

}

- (UBSpaceView *)locationOnSpace:(CGPoint)location {
    for (UBSpaceView *spaceView in self.spaces) {
        CGRect frame = spaceView.frame;
        if (CGRectContainsPoint(frame, location)) {
            return spaceView;
        }
    }
    return nil;
}

- (void)updateConstraints {
    
    if (self.firstUpdate){
        
    
    NSLog(@"UPDATING CONSTRAINTS");
    
        [self.background mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.drawLayer mas_updateConstraints:^(MASConstraintMaker *make) {
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
            [self.spaces[i] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX).with.offset([UIView ub_widthScaled:(-175.0 + 50.0*i)]);
                make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:32.0]);
                make.width.equalTo([UIView ub_spaceWidth]);
                make.height.equalTo([UIView ub_spaceWidth]);
            }];
            [self.spaces[i+1] mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX).with.offset([UIView ub_widthScaled:(-125.0 + 50.0*i)]);
                make.centerY.equalTo(self.mas_centerY).with.offset([UIView ub_heightScaled:-55.0]);
                make.width.equalTo([UIView ub_spaceWidth]);
                make.height.equalTo([UIView ub_spaceWidth]);
            }];
        }
        
        [self.playerHealth mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset([UIView ub_widthSpacingScaled:20.0]);
            make.bottom.equalTo(self.mas_bottom).with.offset([UIView ub_heightSpacingScaled: -15]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
        [self.playerHealthLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset([UIView ub_widthSpacingScaled:20.0]);
            make.bottom.equalTo(self.mas_bottom).with.offset([UIView ub_heightSpacingScaled: -14]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
        [self.playerMana mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset([UIView ub_widthSpacingScaled:70.0]);
             make.bottom.equalTo(self.mas_bottom).with.offset([UIView ub_heightSpacingScaled: -15]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
        [self.playerManaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset([UIView ub_widthSpacingScaled:70.0]);
             make.bottom.equalTo(self.mas_bottom).with.offset([UIView ub_heightSpacingScaled: -14]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
        [self.playerCards mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset([UIView ub_widthSpacingScaled:120.0]);
             make.bottom.equalTo(self.mas_bottom).with.offset([UIView ub_heightSpacingScaled: -15]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
        [self.playerCardsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset([UIView ub_widthSpacingScaled:120.0]);
             make.bottom.equalTo(self.mas_bottom).with.offset([UIView ub_heightSpacingScaled: -14]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
        [self.opponentHealth mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset([UIView ub_widthSpacingScaled:-108]);
            make.top.equalTo(self.mas_top).with.offset([UIView ub_heightSpacingScaled: 7]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
        [self.opponentHealthLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset([UIView ub_widthSpacingScaled:-108]);
            make.top.equalTo(self.mas_top).with.offset([UIView ub_heightSpacingScaled: 8]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
        [self.opponentMana mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset([UIView ub_widthSpacingScaled:-58]);
            make.top.equalTo(self.mas_top).with.offset([UIView ub_heightSpacingScaled: 7]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
        [self.opponentManaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset([UIView ub_widthSpacingScaled:-58]);
            make.top.equalTo(self.mas_top).with.offset([UIView ub_heightSpacingScaled: 8]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
        [self.opponentCards mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset([UIView ub_widthSpacingScaled:-8]);
            make.top.equalTo(self.mas_top).with.offset([UIView ub_heightSpacingScaled: 7]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
        [self.opponentCardsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset([UIView ub_widthSpacingScaled:-8]);
            make.top.equalTo(self.mas_top).with.offset([UIView ub_heightSpacingScaled: 8]);
            make.width.equalTo([UIView ub_iconWidth]);
            make.height.equalTo([UIView ub_iconWidth]);
        }];
        
       /* [self.secondsLeftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-20.0);
             make.bottom.equalTo(self.mas_bottom).with.offset(-5.0);
        }];*/
        
        /*[self.endTurn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-12);
            make.bottom.equalTo(@-5);
        }];*/
        
        self.firstUpdate = NO;
    }
    [super updateConstraints];
}

- (void) updateBoard {
    NSMutableArray *myHand = [NSMutableArray array];
    NSMutableArray *opponentHand = [NSMutableArray array];
    self.playedCards = [NSMutableArray array];
    //NSLog(@"CARDS ON SCREEN %lu", (unsigned long)[self.allCards count]);
    
    for (int i = 0; i < [self.allCards count]; i++){
        UBCardView *curr = (UBCardView*)(self.allCards[i]);
        if(curr != self.animatingCard && curr != self.dyingCard){
            if (![curr isAlive]){
                [self.allCards removeObject:curr];
                i--;
                [curr removeFromSuperview];
            }
            else if ([curr isPlayed] ){
                //NSLog(@"PLAYED");
                [self.playedCards addObject:curr];
            }
            else if (curr.playerOneCard){
                [myHand addObject:curr];
            }
            else if (!curr.playerOneCard){
                [opponentHand addObject:curr];
            }
        }
    }
    
     //NSLog(@"MY HAND %lu", (unsigned long)[myHand count]);
     //NSLog(@"OPP HAND %lu", (unsigned long)[opponentHand count]);
    self.playerHandSize = [myHand count];
    
    for (int i = 0; i < [myHand count]; i++){
        if (self.selectedCard != myHand[i]){
            [myHand[i] switchToCard];
            [myHand[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@([UIView ub_widthScaled:(180 + 40 * i)]));
                make.centerY.equalTo(self.mas_bottom).with.offset([UIView ub_heightScaled:-10.0]);
                make.width.equalTo([UIView ub_cardWidth]);
                make.height.equalTo([UIView ub_cardHeight]);
            }];
        }
        //[self bringSubviewToFront:myHand[i]];
    }
    
    for (int i = [opponentHand count] - 1; i >= 0; i--){
        [opponentHand[i] switchToCard];
        [opponentHand[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@([UIView ub_widthScaled:(-180 - 50 * i)]));
            make.centerY.equalTo(self.mas_top);
            make.width.equalTo([UIView ub_opponentCardWidth]);
            make.height.equalTo([UIView ub_opponentCardHeight]);
        }];
        
    }
    
    self.opponentHandSize = [opponentHand count];
    
    for (int i = 0; i < [self.playedCards count]; i++){
        UBCardView* cardView = (UBCardView*) self.playedCards[i];
        
        UBSpaceView *spaceView = self.spaces[[((UBCreature*)(cardView.card)).space getIndex]];
        if (self.animatingCard != self.playedCards[i]){
            [cardView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(spaceView.mas_left);
                make.right.equalTo(spaceView.mas_right);
                make.top.equalTo(spaceView.mas_top);
                make.bottom.equalTo(spaceView.mas_bottom);
                make.centerY.equalTo(spaceView.mas_centerY);
                make.centerX.equalTo(spaceView.mas_centerX);
                make.width.equalTo([UIView ub_spaceWidth]);
                make.height.equalTo([UIView ub_spaceWidth]);
            }];
        }

        
        [cardView switchToPiece];
    }
    
    self.playerHealthLabel.text = [NSString stringWithFormat: @"%d", self.game.playerOne.health];
    self.playerManaLabel.text = [NSString stringWithFormat: @"%d", self.game.playerOne.mana];
    self.playerCardsLabel.text = [NSString stringWithFormat: @"%d", self.game.turnLength - self.secondsPassed];
    self.opponentHealthLabel.text = [NSString stringWithFormat: @"%d", self.game.playerTwo.health];
    self.opponentManaLabel.text = [NSString stringWithFormat: @"%d", self.game.playerTwo.mana];
    self.opponentCardsLabel.text = [NSString stringWithFormat: @"%d", self.game.turnLength - self.secondsPassed];

    [self bringSubviewToFront:self.drawLayer];

}





@end
