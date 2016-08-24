//
//  DateFormatterManager.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/22.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "DateFormatterManager.h"

@interface DateFormatterManager ()
{
    NSDateFormatter *_dateFormater;
}
@end

@implementation DateFormatterManager

+ (instancetype)sharedManager {
    static DateFormatterManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DateFormatterManager alloc] init];
    });
    return manager;
}

- (NSDateFormatter*)getDateFormater {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormater = [[NSDateFormatter alloc] init];
        _dateFormater.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        
    });
    return _dateFormater;
}

@end
