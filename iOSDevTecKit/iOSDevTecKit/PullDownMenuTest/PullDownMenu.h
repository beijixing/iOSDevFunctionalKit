//
//  PullDownMenu.h
//  iOSDevTecKit
//
//  Created by ybon on 16/1/18.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetSelectedDataIdxBlock)(NSInteger idx, NSString *txt);
typedef void(^ShowAndHideListViewEvent)(void);

@interface PullDownMenu : UIView
@property (nonatomic, assign) BOOL showList;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic) CGRect showListFrame;
@property (nonatomic) CGRect hideListFrame;
@property (nonatomic, strong) NSString *indicatorImageName;
@property (nonatomic) NSInteger defaultDataId;
@property (nonatomic, copy) GetSelectedDataIdxBlock getSelectedDataIdx;
@property (nonatomic, copy) ShowAndHideListViewEvent showListViewEvent;
@property (nonatomic, copy) ShowAndHideListViewEvent hideListViewEvent;
@end
