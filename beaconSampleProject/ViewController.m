//
//  ViewController.m
//  beaconSampleProject
//
//  Created by Belen on 25/05/15.
//  Copyright (c) 2015 belencruz.com. All rights reserved.
//

#import "ViewController.h"
#import "MyLocationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyLocationManager *myLocationManager = [[MyLocationManager alloc] init];
    [myLocationManager startMonitoringUUID:@"11111111-2222-3333-4444-555555555555"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
