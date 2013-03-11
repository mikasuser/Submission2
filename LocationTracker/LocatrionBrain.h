
#import <CoreLocation/CoreLocation.h>



@protocol LocatrionBrainDelegate
@end
@interface LocatrionBrain : NSObject {
    
//    CLLocationManager *locationManager;
//    CLLocation *currentLocation;
//    NSString *myLatitude;
//    NSString *myLongitude;
//    NSString *myURLString;
//    NSString *mySpeed;
//    
    
    

}

@property (nonatomic, assign) CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocation *currentLocation;
@property (nonatomic, assign) NSString *myLatitude;
@property (nonatomic, assign) NSString *myLongitude;
@property (nonatomic, assign) NSString *mySpeed;
@property (nonatomic, retain) NSString *myURLString;
@property (nonatomic, assign) id  delegate;



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
//- (void)startSignificantChangeUpdates;

@end