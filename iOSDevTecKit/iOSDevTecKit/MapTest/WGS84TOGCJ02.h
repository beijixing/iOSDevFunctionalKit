//
//  WGS84TOGCJ02.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 16/4/1.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGS84TOGCJ02 : NSObject
//判断是否已经超出中国范围
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;
//转GCJ-02
+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;
@end
