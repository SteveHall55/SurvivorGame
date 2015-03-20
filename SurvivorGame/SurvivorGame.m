//
//  SurvivorGame.m
//  SurvivorGame
//
//  Created by Steve Hall on 3/19/15.
//  Copyright (c) 2015 Steve Hall. All rights reserved.
//

#import "SurvivorGame.h"

#define kTurnWinnerText @"We have a winner!";
#define kTurnPersonRemoved @"Person was removed.";
#define kTurnInvalidNumberOfChairsError @"Number of chairs to start the game must be at least 1.";
#define kTurnPersonNotRemovedError @"Person not removed, game is already over.";

@interface SurvivorGame()

@property (strong, nonatomic) NSMutableArray *chairs; // of int
@property (nonatomic) int numberOfChairs;
@property (nonatomic) int currentPersonIndex;
@property (strong, nonatomic) GameTurn *gameTurn;

@end

@implementation SurvivorGame

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.chairs = [[NSMutableArray alloc] init];
        self.gameTurn = [[GameTurn alloc] init];
    }
    
    return self;
}

// Start a new game
// Returns the gameTurn
- (GameTurn *)startNewGame:(int)numberOfChairs
{
    if (numberOfChairs < 1)
    {
        // Invalid numberOfChairs entered
        self.gameTurn.turnDescription = kTurnInvalidNumberOfChairsError;
        self.gameTurn.gameOver = YES;    // Set this to YES because the game is not able to continue
        self.gameTurn.removedPlayerNumber = 0;
        self.gameTurn.winningPlayerNumber = 0;
    }
    else if (numberOfChairs == 1)
    {
        // Special case: numberOfChairs is 1
        self.gameTurn.turnDescription = kTurnWinnerText;
        self.gameTurn.gameOver = YES;
        self.gameTurn.removedPlayerNumber = 0;
        self.gameTurn.winningPlayerNumber = 1;
    }
    else
    {
        // Make sure these are set for a new game
        self.gameTurn.gameOver = NO;
        self.gameTurn.winningPlayerNumber = 0;
        self.currentPersonIndex = 0;
        
        // Remove all chairs from the last game (this won't do anything if it's the first game)
        [self.chairs removeAllObjects];
        
        // Populate the chairs for the next game
        for (int i = 0; i < numberOfChairs; i++)
        {
            [self.chairs addObject:[NSNumber numberWithInt:(i + 1)]];
        }
    }
    
    return self.gameTurn;
}

// Removes a person from the game
// Returns the gameTurn
- (GameTurn *)removePerson
{
    // Only remove a person if the game is not over (it's over when there's only one chair left)
    if ([self.chairs count] == 1)
    {
        self.gameTurn.turnDescription = kTurnPersonNotRemovedError;
        self.gameTurn.gameOver = YES;
    }
    else
    {
        // Determine who the person number who is being removed and then remove them
        NSNumber *removedPersonNumber = (NSNumber *)[self.chairs objectAtIndex:self.currentPersonIndex];
        [self.chairs removeObjectAtIndex:self.currentPersonIndex];
        
        // We removed an object at self.currentPersonIndex, so now the currentPersonIndex is pointing at the next person
        // (unless we are at the end of the array, then it is pointing at index outside of the range)
        if (self.currentPersonIndex == [self.chairs count])
        {
            // We are at the end of the array, so the person to be skipped is at index 0
            self.currentPersonIndex  = 0;
        }
        
        // Since we need to skip the current person, increment the index to get the next person
        self.currentPersonIndex++;
        if (self.currentPersonIndex == [self.chairs count])
        {
            // We reached the end of the array, so go the the first element
            self.currentPersonIndex = 0;
        }
        // self.currentPersonIndex is now pointing at the next person to be removed
        
        // Determine if the game is over: this will happen if there are only 1 chair left
        if ([self.chairs count] == 1)
        {
            // Game is over
            self.gameTurn.gameOver = YES;
            self.gameTurn.turnDescription = kTurnWinnerText;
            self.gameTurn.winningPlayerNumber = [[self.chairs objectAtIndex:0] intValue];
        }
        else
        {
            // Player removed, so set that in the description
            self.gameTurn.turnDescription = kTurnPersonRemoved;
        }

        // Set the removed player's number
        self.gameTurn.removedPlayerNumber = [removedPersonNumber intValue];
    }

    return self.gameTurn;
}

@end
