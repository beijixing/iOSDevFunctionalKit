//
//  LinkedTableView.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/24.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "LinkedTableView.h"
@interface LinkedTableView ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *leftTable;
@property(nonatomic, strong) UITableView *rightTable;
@property(nonatomic) float leftTableWidth;
@property(nonatomic) BOOL isScrollDown;
@property(nonatomic) NSInteger selectIndex;
@end

@implementation LinkedTableView

- (instancetype)initWithFrame:(CGRect)frame AndLeftTableViewWidth:(float)width {
    if (self = [super initWithFrame:frame]) {
        self.leftTableWidth = width;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame AndLeftTableViewWidth:100];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.leftTable.frame = CGRectMake(0, 0, self.leftTableWidth>0 ? self.leftTableWidth : 100, self.frame.size.height);
    self.rightTable.frame = CGRectMake(self.leftTableWidth>0 ? self.leftTableWidth : 100, 0, self.frame.size.width - self.leftTable.frame.size.width, self.frame.size.height);
    [self addSubview:self.leftTable];
    [self addSubview:self.rightTable];
    
    
}

- (void)setDelegate:(id<LinkedTableViewDelegate>)delegate {
    if (_delegate != delegate) {
        _delegate = delegate;
        if (_delegate && [_delegate respondsToSelector:@selector(linkedTableView:registerCellForLeftTableView:rightTableView:)]) {
            [_delegate linkedTableView:self registerCellForLeftTableView:self.leftTable rightTableView:self.rightTable];
        }else {
            [self.leftTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"aCell"];
            [self.rightTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"bCell"];
        }
    }
}

#pragma mark UITableView Delegate and DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTable) {
        return [self.delegate linkedTableView:self getNumberOfRowsInSection:section forLeftTableView:YES];
    }else {
        return [self.delegate linkedTableView:self getNumberOfRowsInSection:section forLeftTableView:NO];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.leftTable) {
        return 1;
    }else {
        return [self.delegate numberOfSectionsInRightTable:self];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (tableView == self.leftTable) {
        cell = [tableView dequeueReusableCellWithIdentifier:[self.delegate linkedTableView:self getTableViewCellIdentifier:YES]];
    }else if (tableView == self.rightTable) {
        cell = [tableView dequeueReusableCellWithIdentifier:[self.delegate linkedTableView:self getTableViewCellIdentifier:NO]];
    }
    cell.backgroundColor = [UIColor colorWithRed:(rand()%255 / 255.0) green:(rand()%255 / 255.0) blue:(rand()%255 / 255.0) alpha:1.0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightTable) {
        return [self.delegate linkedTableView:self heightForHeaderView:NO];
    }else {
        return [self.delegate linkedTableView:self heightForHeaderView:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTable) {
        [self.delegate linkedTableView:self configTableCell:cell forRowAtIndexPath:indexPath forTableView:YES];
    }else {
    
        [self.delegate linkedTableView:self configTableCell:cell forRowAtIndexPath:indexPath forTableView:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTable) {
        return [self.delegate linkedTableView:self heightForRowOfTableView:YES];
    }else {
        return [self.delegate linkedTableView:self heightForRowOfTableView:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static CGFloat lastOffsetY = 0;
    UITableView *tableView = (UITableView *) scrollView;
    if (self.rightTable == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.leftTable == tableView)
    {
        _selectIndex = indexPath.row;
        [self.rightTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else {
        [self.delegate linkedTableView:self rightTableDidSelectedCellAtIndexPath:indexPath];
    }
}
// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((self.rightTable == tableView) && !_isScrollDown && self.rightTable.dragging)
    {
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((self.rightTable == tableView) && _isScrollDown && self.rightTable.dragging)
    {
        [self selectRowAtIndexPath:section + 1];
    }
}

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (UITableView *)leftTable {
    if (_leftTable) {
        return _leftTable;
    }
    _leftTable = [[UITableView alloc] init];
    _leftTable.dataSource = self;
    _leftTable.delegate = self;
    return _leftTable;
}

- (UITableView *)rightTable {
    if (_rightTable) {
        return _rightTable;
    }
    _rightTable = [[UITableView alloc] init];
    _rightTable.delegate = self;
    _rightTable.dataSource = self;
    return _rightTable;
}

@end