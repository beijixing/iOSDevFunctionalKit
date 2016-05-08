//
//  MapViewTestVC.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/5.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "MapViewTestVC.h"
#import "CalloutAnnotation.h"
#import "CalloutAnnotationView.h"

@interface MapViewTestVC ()
{
    MKAnnotationView *selectedAnnotationView;
    CalloutAnnotation *selectedCalloutAnnotation;
}
@end

@implementation MapViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _reverseGeoCoder = [[CLGeocoder alloc] init];
    [self initGui];
    
//    [self addAnnotation];
}

#pragma mark --添加地图控件
/*
 1.由于在地图中进行用户位置跟踪需要使用定位功能，而定位功能在iOS8中设计发生了变化，因此必须按照前面定位章节中提到的内容进行配置和请求。
 
 2.iOS8中不需要进行中心点的指定，默认会将当前位置设置中心点并自动设置显示区域范围。
 
 了解以上两点，要进行用户位置跟踪其实就相当简单了，值得一提的是-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation这个代理方法。这个方法只有在定位（利用前面章节中的定位内容）到当前位置之后就会调用，以后每当用户位置发生改变就会触发，调用频率相当频繁。
 */

- (void) initGui {
    CGRect rect = [UIScreen mainScreen].bounds;
    _mapView  = [[MKMapView alloc] initWithFrame:rect];
    [self.view addSubview:_mapView];
    
    //设置代理
    _mapView.delegate = self;
    
    _locationManager = [[CLLocationManager alloc] init];
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    _mapView.showsUserLocation = NO;
    //用户位置追踪（用户位置追踪用于标记用户当前位置，此时会调用定位服务）
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //设置地图类型
    _mapView.mapType = MKMapTypeStandard;
//    [_mapView removeOverlays:_mapView.overlays];
//    [_mapView removeAnnotations:_mapView.annotations];
    //添加大头针
}


#pragma mark 添加大头针
- (void) addAnnotationWithUserLocation:(MKUserLocation *)userLocation {
    [_reverseGeoCoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        NSDictionary *addressDic = placemark.addressDictionary;

        ZAnnotation *annotation = [[ZAnnotation alloc] init];
        NSString *addressStr = [NSString stringWithFormat:@"%@%@%@%@", [addressDic valueForKey:@"Country"], [addressDic valueForKey:@"State"], [addressDic valueForKey:@"SubLocality"], [addressDic valueForKey:@"Street"]];
        annotation.title = addressStr;
//        annotation.subtitle = [addressDic valueForKey:@"Street"];
        annotation.coordinate = userLocation.location.coordinate;
        annotation.image = [UIImage imageNamed:@"anjuke_icon_itis_position"];
        
        [_mapView removeAnnotations:_mapView.annotations];//添加新的Annotation 之前移除掉先前添加的
        [_mapView addAnnotation:annotation];
    }];
}


#pragma mark --地图控件代理
#pragma mark 更新用户位置，只要用户改变则调用此方法（包括第一次定位到用户位置）
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation {
    
    [self addAnnotationWithUserLocation:userLocation];
    
    //设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
//    MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
//    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
//    [_mapView setRegion:region animated:true];

    
    NSLog(@"%@", userLocation);
    NSLog(@"title = %@, subtitle = %@", userLocation.title, userLocation.subtitle);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[ZAnnotation class]]) {
        static NSString *annotationName = @"annotation";
        
        //如果缓存池中不存在则新建
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationName];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationName];
            annotationView.canShowCallout = true;//允许交互点击
            annotationView.calloutOffset = CGPointMake(0, -10);//定义详情视图偏移量
            annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_menu_i4_active"]];//定义详情左侧视图
        }
        
         NSLog(@"4");
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation = annotation;
        annotationView.image = ((ZAnnotation *)annotation).image;
        return annotationView;
//    }else if ([annotation isKindOfClass:[CalloutAnnotation class]]){
//            //对于作为弹出详情视图的自定义大头针视图无弹出交互功能（canShowCallout=false，这是默认值），在其中可以自由添加其他视图（因为它本身继承于UIView）
//        CalloutAnnotationView *calloutView=[CalloutAnnotationView calloutViewWithMapView:mapView];
//        calloutView.annotation = annotation;
//         NSLog(@"3");
//        return calloutView;
    }else {
         NSLog(@"5");
        return nil;
    }
}



#pragma mark 选中大头针时触发
//点击一般的大头针KCAnnotation时添加一个大头针作为所点大头针的弹出详情视图
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    ZAnnotation *annotation = view.annotation;
    selectedAnnotationView = view;
    if ([annotation isKindOfClass:[ZAnnotation class]]) {
        //点击一个大头针时移除其他弹出详情视图
//        [self removeCustomAnnotation];
        //添加详情大头针，渲染此大头针视图时将此模型对象赋值给自定义大头针视图完成自动布局
//        CalloutAnnotation *calloutAnnotation=[[CalloutAnnotation alloc]init];
//        calloutAnnotation.image = annotation.image;
//        calloutAnnotation.icon=annotation.icon;
//        calloutAnnotation.detail=annotation.detail;
//        calloutAnnotation.rate=annotation.rate;
//        calloutAnnotation.coordinate=view.annotation.coordinate;
//        selectedCalloutAnnotation = calloutAnnotation;
//        selectedAnnotationView.hidden = YES;
//        [mapView addAnnotation:calloutAnnotation];
         NSLog(@"2");
    }
}

#pragma mark 取消选中时触发
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
//    [self removeCustomAnnotation];
//    if (selectedCalloutAnnotation) {
//        [mapView removeAnnotation:selectedCalloutAnnotation];
//        selectedCalloutAnnotation = nil;
//    }
//    
//    selectedAnnotationView.hidden = NO;
    NSLog(@"1");
}

#pragma mark 移除所用自定义大头针
//-(void)removeCustomAnnotation{
//    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ([obj isKindOfClass:[CalloutAnnotation class]]) {
//            [_mapView removeAnnotation:obj];
//        }
//    }];
//}


//添加测试大头针
-(void)addAnnotation{
    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(39.95, 116.35);
    ZAnnotation *annotation1=[[ZAnnotation alloc]init];
    annotation1.title=@"CMJ Studio";
    annotation1.subtitle=@"Kenshin Cui's Studios";
    annotation1.coordinate=location1;
    annotation1.image=[UIImage imageNamed:@"anjuke_icon_itis_position"];
    annotation1.icon=[UIImage imageNamed:@"anjuke_icon_itis_position"];
    annotation1.detail=@"CMJ Studio...";
    annotation1.rate=[UIImage imageNamed:@"bottom_menu_i2_active"];
    [_mapView addAnnotation:annotation1];
    
    CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(39.87, 116.35);
    ZAnnotation *annotation2=[[ZAnnotation alloc]init];
    annotation2.title=@"Kenshin&Kaoru";
    annotation2.subtitle=@"Kenshin Cui's Home";
    annotation2.coordinate=location2;
    annotation2.image=[UIImage imageNamed:@"address_add_location"];
    annotation2.icon=[UIImage imageNamed:@"anjuke_icon_itis_position"];
    annotation2.detail=@"Kenshin Cui...";
    annotation2.rate=[UIImage imageNamed:@"bottom_menu_i2_active"];
    [_mapView addAnnotation:annotation2];
}
@end
