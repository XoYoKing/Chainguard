
//
//  RWSLocationManager.m
//  Manifest
//
//  Created by Samuel Goodwin on 01-02-14.
//
//

#import "RWSLocationManager.h"

NSString *const RWSAutoLocationEnabled = @"RWSAutoLocationEnabled";

@interface RWSLocationManager()
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) CLPlacemark *placemark;
@end

@implementation RWSLocationManager

- (void)updateLocation
{
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.activityType = CLActivityTypeOther;
    manager.desiredAccuracy = 500.0;
    
    manager.delegate = self;
    self.manager = manager;

    [manager requestWhenInUseAuthorization];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways){
        [manager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        id<RWSLocationManagerDelegate> delegate = self.delegate;
        if(!placemarks){
            self.placemark = nil;
            [delegate locationManagerDidFailToDetermineLocation:self];
        }else{
            self.placemark = [placemarks firstObject];
            [delegate locationManagerDidDetermineLocation:self];
        }
    }];

    self.geocoder = geocoder;
}

- (BOOL)canGetLocations
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    return status != kCLAuthorizationStatusDenied && status != kCLAuthorizationStatusRestricted;
}

+ (BOOL)isAutoLocationEnabled
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:RWSAutoLocationEnabled];
}

- (void)enableAutoUpdates
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:RWSAutoLocationEnabled];
}

@end
