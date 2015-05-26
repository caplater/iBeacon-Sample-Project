//
//  MyLocationManager.h
//  beaconSampleProject
//
//  Created by Belen on 25/05/15.
//  Copyright (c) 2015 belencruz.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyLocationManager : NSObject <CLLocationManagerDelegate>

/**
 * Start monitoring the indicated UUID region.
 *
 * @param uuid UUID to start monitoring
 */
- (void)startMonitoringUUID:(NSString *)uuid;


/**
 * Stop the Location Manager from monitor beacons.
 */
- (void)stop;

@end
