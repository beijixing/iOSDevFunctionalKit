//
//  BlockTestVC.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/3.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockTestVC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *provinceLb;
- (IBAction)selectProvinceButtonClick:(UIButton *)sender;
@end
