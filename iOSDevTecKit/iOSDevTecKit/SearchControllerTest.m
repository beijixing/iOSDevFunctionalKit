//
//  SearchControllerTest.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 16/1/5.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "SearchControllerTest.h"

@interface SearchControllerTest ()<UISearchBarDelegate, UISearchResultsUpdating>
@property(nonatomic, strong) NSMutableArray *searchList;
@property(nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, strong) UISearchController *searchController;
@end

@implementation SearchControllerTest

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = [[NSMutableArray alloc] init];
    self.searchList = [[NSMutableArray alloc] init];
    for (int i = 0; i<100; i++) {
        NSString *str = [NSString stringWithFormat:@"Hello World%d", i];
        [self.dataList addObject:str];
    }
//    [self.dataTableView reloadData];
    [self initSearchController];
}


-(void)initSearchController {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.dataTableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"搜索信息";
    self.searchController.searchBar.showsScopeBar = NO;
    
    
    [self.dataTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (self.searchController.active) {
        count = self.searchList.count;
    }else{
        count = self.dataList.count;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"cellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if (self.searchController.active) {
        cell.textLabel.text = self.searchList[indexPath.row];
    }else {
        cell.textLabel.text = self.dataList[indexPath.row];
    }
    return cell;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.dataTableView reloadData];
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.navigationController.navigationBarHidden = YES;
    
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.navigationController.navigationBarHidden = NO;
}
@end
