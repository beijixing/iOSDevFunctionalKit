//
//  DrawerContrllerTest.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/9.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "DrawerContrllerTest.h"
#import "MMDrawerController.h"
#import "BlockTestVC.h"
#import "DelegateTestVC.h"
#import "MMDrawerVisualState.h"

@interface DrawerContrllerTest ()
{
    MMDrawerController *_drawerController;
}
@end

@implementation DrawerContrllerTest

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"DrawerContrllerTest";
    
    BlockTestVC *blockVc = [[BlockTestVC alloc] init];
    DelegateTestVC *delegateVc = [[DelegateTestVC alloc] init];
    _drawerController = [[MMDrawerController alloc] initWithCenterViewController:blockVc leftDrawerViewController:delegateVc];
    
    
    [_drawerController setDrawerVisualStateBlock:[MMDrawerVisualState slideAndScaleVisualStateBlock]];
    [_drawerController setMaximumLeftDrawerWidth:260.0];
    [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    
    [self.view addSubview: _drawerController.view];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
