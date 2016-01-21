//
//  ZAnnotation.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/5.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"
@interface ZAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

@property (nonatomic,strong, nullable) UIImage *image;//自定义一个图片属性在创建大头针时使用


#pragma mark 大头针详情左侧图标
@property (nonatomic,strong, nullable) UIImage *icon;
#pragma mark 大头针详情描述
@property (nonatomic,copy, nullable) NSString *detail;
#pragma mark 大头针右下方星级评价
@property (nonatomic,strong, nullable) UIImage *rate;

@end
