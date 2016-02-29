//
//  StaticAnnotationTest.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/6.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "StaticAnnotationTest.h"

@interface StaticAnnotationTest ()

@end

@implementation StaticAnnotationTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc] init];
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    _geoCoder = [[CLGeocoder alloc] init];
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    
}

//用户位置有变化时的回调，在没有设置移动距离时，会频繁调用
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation {
    
}

//加载地图结束时的回调方法
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated  {

    CGPoint addressImagePos = CGPointMake(MainScreenWidth/2, (MainScreenWidth-64)/2);
//
    CLLocationCoordinate2D coordinate = [mapView convertPoint:addressImagePos toCoordinateFromView:mapView];
    /*
         下面的三行代码是获取屏幕中间的位置对应的地图坐标与直上面接取屏幕中间的控件的坐标获得效果一样。
         MKCoordinateRegion region;
         CLLocationCoordinate2D coordinate = mapView.region.center;
         region.center= centerCoordinate;
     */

    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [_geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        NSString *name = placemark.name;
        NSString *addressStr = [NSString stringWithFormat:@"%@",
                                ([name isEqualToString:@"<null>"] || name == nil) ? @"" : name
                                ];
        _addressLabel.text = addressStr;

    }];
    
    NSLog(@"latitude = %f, longitude = %f", coordinate.latitude, coordinate.longitude);
    
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    if (annotation == mapView.userLocation) return nil;
//    return [[MKAnnotationView alloc] init];
//}

@end
