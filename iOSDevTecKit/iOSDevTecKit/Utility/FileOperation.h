//
//  FileOperation.h
//  WoJK
//
//  Created by Megatron on 16/5/25.
//  Copyright © 2016年 zhilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOperation : NSObject
+ (BOOL)copyFile:(NSString *)sourcePath toPath:(NSString *)toPath;
+ (void)createDirectory:(NSString *)createDir;
@end
