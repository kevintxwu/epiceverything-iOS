//
//  UBSpace.h
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBBoard.h"

@class UBCreature;
@class UBBoard;

@interface UBSpace : NSObject

@property (nonatomic) int index;
@property (nonatomic) UBBoard* board;
@property (nonatomic) UBCreature* creature;

- (BOOL) occupied;

- (id) initWithBoard:(UBBoard*)board withIndex:(int)i;

@end