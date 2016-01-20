//
//  PullDownMenu.m
//  iOSDevTecKit
//
//  Created by ybon on 16/1/18.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "PullDownMenu.h"
@interface PullDownMenu() <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_dataTable;
    UIView *_tableHeader;
    UILabel *_titleLabel;
    UIImageView *_indicatorImageView;
}
@end

@implementation PullDownMenu
- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createControls];        
    }
    return self;
}

- (void)setIndicatorImageName:(NSString *)indicatorImageName {
    if (_indicatorImageName != indicatorImageName) {
        _indicatorImageName = indicatorImageName;
        _indicatorImageView.image = [UIImage imageNamed:indicatorImageName];
    }
}

- (void)setShowList:(BOOL)showList {
    if (_showList != showList) {
        _showList = showList;
        if (_showList) {
            self.frame = self.showListFrame;
            _indicatorImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
        else {
            self.frame = self.hideListFrame;
            _indicatorImageView.transform = CGAffineTransformMakeRotation(0);
        }
    }
}

- (void)createControls {
    _dataTable = [[UITableView alloc] initWithFrame:CGRectZero];
    _dataTable.delegate = self;
    _dataTable.dataSource = self;
    
    _tableHeader = [[UIView alloc] initWithFrame:CGRectZero];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [_tableHeader addSubview:_titleLabel];
    [_tableHeader addSubview:_indicatorImageView];
    [_tableHeader addGestureRecognizer:tapGesture];
    _indicatorImageView.image = [UIImage imageNamed:@"rightArrow"];
    
    [self addSubview:_dataTable];
    _tableHeader.backgroundColor = [UIColor redColor];
}

- (void)tapGesture:(UIGestureRecognizer *)gesture {
    self.showList = !self.showList;
    if (self.showList) {
        self.frame = self.showListFrame;
        _indicatorImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        if (self.showListViewEvent ) {
            self.showListViewEvent();
        }
    }
    else {
        self.frame = self.hideListFrame;
        _indicatorImageView.transform = CGAffineTransformMakeRotation(0);
        if (self.hideListViewEvent) {
            self.hideListViewEvent();
        }
    }
    [_dataTable reloadData];
}

- (void)setDefaultDataId:(NSInteger)defaultDataId {
    _titleLabel.text = [NSString stringWithFormat:@"%@", self.dataSource[defaultDataId]];
}

- (void)layoutSubviews {
    _dataTable.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _tableHeader.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    _indicatorImageView.frame =  CGRectMake(self.frame.size.width - 20, 10 , 10, 10);
    _titleLabel.frame = CGRectMake(15, 0, CGRectGetMinX(_indicatorImageView.frame), 30);
}

#pragma mark UITableView Delegate Methods
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"cellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

//为cell赋值数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.frame = CGRectMake(0, 0, self.frame.size.width, 44);
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataSource[indexPath.row]];
}

//tableview cell 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.showList) {
        return self.dataSource.count;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

//返回tableview头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _tableHeader;
}

//选择某一行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _titleLabel.text = [NSString stringWithFormat:@"%@", self.dataSource[indexPath.row]];
    if (self.getSelectedDataIdx) {
        self.getSelectedDataIdx(indexPath.row, _titleLabel.text);
    }
    self.showList = NO;
    _indicatorImageView.transform = CGAffineTransformMakeRotation(0);
    [_dataTable reloadData];
}

@end
