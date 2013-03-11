//
//  LocationTracker.h
//  LocationTracker
//
//  Created by miwa on 3/11/13.
//  Copyright (c) 2013 mw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface LocationTracker : NSObject


-(void) DistanceDelta;
-(void) enableTracker;
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

-(NSString*) myLatitude;
-(void) reportPosition;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic) int DistanceDelta;







@end
