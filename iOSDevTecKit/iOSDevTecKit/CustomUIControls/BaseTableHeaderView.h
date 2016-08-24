//
//  BaseTableHeaderFooterView.h
//  TXiOSClient
//
//  Created by dsc on 15/5/7.
//  Copyright (c) 2015年 liguohui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseTableHeaderView;
@protocol TableHeaderViewDelegate <NSObject>

@required
- (void)headerViewDidTaped:(BaseTableHeaderView *)tableHeaderView sectionIndex:(NSInteger)sectionIndex;

@end

@interface BaseTableHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) UIView *sectionTitleView;  //承载标题的view
@property (nonatomic, copy) UIImageView *indicatorImgView;
@property (nonatomic, copy) UILabel *titleLabel;  //  section标题
@property (nonatomic, strong) UIColor *contentBGColor;   //  背景色
@property (nonatomic, assign) BOOL isOpen;   //  当前section是否展开
@property (nonatomic, assign) NSInteger sectionIndex;    //  当前section为第几个
@property (nonatomic, assign) id<TableHeaderViewDelegate> delegate;

@end