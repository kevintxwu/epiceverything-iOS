//
//  UBCreditsView.h
//  EpicEverything
//
//  Created by Varun Rau on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UBCreditsViewDelegate;

@interface UBCreditsView : UIView

@property (nonatomic, weak) id<UBCreditsViewDelegate> delegate;

@end

@protocol UBCreditsViewDelegate <NSObject>

- (void)returnButtonPressed:(id)sender;

@end