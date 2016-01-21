//
//  MainViewController.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/3.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "MainViewController.h"
#import "ZTabBarController.h"

@interface MainViewController ()
{
    NSArray *modulesName;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"知识点列表";
    
    modulesName = [NSArray arrayWithObjects:
                   @"ZTabBarController",
                   @"TableViewTestVC",
//                   @"ScrollViewVC",
//                   @"PageViewVC",
//                   @"CollectionViewVC",
                   @"BlockTestVC",
                   @"DelegateTestVC",
//                   @"AFNetworkingVC",
//                   @"FMDBVC",
                   @"SDWebImageTest",
                   @"MapTestVC",
                   @"StaticAnnotationTest",
//                   @"DrawerContrllerTest",
                   @"CoreAnimationTestVC",
                   @"PullDownMenuTest",
                   @"SearchControllerTest",
                   @"FoldScrollViewItemAnimation",
                   @"ModalTestVC",
                   @"VideoPlayTestVC",
                   nil ];
}

- (void)leftBtnClick {
    NSLog(@"leftBtnClick");
    [self presentViewController:[[ZTabBarController alloc] init] animated:YES completion:^{
    }];
}

#pragma mark --TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [modulesName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName = [NSString stringWithFormat:@"CellName"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    
    NSString *title = modulesName[indexPath.row];
    cell.textLabel.text = title;
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *viewControllerName = [modulesName objectAtIndex:indexPath.row];
    
    /*
     NSClassFromString 无需引入头文件
     1 弱化连接，因此并不会把没有的Framework也link到程序中。
     2 不需要使用import，因为类是动态加载的，只要存在就可以加载。
     */
    UIViewController *vc = [[NSClassFromString(viewControllerName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    
//    UIView *view = [[UIView alloc] init];
//    [view setCenter:<#(CGPoint)#>]
    
   NSString *daysStr = [ToolBox getDaysBetweenEndDate:@"2015-12-27 8:00:00" andStartDate:@"2015-12-23 22:00:00" withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSLog(@"%@", daysStr);

}



@end
