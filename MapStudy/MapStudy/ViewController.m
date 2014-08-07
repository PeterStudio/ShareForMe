//
//  ViewController.m
//  MapStudy
//
//  Created by dw on 14-8-5.
//  Copyright (c) 2014年 dw. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "DrawerView.h"

@interface ViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@end

@implementation ViewController
@synthesize mapView = _mapView;

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    [self.view setBackgroundColor:[UIColor purpleColor]];
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.distanceFilter = 0.1;
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.delegate = self;
    self.mapView.userInteractionEnabled = YES;
    [self.mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:self.mapView];
    
    
//    MAUserLocation *userLocation = [self.mapView userLocation];
    
//    [self.mapView setCenterCoordinate:userLocation.coordinate];
    
    

    DrawerView *drawer = [[DrawerView alloc] initWithParentView:self.view];
    [self.view addSubview:drawer];
}



- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    NSLog(@"location:%f",userLocation.coordinate.latitude);
    [self.mapView setCenterCoordinate:userLocation.coordinate];
    userLocation.title = @"这是我的位置";
}


- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
