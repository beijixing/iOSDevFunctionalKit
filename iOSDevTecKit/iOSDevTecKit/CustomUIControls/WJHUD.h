//
//  WJHud.h
//  HD100-Custom
//
//  Created by WenJie on 15/7/8.
//  Copyright (c) 2015年 fosung_mac02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^WJHUDCompletionBlock)();

/*!
 *  优化MBProgressHUD的使用
 */
@interface WJHUD : NSObject

/*!
 *  只带一句话的提示框,自动消失
 *
 *  @param text 提示文字
 *  @param view 提示框所加在的view
 */
+ (void)showText:(NSString *)text onView:(UIView *)view;


/*!
 *  只带一句话的提示框,自动消失
 *
 *  @param text  提示文字
 *  @param view  提示框所加在的view
 *  @param block 提示框消失后回调
 */
+ (void)showText:(NSString *)text onView:(UIView *)view completionBlock:(WJHUDCompletionBlock)block;

/*!
 *  显示,与hideFromView搭配使用
 *
 *  @param view 提示框所加在的View
 */
+ (void)showOnView:(UIView *)view;// 显示
+ (void)hideFromView:(UIView *)view;// 移除

/*!
 *  在window上显示text
 *
 *  @param text 显示的text
 */
+ (void)showOnWindowWithText:(NSString *)text;
@end
