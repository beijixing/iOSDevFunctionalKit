//
//  MapTestVC.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/5.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "MapTestVC.h"
#import "MapViewTestVC.h"
#import "GaoDeMapVC.h"
@interface MapTestVC ()

@end

@implementation MapTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    _locationManager = [[CLLocationManager alloc] init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务尚未开启，请设置打开");
        return;
    }
    
#pragma mark --定位功能
    
    //如果用户还没授权，请求授权
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
//        [_locationManager requestWhenInUseAuthorization];//注意使用此方法前在要在info.plist中配置NSLocationWhenInUseUsageDescription
//    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
//        
//        _reversGeoCoder = [[CLGeocoder alloc] init];
//       
//        
//        _locationManager.delegate = self;//设置代理
//        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;//设置定位精度
////        CLLocationDistance distance = 10.0;//定位频率 10米定位一次 ,
////        _locationManager.distanceFilter = distance;不设置的话会实时监测位置更新。
//        [_locationManager startUpdatingLocation];//启动追踪定位；
//        
//    }
    
    
#pragma mark --地理编码
    //同一帧内不能使用同一个CLGeocoder 实例来做地理编码和反地理编码两件事，所以这里定义了两个CLGeocoder实例。
    _geoCoder = [[CLGeocoder alloc] init];

    [self getCoordinateByAddress:@"北京"];
    
//    _reversGeoCoder = [[CLGeocoder alloc] init];
//    [self getAddressByLatitude:39.54 longitude:116.28];
    
}


- (void)getCoordinateByAddress:(NSString *)address {
    //地理编码
    [_geoCoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks firstObject];
        
        CLLocation *location = placeMark.location;//位置
        CLRegion *region = placeMark.region;//区域
        NSDictionary *addressDic = placeMark.addressDictionary;//地址详细信息
        
        //        NSString *name=placemark.name;//地名
        //        NSString *thoroughfare=placemark.thoroughfare;//街道
        //        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
        //        NSString *locality=placemark.locality; // 城市
        //        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
        //        NSString *administrativeArea=placemark.administrativeArea; // 州
        //        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
        //        NSString *postalCode=placemark.postalCode; //邮编
        //        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
        //        NSString *country=placemark.country; //国家
        //        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
        //        NSString *ocean=placemark.ocean; // 海洋
        //        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        
        NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
    }];
}

- (void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    
    //反地理编码
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [_reversGeoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks firstObject];
        NSLog(@"详细信息2%@", placeMark.addressDictionary);
        NSDictionary *addressDic = placeMark.addressDictionary;
//        NSString *street = [addressDic valueForKey:@"Street"];
        NSString *name = [addressDic valueForKey:@"Name"];
        self.currentAddressLb.text = [NSString stringWithFormat:@"名字:%@", name];
    }];
    
}

#pragma mark --CoreLocationDelegate

#pragma mark --跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {

    CLLocation *location = [locations firstObject];
    CLLocationCoordinate2D coordinate = location.coordinate;//位置坐标
    
    NSLog(@"经度：%f,维度：%f，海拔:%f,航向：%f， 行走速度：%f", coordinate.longitude, coordinate.latitude, location.altitude, location.course, location.speed);
    
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];//反地理编码
    [_locationManager stopUpdatingLocation];//使用完定位服务后如果不需要实时监控应该立即关闭定位服务以节省资源
}



- (IBAction)mapButtonClick:(UIButton *)sender {
    
    MapViewTestVC *mapTestView = [[MapViewTestVC alloc] init];
    [self.navigationController pushViewController:mapTestView animated:YES];
}

- (IBAction)gaoDeMapButtonClick:(UIButton *)sender {
    
    GaoDeMapVC *gdMap = [[GaoDeMapVC alloc] init];
    [self.navigationController pushViewController:gdMap animated:YES];
}
@end
