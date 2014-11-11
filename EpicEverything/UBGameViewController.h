//
//  GameViewController.h
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBGameView.h"
#import "UBGame.h"
#import "UBCardView.h"
#import "UBSpaceView.h"

@interface UBGameViewController : UIViewController <UBCardViewDelegate, UBSpaceViewDelegate>

@property (nonatomic) UBGame* game;

- (void) startGame;

@end
