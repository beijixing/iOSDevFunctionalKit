//
//  AFNetBase.m
//  WoJK
//
//  Created by Megatron on 16/5/31.
//  Copyright © 2016年 zhilong. All rights reserved.
//

#import "AFNetBase.h"
//#import "WJHUD.h"
#import "AppDelegate.h"

@implementation AFNetBase
+ (void)getDataFromServerWithHostUrl:(NSString *)url andParameters:(NSString *)parameter andResult:(void(^)(BOOL success, id object))resultBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"application/octet-stream", nil];
    NSString *fullUrl;
    if (parameter && ![parameter isEqualToString:@""]) {
        fullUrl = [NSString stringWithFormat:@"%@%@", url, parameter];
    }else {
        fullUrl = url;
    }
    fullUrl = [fullUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"fullUrl = %@", fullUrl);
    [manager GET:fullUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        resultBlock(YES, responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        resultBlock(NO, error);
        if (error.code == -1001) {
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//            [WJHUD showText:@"网络不好，请稍后再试" onView:delegate.window];
        }
    }];
}

+(void)postDataToServerWithHostUrl:(NSString *)url andParameters:(NSDictionary *)parameterDict andResult:(void(^)(BOOL success, id object))resultBlock {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    
    [manager POST:url parameters:parameterDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        resultBlock(YES, responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        resultBlock(NO, error);
    }];
}

+ (void)uploadImageWithUrl:(NSString *)fullUrl andParameters:(NSDictionary *)parameterDict andImagePath:(NSString *)imagePath andResult:(void(^)(BOOL success, id object))resultBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/jpeg", @"image/png",nil];
    NSLog(@"fullUrl = %@", fullUrl);
    
    [manager POST:fullUrl parameters:parameterDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData: UIImageJPEGRepresentation([UIImage imageWithContentsOfFile:imagePath], 1.0) name:@"FileData" fileName:imagePath mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        resultBlock(YES, responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        resultBlock(NO, error);
    }];
    
}

+ (void)downLoadFileWithUrl:(NSString *)urlStr andFilePath:(NSString *)filePath andResult:(void(^)(BOOL success, id object))resultBlock {
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downLoadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        resultBlock(YES, filePath.path);
    }];
    
    [downLoadTask resume];
}
@end
