//
//  NSString+MD5.h
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/22.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)
- (NSString *)md5String;
+ (NSString *)formatNumberWithComma:(NSString *)number;

//日期相减获得天数
+ (NSString *)getDateStringWithDate:(NSString *)date dateFormat:(NSString *)format destFormat:(NSString *)destFormat;

+ (NSString*)getDaysBetweenEndDate:(NSString* )endDate andStartDate:(NSString *)startDate withDateFormat:(NSString *)format;

//字符串处理
+ (void)splitString:(NSString *)targetStr withCharacter:(NSString *)divideStr andSubstrArr:(NSMutableArray *)subStrArr;
@end
