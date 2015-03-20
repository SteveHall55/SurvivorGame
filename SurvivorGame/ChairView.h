//
//  ChairView.h
//  SurvivorGame
//
//  Created by Steve Hall on 3/19/15.
//  Copyright (c) 2015 Steve Hall. All rights reserved.
//
// *******************************************************************
// Shows a view of the chair, inclduing the chair image, the badge
// image, and the chair number in the badge
// *******************************************************************

#import <UIKit/UIKit.h>

@interface ChairView : UIView

- (void)updateChairViewWithNumber:(int)chairNumber
               withPerson:(BOOL)isPerson
          usingSizeFactor:(CGFloat)sizeFactor;

@end
