//
//  MapTestVC.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/5.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"

@interface MapTestVC : BaseViewController<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;//定位功能;
    CLGeocoder *_geoCoder;//处理地理编码（反地理编码）
    CLGeocoder *_reversGeoCoder;//反地理编码；
    
}
@property (weak, nonatomic) IBOutlet UILabel *currentAddressLb;
- (IBAction)mapButtonClick:(UIButton *)sender;
- (IBAction)gaoDeMapButtonClick:(UIButton *)sender;
@end
