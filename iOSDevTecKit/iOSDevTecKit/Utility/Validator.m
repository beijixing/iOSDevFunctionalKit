//
//  Validator.m
//  JinanNews
//
//  Created by Meing on 13-8-8.
//  Copyright (c) 2013年 upnet. All rights reserved.
//

#import "Validator.h"

@implementation Validator

+(BOOL)isValidPhone:(NSString *)phoneNumber
{
    NSString *numRegex = @"^1[3456789]{1}[\\d]{9}";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    return [numTest evaluateWithObject:phoneNumber];
}

+(BOOL)isValidPassword:(NSString *)password
{
    //特殊符号 -`=\\\[\];',./~!@#$%^&*()_+|{}:"<>?
    NSString *keyRegex = @"[A-Z0-9a-z-`=\\\\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]{6,16}";
    NSPredicate *keyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", keyRegex];
    return [keyTest evaluateWithObject:password];
}

+(BOOL)isSecurityCode:(NSString*)securitycode
{
    NSString *codeRegex=@"[\\d]{6}";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", codeRegex];
    return [codeTest evaluateWithObject:securitycode];
}

+(BOOL)isSpaceOrEmpty:(NSString*)string
{
    NSString *regex=@"^\\s*";
    NSPredicate * test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:string];
}

+(BOOL)isValidUsername:(NSString*)string
{
    NSString *regex = @"(?!\\d+$)[\\da-zA-Z0-9\u4e00-\u9fa5]+";//允许中文，英文，数字且不允许纯数字
    NSPredicate * test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:string];
}

+(BOOL)isValidEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isValidIDCard:(NSString *)idStr{
    NSString *regexIDCard=@"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *idCardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexIDCard];
    return [idCardTest evaluateWithObject:idStr];
}


@end
