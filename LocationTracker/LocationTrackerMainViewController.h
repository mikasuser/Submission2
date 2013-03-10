//
//  LocationTrackerMainViewController.h
//  LocationTracker
//
//  Created by miwa on 3/10/13.
//  Copyright (c) 2013 mw. All rights reserved.
//

#import "LocationTrackerFlipsideViewController.h"

@interface LocationTrackerMainViewController : UIViewController <LocationTrackerFlipsideViewControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

- (IBAction)showInfo:(id)sender;

@end
