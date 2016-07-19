//
//  Validator.h
//  JinanNews
//
//  Created by Meing on 13-8-8.
//  Copyright (c) 2013年 upnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

//手机号是否有效
+(BOOL)isValidPhone:(NSString *)phone;

//密码是否有效
+(BOOL)isValidPassword:(NSString *)key;

//验证码是否有效
+(BOOL)isSecurityCode:(NSString*)securitycode;

//是否为空字符串
+(BOOL)isSpaceOrEmpty:(NSString*)string;

//邮箱
+(BOOL)isValidEmail:(NSString *)email;

//身份证号
+(BOOL)isValidIDCard:(NSString *)idStr;

//校验用户名,允许中文，英文，数字且不允许纯数字
+(BOOL)isValidUsername:(NSString*)string;
@end
