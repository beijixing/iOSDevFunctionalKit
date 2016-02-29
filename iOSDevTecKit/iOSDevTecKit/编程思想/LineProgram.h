//
//  lianshiThink.h
//  iOSDevTecKit
//
//  Created by ybon on 16/2/14.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

/*
 链式编程
 是将多个操作（多行代码）通过点号(.)链接在一起成为一句代码,使代码可读性好。a(1).b(2).c(3)
 
 链式编程特点：方法的返回值是block,block必须有返回值（本身对象），block参数（需要操作的值）
 
 代表：masonry框架
 */
#import <UIKit/UIKit.h>

@interface LineProgram : UIViewController

@end


@interface CaculatorMaker : NSObject
@property (nonatomic, assign)int result;
-(CaculatorMaker * (^)(int))add;
-(CaculatorMaker * (^)(int))sub;
-(CaculatorMaker * (^)(int))divide;
-(CaculatorMaker * (^)(int))multi;
@end

@interface NSObject (Caculator)
+(int)makeCaculators:(void(^)(CaculatorMaker *maker))caculatorMaker;
@end