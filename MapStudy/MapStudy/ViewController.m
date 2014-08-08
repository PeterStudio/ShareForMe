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
#import "AFHTTPRequestOperationManager.h"


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
    [self.mapView sizeToFit];
    [self.mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:self.mapView];
    
    
//    MAUserLocation *userLocation = [self.mapView userLocation];
    
//    [self.mapView setCenterCoordinate:userLocation.coordinate];
    
    

//    DrawerView *drawer = [[DrawerView alloc] initWithParentView:self.view];
//    [self.view addSubview:drawer];
    
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//如果报接受类型不一致请替换一致text/html或别的
////    manager.requestSerializer=[AFJSONRequestSerializer serializer];//申明请求的数据是json类型
//    NSDictionary *parameters = @{@"username": @"pet",@"password":@"123456",@"passwordf":@"123456",@"mobile":@"13004348920",@"yzm1":@"1234",@"yzm2":@"1234"};
//    NSLog(@"%@",parameters);
//    [manager POST:@"http://chere.sinaapp.com/aod_login/register" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", [responseObject objectForKey:@"message"]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    

}



- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    NSLog(@"location:%f",userLocation.coordinate.latitude);
    [self.mapView setCenterCoordinate:userLocation.coordinate];
    userLocation.title = @"这是我的位置";
    
}


- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
}


#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        // 当前用户定位展示
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        annotationView.pinColor                     = [self.annotations indexOfObject:annotation];
        
        return annotationView;
    }
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
//        static NSString *customReuseIndetifier = @"customReuseIndetifier";
//        
//        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
//        
//        if (annotationView == nil)
//        {
//            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
//            // must set to NO, so we can show the custom callout view.
//            annotationView.canShowCallout = NO;
//            annotationView.draggable = YES;
//            annotationView.calloutOffset = CGPointMake(0, -5);
//        }
//        
//        annotationView.portrait = [UIImage imageNamed:@"hema.png"];
//        annotationView.name     = @"河马";
//        
//        return annotationView;
    }

    return nil;
}

#pragma mark - Action Handle

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    NSLog(@"view:%@",view);
    /* Adjust the map center in order to show the callout view completely. */
//    if ([view isKindOfClass:[CustomAnnotationView class]]) {
//        CustomAnnotationView *cusView = (CustomAnnotationView *)view;
//        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:self.mapView];
//        
//        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin));
//        
//        if (!CGRectContainsRect(self.mapView.frame, frame))
//        {
//            /* Calculate the offset to make the callout view show up. */
//            CGSize offset = [self offsetToContainRect:frame inRect:self.mapView.frame];
//            
//            CGPoint theCenter = self.mapView.center;
//            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
//            
//            CLLocationCoordinate2D coordinate = [self.mapView convertPoint:theCenter toCoordinateFromView:self.mapView];
//            
//            [self.mapView setCenterCoordinate:coordinate animated:YES];
//        }
//        
//    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
