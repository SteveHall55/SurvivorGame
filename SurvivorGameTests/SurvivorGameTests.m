//
//  SurvivorGameTests.m
//  SurvivorGameTests
//
//  Created by Steve Hall on 3/19/15.
//  Copyright (c) 2015 Steve Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SurvivorGame.h"
#import "GameTurn.h"

#define kWinnerText @"We have a winner!";
#define kInvalidNumberOfChairsError @"Number of chairs to start the game must be at least 1.";
#define kPersonNotRemovedError @"Person not removed, game is already over.";

@interface SurvivorGameTests : XCTestCase

@end

@implementation SurvivorGameTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGames
{
    SurvivorGame *survivorGame = [[SurvivorGame alloc] init];
    GameTurn *gameTurn;

    // Test N = 0
    gameTurn = [survivorGame startNewGame:0];
    XCTAssertEqualObjects(gameTurn.turnDescription, @"Number of chairs to start the game must be at least 1.", @"N = 0: Not a valid game.");
    
    // Test N = 1
    gameTurn = [survivorGame startNewGame:1];
    XCTAssertEqualObjects(gameTurn.turnDescription, @"We have a winner!", @"N = 1: Should have a winner.");
    XCTAssertEqual(gameTurn.gameOver, YES, @"N = 1: Game should be over.");
    XCTAssertEqual(gameTurn.winningPlayerNumber, 1, @"N = 1: winningPlayerNumber should be #1");
    
    // Test N = 2
    gameTurn = [survivorGame startNewGame:2];
    gameTurn = [survivorGame removePerson];
    XCTAssertEqualObjects(gameTurn.turnDescription, @"We have a winner!", @"N = 2: Should have a winner.");
    XCTAssertEqual(gameTurn.gameOver, YES, @"N = 2: Game should be over.");
    XCTAssertEqual(gameTurn.winningPlayerNumber, 2, @"N = 2: winningPlayerNumber should be #2");
    
    // Test N = 3
    gameTurn = [survivorGame startNewGame:3];
    gameTurn = [survivorGame removePerson];
    XCTAssertEqualObjects(gameTurn.turnDescription, @"Person was removed.", @"N = 3: Should have removed a person.");
    XCTAssertEqual(gameTurn.removedPlayerNumber, 1, @"N = 3: should have removed player 1");
    gameTurn = [survivorGame removePerson];
    XCTAssertEqualObjects(gameTurn.turnDescription, @"We have a winner!", @"N = 3: Should have a winner.");
    XCTAssertEqual(gameTurn.gameOver, YES, @"N = 3: Game should be over.");
    XCTAssertEqual(gameTurn.winningPlayerNumber, 2, @"N = 3: winningPlayerNumber should be #2");
    
    // Test N = 4
    gameTurn = [survivorGame startNewGame:4];
    gameTurn = [survivorGame removePerson];
    gameTurn = [survivorGame removePerson];
    gameTurn = [survivorGame removePerson];
    XCTAssertEqualObjects(gameTurn.turnDescription, @"We have a winner!", @"N = 4: Should have a winner.");
    XCTAssertEqual(gameTurn.gameOver, YES, @"N = 4: Game should be over.");
    XCTAssertEqual(gameTurn.winningPlayerNumber, 4, @"N = 4: winningPlayerNumber should be #4");
    
    // Test N = 5
    gameTurn = [survivorGame startNewGame:5];
    // Keep removing people until the game is over
    while (!gameTurn.gameOver)
    {
       gameTurn = [survivorGame removePerson];
    }
    XCTAssertEqual(gameTurn.winningPlayerNumber, 2, @"N = 5: winningPlayerNumber should be #2");
    
    // Test N = 6
    gameTurn = [survivorGame startNewGame:6];
    // Keep removing people until the game is over
    while (!gameTurn.gameOver)
    {
        gameTurn = [survivorGame removePerson];
    }
    XCTAssertEqual(gameTurn.winningPlayerNumber, 4, @"N = 6: winningPlayerNumber should be #4");
    
    // Test N = 7
    gameTurn = [survivorGame startNewGame:7];
    // Keep removing people until the game is over
    while (!gameTurn.gameOver)
    {
        gameTurn = [survivorGame removePerson];
    }
    XCTAssertEqual(gameTurn.winningPlayerNumber, 6, @"N = 7: winningPlayerNumber should be #6");
    
    // Test N = 8
    gameTurn = [survivorGame startNewGame:8];
    // Keep removing people until the game is over
    while (!gameTurn.gameOver)
    {
        gameTurn = [survivorGame removePerson];
    }
    XCTAssertEqual(gameTurn.winningPlayerNumber, 8, @"N = 8: winningPlayerNumber should be #8");
    
    // Test N = 9
    gameTurn = [survivorGame startNewGame:9];
    // Keep removing people until the game is over
    while (!gameTurn.gameOver)
    {
        gameTurn = [survivorGame removePerson];
    }
    XCTAssertEqual(gameTurn.winningPlayerNumber, 2, @"N = 9: winningPlayerNumber should be #2");
    
    // Test N = 10
    gameTurn = [survivorGame startNewGame:10];
    // Keep removing people until the game is over
    while (!gameTurn.gameOver)
    {
        gameTurn = [survivorGame removePerson];
    }
    XCTAssertEqual(gameTurn.winningPlayerNumber, 4, @"N = 10: winningPlayerNumber should be #4");
}

@end
