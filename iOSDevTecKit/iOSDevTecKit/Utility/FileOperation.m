//
//  FileOperation.m
//  WoJK
//
//  Created by Megatron on 16/5/25.
//  Copyright © 2016年 zhilong. All rights reserved.
//

#import "FileOperation.h"

@implementation FileOperation
+ (BOOL)copyFile:(NSString *)sourcePath toPath:(NSString *)toPath
{
    BOOL retVal = YES; // If the file already exists, we'll return success…
    NSString * finalLocation = [toPath stringByAppendingPathComponent:[sourcePath lastPathComponent]];
    [[NSFileManager defaultManager] removeItemAtPath:finalLocation error:nil];
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalLocation])
    {
        retVal = [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:finalLocation error:NULL];
    }
    return retVal;
}

/**
 * @brief 创建文件夹
 *
 * @param createDir 创建文件夹路径
 */
+ (void)createDirectory:(NSString *)createDir
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:createDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:createDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
@end
