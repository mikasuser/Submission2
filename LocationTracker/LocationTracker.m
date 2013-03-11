//
//  LocationTracker.m
//  LocationTracker
//
//  Created by miwa on 3/11/13.
//  Copyright (c) 2013 mw. All rights reserved.
//

#import "LocationTracker.h"
@implementation LocationTracker

@synthesize locationManager, currentLocation, distanceDeltaValue;



-(void)enableTracker{
    NSLog(@"HelloTracker");
}

-(NSString*)myLatitude{
        NSLog(@"Hello Tracker");
    return @"ein DReck!!!";
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.currentLocation = newLocation;
    self.UILatitude.text= [NSString stringWithFormat:@"%f\"", self.currentLocation.coordinate.latitude];
    self.UILongitude.text= [NSString stringWithFormat:@"%f\"", self.currentLocation.coordinate.longitude];
    
    
    self.UISpeed.text= [NSString stringWithFormat:@"%f\"", self.currentLocation.speed];
    self.UITime.text= [NSString stringWithFormat:@"%@\"", self.currentLocation.timestamp];
    LocationTracker *myTracker = [[LocationTracker alloc]init];
    
    self.UILaboutput.text=myTracker.myLatitude;
    
    
    
    
    
    
    //   NSLog(@"MY_LOG %@", self.currentLocation);
    //if(newLocation.horizontalAccuracy <= 100.0f) { [locationManager stopUpdatingLocation]; }
    
    
    
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




@end
