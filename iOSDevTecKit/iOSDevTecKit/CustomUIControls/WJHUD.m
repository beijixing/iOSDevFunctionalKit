//
//  WJHud.m
//  HD100-Custom
//
//  Created by WenJie on 15/7/8.
//  Copyright (c) 2015年 fosung_mac02. All rights reserved.
//

#import "WJHUD.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@implementation WJHUD
+(void)showText:(NSString *)text onView:(UIView *)view
{
    [WJHUD showText:text onView:view completionBlock:NULL];
}
+(void)showText:(NSString *)text onView:(UIView *)view completionBlock:(WJHUDCompletionBlock)block
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.completionBlock = block;
    [hud hide:YES afterDelay:1];
}

+ (void)showOnView:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:view];
    [view addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
}
+ (void)hideFromView:(UIView *)view;
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    [hud hide:YES];
}

+(void)showOnWindowWithText:(NSString *)text
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:delegate.window];
    [delegate.window addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:1];

}

@end
