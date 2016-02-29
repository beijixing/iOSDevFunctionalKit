//
//  GaoDeMapVC.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/7.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "GaoDeMapVC.h"
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "APIKey.h"
@interface GaoDeMapVC ()<MAMapViewDelegate>
{
//    MAMapView *_maMapView;
    CLGeocoder *_geoCoder;
  
    __weak IBOutlet MAMapView *_maMapView;
}
@property(nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation GaoDeMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"高德地图";
    
//    _maMapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:_maMapView];

    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    
    _geoCoder = [[CLGeocoder alloc] init];
    _maMapView.userTrackingMode = MAUserTrackingModeFollow;
    _maMapView.mapType = MAMapTypeStandard;
    _maMapView.showsUserLocation = YES;
    _maMapView.delegate = self;
    
    [_maMapView setZoomLevel:15.0 animated:YES];
    
    NSLog(@"%@", [MAMapServices sharedServices].apiKey);
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
}


-(void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    CLLocationCoordinate2D centerCoord = mapView.region.center;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:centerCoord.latitude longitude:centerCoord.longitude];
    
    [_geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *currPlaceMark = [placemarks firstObject];
        NSString *name = currPlaceMark.name;
        NSString *addressName = [NSString stringWithFormat:@"%@", (name == nil || [name isEqualToString:@"<null>"] )? @"" : name ];
        if (![addressName isEqualToString:@""]) {
            self.currentLocation.text = addressName;
        }
        }];
}

@end
