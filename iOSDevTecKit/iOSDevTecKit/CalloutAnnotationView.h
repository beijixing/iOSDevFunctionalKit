//
//  CalloutAnnotationView.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/6.
//  Copyright © 2015年 郑光龙. All rights reserved.
//自定义弹出标注视图

#import <UIKit/UIKit.h>
#import "CalloutAnnotation.h"

@interface CalloutAnnotationView : MKAnnotationView
@property (nonatomic, strong) CalloutAnnotation *annotation;

#pragma mark 从缓存取出标注视图
+(instancetype)calloutViewWithMapView:(MKMapView *)mapView;
@end
