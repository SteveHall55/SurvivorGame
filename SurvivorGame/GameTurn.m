//
//  GameTurn.m
//  SurvivorGame
//
//  Created by Steve Hall on 3/19/15.
//  Copyright (c) 2015 Steve Hall. All rights reserved.
//

#import "GameTurn.h"

@implementation GameTurn

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.turnDescription = @"";
        self.gameOver = NO;
        self.removedPlayerNumber = 0;
        self.winningPlayerNumber = 0;
    }
    
    return self;
}

@end
