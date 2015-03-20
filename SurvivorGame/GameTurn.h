//
//  GameTurn.h
//  SurvivorGame
//
//  Created by Steve Hall on 3/19/15.
//  Copyright (c) 2015 Steve Hall. All rights reserved.
//
// *******************************************************************
// This class is used to store data from the current turn of the game
// *******************************************************************

#import <Foundation/Foundation.h>

@interface GameTurn : NSObject

@property (strong, nonatomic) NSString *turnDescription;    // This varialbe is used in unit tests, but not in UI
@property (nonatomic) int removedPlayerNumber;
@property (nonatomic) int winningPlayerNumber;
@property (nonatomic) BOOL gameOver;

@end
