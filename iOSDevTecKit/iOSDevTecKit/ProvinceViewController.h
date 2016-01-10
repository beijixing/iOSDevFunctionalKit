//
//  ProvinceViewController.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/28.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProvinceViewControllerDelegate
- (void)selectProvince:(NSString *)selectedProvince;
@end

@interface ProvinceViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *provinceTable;

//通过代理方法把选择的省份信息传回到上层页面，注意代理属性的写法 nonatomic, assign ;id<Delegate> delegate
@property (nonatomic, assign) id<ProvinceViewControllerDelegate> delegate;
@end
