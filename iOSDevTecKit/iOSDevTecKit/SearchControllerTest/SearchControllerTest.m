//
//  SearchControllerTest.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 16/1/5.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "SearchControllerTest.h"
#import "SearchResultController.h"
@interface SearchControllerTest ()<UISearchBarDelegate>
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
    
    SearchResultController *resultCtrl = [[SearchResultController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:resultCtrl];
    _searchController.searchResultsUpdater = resultCtrl;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.dataTableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"搜索信息";
    self.searchController.searchBar.showsScopeBar = NO;
    [self.dataTableView reloadData];
    [self configSearchBar:self.searchController.searchBar];
    [self.searchController.searchBar becomeFirstResponder];
}

- (void)configSearchBar:(UISearchBar *)searchBar {
    searchBar.backgroundColor = [UIColor redColor];
    NSArray *subviews = searchBar.subviews;
    UIView *searchBarContentView = subviews[0];
    searchBarContentView.tintColor = [UIColor redColor];
    NSArray *contentSubviews = [searchBarContentView subviews];
    NSLog(@"%@", [searchBar performSelector:@selector(recursiveDescription)]);

    searchBar.tintColor = [UIColor blueColor];

    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
     
     setTitleTextAttributes:
     
     [NSDictionary dictionaryWithObjectsAndKeys:
      
      [UIColor whiteColor],
      
      UITextAttributeTextColor,
      
      [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
      
      UITextAttributeTextShadowOffset,nil]
     
     forState:UIControlStateNormal];

    
    for (UIView *subView in contentSubviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            NSLog(@"UINavigationButton");
            UITextField *searchTextField = (UITextField *)subView;
            searchTextField.backgroundColor = [UIColor blueColor];
        }else if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            UIView *backgroundView = (UITextField *)subView;
            [backgroundView removeFromSuperview];//删除UISearchBarBackground后再设置searchBar.backgroundColor就可以显示设置的背景色了。
//            backgroundView.tintColor = [UIColor greenColor];
        }
        
    }
    
    
    
};

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
//        cell.textLabel.text = self.searchList[indexPath.row];
    }else {
        cell.textLabel.text = self.dataList[indexPath.row];
    }
    return cell;
}



- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.navigationController.navigationBarHidden = YES;
    
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.navigationController.navigationBarHidden = NO;
}
@end
