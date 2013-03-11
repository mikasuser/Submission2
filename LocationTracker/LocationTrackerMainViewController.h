//
//  LocationTrackerMainViewController.h
//  LocationTracker
//
//  Created by miwa on 3/10/13.
//  Copyright (c) 2013 mw. All rights reserved.
//

#import "LocationTrackerFlipsideViewController.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationTrackerMainViewController : UIViewController <LocationTrackerFlipsideViewControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@property (strong, nonatomic) IBOutlet UILabel *UILatitude;
@property (strong, nonatomic) IBOutlet UILabel *UILongitude;
@property (strong, nonatomic) IBOutlet UILabel *UISpeed;
@property (strong, nonatomic) IBOutlet UILabel *UITime;
@property (strong, nonatomic) IBOutlet UILabel *UILaboutput;



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;


@property (copy, nonatomic) NSString *username;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *currentLocation;


- (IBAction)showInfo:(id)sender;

@end
