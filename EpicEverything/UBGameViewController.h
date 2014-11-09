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

@interface UBGameViewController : UIViewController<UBGameViewDelegate, UBCardViewDelegate>

@property (nonatomic) UBGame* game;

@end
