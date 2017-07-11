//
//  CTestViewController.m
//  iOSDevTecKit
//
//  Created by horse on 2017/7/11.
//  Copyright © 2017年 郑光龙. All rights reserved.
//

#import "CTestViewController.h"

@interface CTestViewController ()

@end

@implementation CTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dynamicCreateCStruct];
}


//C语言中结构体数组的动态生成及赋值
- (void)dynamicCreateCStruct {
    
    int n = 10;
    int Len = n*sizeof(CLLocationCoordinate2D);
    CLLocationCoordinate2D *_runningPoints = (CLLocationCoordinate2D *)malloc(Len);
    
    for (int i = 0; i < n; i++) {
        _runningPoints[i].latitude = i*100;
        _runningPoints[i].longitude = i*200;
        
    }
    
    for (int i = 0; i < n; i++) {
        NSLog(@"_runningPoints[i].longitude = %f", _runningPoints[i].longitude);
        NSLog(@"_runningPoints[i].latitude = %f", _runningPoints[i].latitude);
    }
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
