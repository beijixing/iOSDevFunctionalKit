//
//  PullDownMenu.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/25.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetSelectedTextBlock)(NSString *);

@interface PullDownMenu : UIView<UITableViewDataSource, UITableViewDelegate>
+ (instancetype)menu;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorImageView;
@property (nonatomic, copy) GetSelectedTextBlock getSelectedText;
@property (nonatomic) CGRect showListFrame;
@property (nonatomic) CGRect hideListFrame;
@end
