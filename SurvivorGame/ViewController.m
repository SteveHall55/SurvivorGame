//
//  ViewController.m
//  SurvivorGame
//
//  Created by Steve Hall on 3/19/15.
//  Copyright (c) 2015 Steve Hall. All rights reserved.
//

#import "ViewController.h"
#import "SurvivorGame.h"
#import "GameTurn.h"
#import "ChairView.h"

@interface ViewController ()

@property (strong, nonatomic) SurvivorGame *survivorGame;

@property (weak, nonatomic) IBOutlet UITextField *numberOfChairsTextField;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *turnDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) CGFloat sizeFactor;

@end

@implementation ViewController

// Lazily instantiate the survivor game
- (SurvivorGame *)survivorGame
{
    if (!_survivorGame)
    {
        _survivorGame = [[SurvivorGame alloc] init];
    }
    
    return _survivorGame;
}

// viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Make the "Play" button pretty
    [self.playButton setBackgroundColor:[UIColor whiteColor]];
    [self.playButton.layer setCornerRadius:10];
    [self.playButton.layer setBorderWidth:1.0f];
    [self.playButton.layer setBorderColor:[[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] CGColor]];
    
    // Set the delegate for numberOfChairsTextField
    [self.numberOfChairsTextField setDelegate:self];
}

// didReceiveMemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// User clicked the "Play" button
- (IBAction)playButtonClicked:(id)sender
{
    // Start of a new game, so do some initializitions
    if (self.timer)
    {
        // Invalidate the timer
        [self.timer invalidate];
        self.timer = nil;
    }
    // Remove all the chair views from the last game
    for (id chairView in [self.view subviews])
    {
        if ([chairView isMemberOfClass:[ChairView class]])
        {
            [chairView removeFromSuperview];
        }
    }
    // Clear out the onscreen text
    self.turnDescriptionLabel.text = @"";
    self.infoTextView.text = @"";
    
    NSString *errorMessage = @"";
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    int numberOfChairs = [(NSNumber *)[numberFormatter numberFromString:self.numberOfChairsTextField.text] intValue];
    
    if (numberOfChairs)
    {
        GameTurn *gameTurn = [self.survivorGame startNewGame:numberOfChairs];
        if (gameTurn.gameOver && (gameTurn.winningPlayerNumber == 0))
        {
            // When the game is over and the winning player's number is 0, this means the game was able to start properly
            errorMessage = gameTurn.turnDescription;
        }
        else
        {
            if (numberOfChairs > 50)
            {
                // Too many chairs to animate, so just play the game and display the winner
                while (!gameTurn.gameOver)
                {
                    gameTurn = [self.survivorGame removePerson];
                }
                
                // Too many chairs to animate, so just diplay the winner
                self.turnDescriptionLabel.text = [NSString stringWithFormat:@"The winner is person at Chair #%i.", gameTurn.winningPlayerNumber];
                self.infoTextView.text = @"Am I crazy or is that a lot of chairs?  Too many for the animation I'm afraid.";
            }
            else
            {
                // Determine what size factor to use
                self.sizeFactor = 1.0;
                if (numberOfChairs > 20)
                {
                    self.sizeFactor = 0.5;   // Use a smaller chair view
                }
                
                // Draw the people to start the game
                CGPoint centerPoint = {self.view.bounds.size.width / 2 - 25, self.view.bounds.size.height / 2};
                int radius = (self.view.bounds.size.width / 2) - 50;
                [self drawCircleOfChairsWithPoints:numberOfChairs radius:radius center:centerPoint];
                
                // If the game is over (i.e. 1 chair game), we are done
                if (gameTurn.gameOver)
                {
                    // Display to the user the winner of the game
                    self.turnDescriptionLabel.text = [NSString stringWithFormat:@"The winner is person at Chair #%i.", gameTurn.winningPlayerNumber];
                }
                else
                {
                    // Keep removing people until the game is over
                    NSTimeInterval timeInterval = 1.0;
                    if (numberOfChairs > 20)
                    {
                        timeInterval = 0.25;  // Speed things up if we have more than 20 chairs
                    }
                    else if (timeInterval > 9)
                    {
                        timeInterval = 0.50;
                    }
                    
                    // Schedule the timer
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(removePersonFromChair:) userInfo:nil repeats:YES];
                }
            }
        }
    }
    else
    {
        errorMessage = @"Number of chairs is not valid.";
    }
    
    // We had an error, so display the alertView
    if (![errorMessage isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

// Remove a person from the chair
- (void)removePersonFromChair:(NSTimer *)timer
{
    // Remove the person
    GameTurn *gameTurn = [self.survivorGame removePerson];
    
    // Change the image to be an empty chair
    ChairView *currentChairView = (ChairView *)[self.view viewWithTag:gameTurn.removedPlayerNumber];
    [currentChairView updateChairViewWithNumber:gameTurn.removedPlayerNumber withPerson:NO usingSizeFactor:self.sizeFactor];
    
    // See if the game is over
    if (gameTurn.gameOver)
    {
        // Game is over; we can stop animating and kill the timer
        [self.timer invalidate];
        self.timer = nil;
        
        // Display to the user the winner of the game
        self.turnDescriptionLabel.text = [NSString stringWithFormat:@"The winner is person at Chair #%i.", gameTurn.winningPlayerNumber];
    }
}

// Draws the circle of chairs
- (void)drawCircleOfChairsWithPoints:(int)points radius:(int)radius center:(CGPoint)center
{
    CGFloat slice = 2 * M_PI / points;
    
    // Loop through the number of points and draw the chair at each point
    for (int i = 0; i < points; i++)
    {
        CGFloat angle = slice * i;
        int newX = (int)(center.x + radius * cos(angle));
        int newY = (int)(center.y + radius * sin(angle));

        // Add the chair view to the view
        ChairView *chairView = [[ChairView alloc] initWithFrame:CGRectMake(newX, newY, 50 * self.sizeFactor, 50 * self.sizeFactor)];
        chairView.tag = (i + 1);
        [chairView updateChairViewWithNumber:(i+1) withPerson:YES usingSizeFactor:self.sizeFactor];
        [self.view addSubview:chairView];
    }
}

#pragma mark UITextFieldDelegate

// Limit the length of the text field to 5 characters
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((textField.text.length >= 5) && (range.length == 0))
    {
        return NO; // Don't allow any more text
    }
    else
    {
        return YES; // Allow more text
    }
}

@end
