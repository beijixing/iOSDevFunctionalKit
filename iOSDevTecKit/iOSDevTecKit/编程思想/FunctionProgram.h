//
//  FunctionProgram.h
//  iOSDevTecKit
//
//  Created by ybon on 16/2/14.
//  Copyright © 2016年 郑光龙. All rights reserved.
//


/*
 函数式编程:是把操作尽量写成一系列嵌套的函数或者方法调用。
 
 函数式编程特点：每个方法必须有返回值（本身对象）,把函数或者Block当做参数,block参数（需要操作的值）block返回值（操作结果）
 
 代表：ReactiveCocoa。
 */
#import <UIKit/UIKit.h>

@interface FunctionProgram : UIViewController

@end


@interface Calculator : NSObject
@property(nonatomic, assign) BOOL isEqule;
@property(nonatomic, assign) int result;
- (Calculator *)calcaulator:(int (^)(int result))calcaulator;
- (Calculator *)equle:(BOOL (^)(int result))operation;
@end