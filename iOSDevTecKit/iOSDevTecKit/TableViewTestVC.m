//
//  TableViewTestVC.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/3.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "TableViewTestVC.h"
#import "MJRefresh.h"

@interface TableViewTestVC () {
    NSInteger dataNumber;
}

@end

@implementation TableViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"tableView";
    
    [self getPageData];
    
    myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getPageData];
    }];
//    myTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        [self getPageData];
//    }];
    
    
}

- (void)getPageData {
    dataNumber = 10;
    [myTableView reloadData];
    
    [myTableView.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataNumber;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UITableViewHeaderFooterView *view = [[[NSBundle mainBundle] loadNibNamed:@"SelfDefineView" owner:self options:nil] lastObject];
    view.contentView.backgroundColor = [UIColor redColor];
    view.textLabel.text = @"shit";
    view.detailTextLabel.text = @"nihao";
    
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName = [NSString stringWithFormat:@"cellName"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text = @"it's a test";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell text = %@", cell.textLabel.text);
    
    
}
@end
