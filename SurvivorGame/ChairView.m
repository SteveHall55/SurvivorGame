//
//  ChairView.m
//  SurvivorGame
//
//  Created by Steve Hall on 3/19/15.
//  Copyright (c) 2015 Steve Hall. All rights reserved.
//

#import "ChairView.h"

@interface ChairView()

@property (strong, nonatomic) UIImageView *chairImageView;
@property (strong, nonatomic) UIImageView *badgeImageView;
@property (strong, nonatomic) UILabel *badgeLabel;

@end

@implementation ChairView

// Update the chair view
- (void)updateChairViewWithNumber:(int)chairNumber
                         withPerson:(BOOL)isPerson
                    usingSizeFactor:(CGFloat)sizeFactor;
{
    // Create the subviews to add to the ChairView
    self.chairImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * sizeFactor, 10 * sizeFactor, 50 * sizeFactor, 50 * sizeFactor)];
    NSString *chairImageName = @"chair1";
    if (isPerson)
    {
        // For fun, let's mix it up with 2 person images, selected randomly
        int randomInt = arc4random() % 2 + 2;
        chairImageName = [NSString stringWithFormat:@"chair%i", randomInt];
    }
    self.chairImageView.image = [UIImage imageNamed:chairImageName];
    
    // Badge view
    self.badgeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25 * sizeFactor, 25 * sizeFactor)];
    self.badgeImageView.image = [UIImage imageNamed:@"infoBadge"];
    
    // Badge label
    self.badgeLabel =[[UILabel alloc] initWithFrame:CGRectMake(8 * sizeFactor, 3 * sizeFactor, 16 * sizeFactor, 16 * sizeFactor)];
    self.badgeLabel.text = [NSString stringWithFormat:@"%i", chairNumber];
    self.badgeLabel.textColor = [UIColor whiteColor];
    int fontSize = 14 * sizeFactor;
    if (chairNumber > 9)
    {
        fontSize = 10 * sizeFactor;
    }
    self.badgeLabel.font = [UIFont systemFontOfSize:fontSize];
    
    // Add all the subviews
    [self addSubview:self.chairImageView];
    [self addSubview:self.badgeImageView];
    [self addSubview:self.badgeLabel];
}

@end
