//
//  UDIDManager.m
//  WoJK
//
//  Created by Megatron on 16/4/20.
//  Copyright © 2016年 zhilong. All rights reserved.
//

#import "UDIDManager.h"
//#import "KeychainItemWrapper.h"

@implementation UDIDManager
+(NSString *)getUDID {
//    KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Wojk_UDID" accessGroup:nil];
//    NSString * udid = [keychin objectForKey:(__bridge id)kSecValueData];
//    if ([udid isEqualToString:@""]) {
//        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
//        udid = (__bridge_transfer NSString* )CFUUIDCreateString (kCFAllocatorDefault,uuidRef);
//        [keychin setObject:udid forKey:(id)kSecValueData];
//    }
    return @"";//udid;
}

+(NSString *)getTempUDID {
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *udid = (__bridge_transfer NSString* )CFUUIDCreateString (kCFAllocatorDefault,uuidRef);
    return udid;
}

@end
