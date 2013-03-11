//
//  LocationTrackerFlipsideViewController.h
//  LocationTracker
//
//  Created by miwa on 3/10/13.
//  Copyright (c) 2013 mw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationTrackerFlipsideViewController;

@protocol LocationTrackerFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(LocationTrackerFlipsideViewController *)controller;
@end

@interface LocationTrackerFlipsideViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *UIDistance;
- (IBAction)UIDistSlider:(UISlider *)sender;

@property (weak, nonatomic) id <LocationTrackerFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
