//
//  LocationTrackerMainViewController.m
//  LocationTracker
//
//  Created by miwa on 3/10/13.
//  Copyright (c) 2013 mw. All rights reserved.
//

#import "LocationTrackerMainViewController.h"
#import "LocationTracker.h"
@interface LocationTrackerMainViewController ()

@end

@implementation LocationTrackerMainViewController
@synthesize locationManager, currentLocation;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = (id)self;
    locationManager.distanceFilter = 5;
    [locationManager startUpdatingLocation];
    [locationManager startMonitoringSignificantLocationChanges];
     
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application{
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = (id)self;
    locationManager.distanceFilter = 5;
    [locationManager startUpdatingLocation];
    [locationManager startMonitoringSignificantLocationChanges];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.currentLocation = newLocation;
    self.UILatitude.text= [NSString stringWithFormat:@"%f\"", self.currentLocation.coordinate.latitude];
    self.UILongitude.text= [NSString stringWithFormat:@"%f\"", self.currentLocation.coordinate.longitude];

    
        self.UISpeed.text= [NSString stringWithFormat:@"%f\"", self.currentLocation.speed];
        self.UITime.text= [NSString stringWithFormat:@"%@\"", self.currentLocation.timestamp];

    
    NSOperationQueue *mainQueue = [[NSOperationQueue alloc] init];
    [mainQueue setMaxConcurrentOperationCount:1];
    NSString *infourl=@"http://192.168.1.119:8000/loc.html?";
    infourl=[infourl stringByAppendingString:[NSString stringWithFormat:@"%f?%f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude]];
    
    
    NSURL *url = [NSURL URLWithString:infourl];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:@{@"Accepts-Encoding": @"gzip", @"Accept": @"application/json"}];
    [request setTimeoutInterval:1];
    
    [NSURLConnection sendAsynchronousRequest:request queue:mainQueue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
        if (!error) {
            NSLog(@"Status Code: %li %@", (long)urlResponse.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:urlResponse.statusCode]);
            NSLog(@"Response Body: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        }
        else {
            NSLog(@"An error occured, Status Code: %i", urlResponse.statusCode);
            NSLog(@"Description: %@", [error localizedDescription]);
            NSLog(@"Response Body: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        }
    }];
    
    
    
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if(error.code == kCLErrorDenied) {
        [locationManager stopUpdatingLocation];
    } else if(error.code == kCLErrorLocationUnknown) {
        // retry
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error retrieving location"
                                                        message:[error description]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}
    
    
#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(LocationTrackerFlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (IBAction)showInfo:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        LocationTrackerFlipsideViewController *controller = [[LocationTrackerFlipsideViewController alloc] initWithNibName:@"LocationTrackerFlipsideViewController" bundle:nil];
        controller.delegate = self;
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        if (!self.flipsidePopoverController) {
            LocationTrackerFlipsideViewController *controller = [[LocationTrackerFlipsideViewController alloc] initWithNibName:@"LocationTrackerFlipsideViewController" bundle:nil];
            controller.delegate = self;
            
            self.flipsidePopoverController = [[UIPopoverController alloc] initWithContentViewController:controller];
        }
        if ([self.flipsidePopoverController isPopoverVisible]) {
            [self.flipsidePopoverController dismissPopoverAnimated:YES];
        } else {
            [self.flipsidePopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
}

@end
