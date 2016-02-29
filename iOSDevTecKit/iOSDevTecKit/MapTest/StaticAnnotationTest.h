//
//  StaticAnnotationTest.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/6.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "CoreLocation/CoreLocation.h"
@interface StaticAnnotationTest : BaseViewController<MKMapViewDelegate>
{

    __weak IBOutlet MKMapView *_mapView;
    __weak IBOutlet UIImageView *_addressImageView;
    __weak IBOutlet UILabel *_addressLabel;
    CLGeocoder *_geoCoder;
    CLLocationManager *_locationManager;
}
@end
