//
//  NSDate+TimeString.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/22.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "NSDate+TimeString.h"

@implementation NSDate (TimeString)
+(NSString *)getCurrentTime
{
    NSString *currentTime;
    @autoreleasepool {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *dateNow = [NSDate date];
        currentTime = [dateFormatter stringFromDate:dateNow];
    }
    return currentTime;
}
@end
