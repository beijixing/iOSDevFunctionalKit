//
//  BaseViewController.m
//  LearnPlan
//
//  Created by 郑光龙 on 15/10/31.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica" size:19.0f], NSFontAttributeName,nil]];
    
    //ios7.0适配
    if ( iOS_VERSION  >= 7.0) {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
