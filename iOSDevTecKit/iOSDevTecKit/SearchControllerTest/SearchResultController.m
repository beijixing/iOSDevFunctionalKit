//
//  SearchResultController.m
//  iOSDevTecKit
//
//  Created by horse on 2017/3/2.
//  Copyright © 2017年 郑光龙. All rights reserved.
//

#import "SearchResultController.h"

@interface SearchResultController ()

@end

@implementation SearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}



-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
   
    NSLog(@"searchString = %@", searchString);
}

@end
