//
//  DelegateTestVC.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/3.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvinceViewController.h"

@interface DelegateTestVC : BaseViewController<ProvinceViewControllerDelegate>
- (IBAction)selectProvinceClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *provinceLb;

@end
