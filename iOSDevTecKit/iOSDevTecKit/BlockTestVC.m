//
//  BlockTestVC.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/3.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "BlockTestVC.h"
#import "ProvinceVC2.h"

@interface BlockTestVC ()

@end

@implementation BlockTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"block";

}
- (IBAction)selectProvinceButtonClick:(UIButton *)sender {
    ProvinceVC2 *provinceVc2 = [[ProvinceVC2 alloc] init];
    provinceVc2.cellSelectBlcok = ^(NSString* province){
        self.provinceLb.text = province;
    };
    [self.navigationController pushViewController:provinceVc2 animated:YES];
}
@end
