//
//  MyLocationManager.m
//  beaconSampleProject
//
//  Created by Belen on 25/05/15.
//  Copyright (c) 2015 belencruz.com. All rights reserved.
//

#import "MyLocationManager.h"


@interface MyLocationManager ()
@property (strong,nonatomic) CLLocationManager *locationManager;
@end

@implementation MyLocationManager


/**
 * Start monitoring the indicated UUID region.
 *
 * @param uuid UUID to start monitoring
 */
- (void)startMonitoringUUID:(NSString *)uuid
{
    if(! self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    // Request permission (mandatory iOS8 + info.plist)
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        [self.locationManager requestAlwaysAuthorization];
    
    if(uuid) {
        CLBeaconRegion *region = [[CLBeaconRegion alloc]
                                  initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:uuid]
                                  identifier: uuid];
        
        region.notifyEntryStateOnDisplay = YES;
        [self.locationManager startMonitoringForRegion:region];
        [self.locationManager requestStateForRegion:region];
    }
}


/**
 * Stop the Location Manager from monitor beacons.
 */
- (void)stop
{
    if (self.locationManager) {
        for(id region in self.locationManager.monitoredRegions) {
            [self.locationManager stopMonitoringForRegion:region];
            
            if ([region isKindOfClass:[CLBeaconRegion class]]) {
                [self.locationManager stopRangingBeaconsInRegion:region];
            }
        }
    }
}





#pragma mark Location Manager Delegate Methods


/**
 * Delegate method called when the user enters or exits a region.
 */
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    switch (state) {
        case CLRegionStateInside: // INSIDE: start ranging
            NSLog(@"locationManager didDetermineState INSIDE for %@", region.identifier);
            [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
            break;
            
        case CLRegionStateOutside: // OUTSIDE: stop ranging
            NSLog(@"locationManager didDetermineState OUTSIDE for %@", region.identifier);
            [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
            break;
            
        default:
            NSLog(@"locationManager didDetermineState OTHER for %@", region.identifier);
            break;
    }
}

/**
 * Delegate method called when beacon information is received.
 */
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if(beacons != nil && (0 < beacons.count)) {
        for(CLBeacon *b in beacons) {
            NSLog(@"%@/%@ %ld", b.major, b.minor, b.proximity);
        }
    }
}


@end

