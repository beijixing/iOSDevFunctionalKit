//
//  AFNetBase.h
//  WoJK
//
//  Created by Megatron on 16/5/31.
//  Copyright © 2016年 zhilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNetBase : NSObject
+ (void)getDataFromServerWithHostUrl:(NSString *)url andParameters:(NSString *)parameter andResult:(void(^)(BOOL success, id object))resultBlock;

+(void)postDataToServerWithHostUrl:(NSString *)url andParameters:(NSDictionary *)parameterDict andResult:(void(^)(BOOL success, id object))resultBlock;

+ (void)uploadImageWithUrl:(NSString *)fullUrl andParameters:(NSDictionary *)parameterDict andImagePath:(NSString *)imagePath andResult:(void(^)(BOOL success, id object))resultBlock;

+ (void)downLoadFileWithUrl:(NSString *)urlStr andFilePath:(NSString *)filePath andResult:(void(^)(BOOL success, id object))resultBlock;

@end
