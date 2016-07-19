//
//  BaseTableHeaderFooterView.h
//  TXiOSClient
//
//  Created by dsc on 15/5/7.
//  Copyright (c) 2015年 liguohui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableHeaderView;
@protocol TableHeaderViewDelegate <NSObject>

@required
- (void)headerViewDidTaped:(TableHeaderView *)tableHeaderView sectionIndex:(NSInteger)sectionIndex;

@end

@interface TableHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy)NSString *sectionTitle;  //  section标题
@property (nonatomic, strong)UIColor *contentBGColor;   //  背景色
@property (nonatomic, assign)BOOL isOpen;   //  当前section是否展开
@property (nonatomic, assign)NSInteger sectionIndex;    //  当前section为第几个
@property (nonatomic, assign)id<TableHeaderViewDelegate> delegate;

@end