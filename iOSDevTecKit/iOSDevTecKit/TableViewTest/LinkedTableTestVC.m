//
//  LinkedTableTestVC.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/24.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "LinkedTableTestVC.h"
#import "LinkedTableView.h"

@interface LinkedTableTestVC ()<LinkedTableViewDelegate>
{
    NSArray *_leftDataArr;
    NSArray *_rightDataArr;
}
@end

@implementation LinkedTableTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    LinkedTableView *tableView = [[LinkedTableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    _leftDataArr = [NSArray arrayWithObjects:@"电器",@"图书",@"自行车",@"汽车",@"药店", @"商场", nil];
    _rightDataArr = @[
                      @[@"电脑", @"电视机", @"电冰箱",@"洗衣机", @"电风扇", @"电磁炉", @"电热水壶"],
                      @[@"文学类图书", @"哲学类", @"教科书", @"计算机基础", @"Android开发", @"iOS开发"],
                      @[@"狼途自行车", @"凤凰牌自行车", @"NIKE自行车"],
                      @[@"长安", @"宝马", @"奥迪", @"奔驰", @"捷豹"],
                      @[@"漱玉平民", @"聚成阁药店", @"高新区卫生室"],
                      @[@"万达", @"恒隆", @"世茂", @"丁豪", @"美联", @"玉兰"]
                      ];
}

-(void)linkedTableView:(LinkedTableView *)linkedTable registerCellForLeftTableView:(UITableView *)leftTable rightTableView:(UITableView *)rightTable {
    [leftTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftCell"];
    [rightTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"rightCell"];
}

- (NSInteger)linkedTableView:(LinkedTableView *)linkedTable getNumberOfRowsInSection:(NSInteger)section forLeftTableView:(BOOL)forLeft //YES forLeftTableView; NO forRighTableView
{
    if (forLeft) {
        return _leftDataArr.count;
    }else {
        NSArray *arr = _rightDataArr[section];
        return arr.count;
    }
}

- (NSInteger)numberOfSectionsInRightTable:(LinkedTableView *)linkedTable {
    return _rightDataArr.count;
}

- (NSString *)linkedTableView:(LinkedTableView *)linkedTable getTableViewCellIdentifier:(BOOL)forLeftTable//YES forLeftTableView; NO forRighTableView
{
    if (forLeftTable) {
        return @"leftCell";
    }else {
        return @"rightCell";
    }
}

- (void)linkedTableView:(LinkedTableView *)linkedTable configTableCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath forTableView:(BOOL)left //YES forLeftTableView; NO forRighTableView
{
    if (left) {
        cell.textLabel.text = _leftDataArr[indexPath.row];
    }else {
        NSArray *arr = _rightDataArr[indexPath.section];
        cell.textLabel.text = arr[indexPath.row];
    }
}
- (CGFloat)linkedTableView:(LinkedTableView *)linkedTable heightForRowOfTableView:(BOOL)left//YES forLeftTableView; NO forRighTableView
{
    if (left) {
        return 44;
    }else {
        return 60;
    }
    
}

- (CGFloat)linkedTableView:(LinkedTableView *)linkedTable heightForHeaderView:(BOOL)left//YES forLeftTableView; NO forRighTableView
{
    if (left) {
        return 0;
    }else {
        return 20;
    }
}

- (void)linkedTableView:(LinkedTableView *)linkedTable rightTableDidSelectedCellAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"seleted table cell indexPath = (%ld, %ld)", indexPath.section, indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
