//
//  BaseViewController.h
//  LearnPlan
//
//  Created by 郑光龙 on 15/10/31.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LeftBarButtonItemBlock)(void);
typedef void (^RightBarButtonItemBlock)(void);

@interface BaseViewController : UIViewController
- (void)setLeftNavigationBarButtonItemWithImage:(NSString *)imageName andAction:(LeftBarButtonItemBlock)action;

- (void)setRightNavigationBarButtonItemWithImage:(NSString *)imageName andAction:(RightBarButtonItemBlock)action;
@end
