//
//  NSString+MD5.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/22.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "NSString+Util.h"
#import "DateFormatterManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Util)
-(NSString *)md5String
{
    const char *original_str = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, (uint32_t)strlen(original_str), result);
    NSMutableString *md5 = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [md5 appendFormat:@"%02X",result[i]];
    return [md5 lowercaseString];
}

+ (NSString *)formatNumberWithComma:(NSString *)number {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    numberFormatter.locale = [NSLocale currentLocale];// this ensure the right separator behavior
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.usesGroupingSeparator = YES;
    NSNumber *numberFromString = [numberFormatter  numberFromString:number];
    NSString *desStr = [numberFormatter stringForObjectValue:numberFromString];
    return desStr;
}

+(NSString *)getDateStringWithDate:(NSString *)date dateFormat:(NSString *)format destFormat:(NSString *)destFormat {
    NSDateFormatter *dateFormater = [[DateFormatterManager sharedManager] getDateFormater];
    dateFormater.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    [dateFormater setDateFormat:format];
    NSDate *dateNew = [dateFormater dateFromString:date];
    //    DLog(@"dateNew = %@", dateNew);
    [dateFormater setDateFormat:destFormat];
    NSString*destDateString = [dateFormater stringFromDate:dateNew];
    //    DLog(@"rdate = %@" ,destDateString);
    return destDateString;
}

+ (NSString*)getDaysBetweenEndDate:(NSString* )endDate andStartDate:(NSString *)startDate withDateFormat:(NSString *)format{
    
    NSDateFormatter *df = [[DateFormatterManager sharedManager] getDateFormater];
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    df.dateFormat = format;
    
    NSDate *eDate = [df dateFromString:endDate];
    NSDate *sDate = [df dateFromString:startDate];
    
    long eSeconds = [eDate timeIntervalSince1970];
    long sSeconds = [sDate timeIntervalSince1970];
    
    long seconds = eSeconds - sSeconds;
    
    CGFloat days = 0.0f;
    if ( seconds > 0.1f ){
        days = (CGFloat)seconds/(CGFloat)(24*60*60);
    }
    NSString *daysStr = [NSString stringWithFormat:@"%.0f", days];
    return daysStr;
}

//单个字符分割的字符串提取
+(void)splitString:(NSString *)targetStr withCharacter:(NSString *)divideStr andSubstrArr:(NSMutableArray *)subStrArr{
    
    NSRange range = [targetStr rangeOfString:divideStr];
    if (range.location != NSNotFound) {
        NSString *subStr = [targetStr substringToIndex:range.location];
        [subStrArr addObject:subStr];
        NSString *leftStr = [targetStr substringFromIndex:range.location+1];
        [self splitString:leftStr withCharacter:divideStr andSubstrArr:subStrArr];
    }else{
        [subStrArr addObject:targetStr];
    }
}

@end
