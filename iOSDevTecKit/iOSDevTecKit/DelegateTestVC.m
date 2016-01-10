//
//  DelegateTestVC.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/3.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "DelegateTestVC.h"

@interface DelegateTestVC ()

@end

@implementation DelegateTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"delegate";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectProvinceClick:(UIButton *)sender {
    
    ProvinceViewController *provinceVC = [[ProvinceViewController alloc] init];
    provinceVC.delegate = self;
    [self.navigationController pushViewController:provinceVC animated:YES];
}

- (void)selectProvince:(NSString *)selectedProvince {
    self.provinceLb.text = selectedProvince;
}
@end
