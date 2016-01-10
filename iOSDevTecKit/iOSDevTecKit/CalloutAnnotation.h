//
//  CalloutAnnotation.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/6.
//  Copyright © 2015年 郑光龙. All rights reserved.
//  自定义大头针弹出视图数据

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface CalloutAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy,readonly) NSString *title;
@property (nonatomic, copy,readonly) NSString *subtitle;

@property (nonatomic,strong, nullable) UIImage *image;//自定义一个图片属性在创建大头针时使用

#pragma mark 左侧图标
@property (nonatomic,strong) UIImage *icon;
#pragma mark 详情描述
@property (nonatomic,copy) NSString *detail;
#pragma mark 星级评价
@property (nonatomic,strong) UIImage *rate;

@end
