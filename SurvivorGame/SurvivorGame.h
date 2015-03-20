//
//  SurvivorGame.h
//  SurvivorGame
//
//  Created by Steve Hall on 3/19/15.
//  Copyright (c) 2015 Steve Hall. All rights reserved.
//
// *******************************************************************
// This class plays out the Survivor Game
// *******************************************************************

#import <Foundation/Foundation.h>
#import "GameTurn.h"

@interface SurvivorGame : NSObject

- (GameTurn *)startNewGame:(int)numberOfChairs;
- (GameTurn *)removePerson;

@end
