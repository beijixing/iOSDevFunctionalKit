//
//  PullDownMenu.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/25.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetSelectedTextBlock)(NSString *);
typedef void(^ShowListViewEventBlock)(void);
typedef void(^HideListViewEventBlock)(void);
@interface PullDownMenu2 : UIView<UITableViewDataSource, UITableViewDelegate>
+ (instancetype)menu;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorImageView;
@property (nonatomic, copy) GetSelectedTextBlock getSelectedText;
@property (nonatomic) CGRect showListFrame;
@property (nonatomic) CGRect hideListFrame;
@property (nonatomic, copy) ShowListViewEventBlock showListViewEvent;
@property (nonatomic, copy) HideListViewEventBlock hideListViewEvent;
@property (nonatomic, assign) BOOL state;
@property (nonatomic, strong) NSArray *dataSoure;
@property (strong, nonatomic) IBOutlet UIImageView *smallArrowImage;

-(void)showAmallImageView:(BOOL)show;
@end
