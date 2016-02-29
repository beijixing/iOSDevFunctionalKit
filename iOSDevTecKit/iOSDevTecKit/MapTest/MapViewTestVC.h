//
//  MapViewTestVC.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/5.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "CoreLocation/CoreLocation.h"
#import "ZAnnotation.h"

@interface MapViewTestVC : BaseViewController<MKMapViewDelegate>
{
    MKMapView *_mapView;//地图；
    CLLocationManager *_locationManager;//定位功能
    CLGeocoder *_reverseGeoCoder;
}
@end
