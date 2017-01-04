//
//  UIImageExt.h
//  DoctorClient
//
//  Created by d630 on 14-3-14.
//  Copyright (c) 2014年 dell_630. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (UIImageExt)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
