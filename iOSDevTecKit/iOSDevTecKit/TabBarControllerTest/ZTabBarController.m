//
//  ZTabBarController.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/3.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "ZTabBarController.h"
#import "TableViewTestVC.h"
#import "BlockTestVC.h"
#import "DelegateTestVC.h"

@interface ZTabBarController ()

@end

@implementation ZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TableViewTestVC *tableVC = [[TableViewTestVC alloc]init];
    tableVC.tabBarItem.image = [[UIImage imageNamed:@"bottom_menu_i1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tableVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"bottom_menu_i1_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tableVC.tabBarItem.title = @"table";
    
    
//    tableViewNav.tabBarItem.image = [[UIImage imageNamed:@"bottom_menu_i1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    tableViewNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"bottom_menu_i1_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    tableViewNav.tabBarItem.title = @"table";
    
    BlockTestVC *blockVC = [[BlockTestVC alloc] init];
    blockVC.tabBarItem.image = [[UIImage imageNamed:@"bottom_menu_i2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    blockVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"bottom_menu_i2_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    blockVC.tabBarItem.title = @"block";
    
//    blockNav.tabBarItem.image = [[UIImage imageNamed:@"bottom_menu_i2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    blockNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"bottom_menu_i2_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    blockNav.tabBarItem.title = @"block";
    
    DelegateTestVC *delegateVC = [[DelegateTestVC alloc] init];
    delegateVC.tabBarItem.image = [[UIImage imageNamed:@"bottom_menu_i3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    delegateVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"bottom_menu_i3_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    delegateVC.tabBarItem.title = @"delegate";

//    delegateNav.tabBarItem.image = [[UIImage imageNamed:@"bottom_menu_i3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    delegateNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"bottom_menu_i3_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    delegateNav.tabBarItem.title = @"delegate";
    
    
    
    UIView *backGroundView = [ToolBox createViewWithFrame:CGRectMake(0, 0, MainScreenWidth, 49) andBackgroundColor:ColorWithRGB(30, 30, 30)];
    [self.tabBar insertSubview:backGroundView atIndex:0];
    self.tabBar.opaque = YES;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ColorWithRGB(255, 255, 255), NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:15.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MAIN_COLOR, NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:15.0f], NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    self.viewControllers = @[tableVC, blockVC, delegateVC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
