//
//  BaseViewController.m
//  LearnPlan
//
//  Created by 郑光龙 on 15/10/31.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, copy) LeftBarButtonItemBlock leftBarButtonBlock;
@property (nonatomic, copy) RightBarButtonItemBlock rightBarButtonBlock;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica" size:14.0f], NSFontAttributeName,nil]];
    
    //    self.view.backgroundColor = BACKGROUND_COLOR;
    //ios7.0适配
    if ( iOS_VERSION  >= 7.0) {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLeftNavigationBarButtonItemWithImage:(NSString *)imageName andAction:(LeftBarButtonItemBlock)action {
    
    UIButton *leftBtn = [ToolBox createButtonWithFrame:CGRectMake(0, 0, 10, 15) buttonImageName:imageName selector:@selector(leftButtonItemClick) target:self];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    self.leftBarButtonBlock = action;
}

- (void)leftButtonItemClick {
    if (self.leftBarButtonBlock) {
        self.leftBarButtonBlock();
    }
}

- (void)setRightNavigationBarButtonItemWithImage:(NSString *)imageName andAction:(RightBarButtonItemBlock)action {
    
    UIButton *rightBtn = [ToolBox createButtonWithFrame:CGRectMake(0, 0, 24, 24) buttonImageName:imageName selector:@selector(rightButtonItemClick) target:self];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.rightBarButtonBlock = action;
}

- (void)rightButtonItemClick {
    if (self.rightBarButtonBlock) {
        self.rightBarButtonBlock();
    }
}

@end
