//
//  PullDownMenuTest.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/23.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "PullDownMenuTest.h"
#import "PullDownMenu2.h"
#import "PullDownMenu.h"

@interface PullDownMenuTest ()

@end

@implementation PullDownMenuTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    PullDownMenu2 *pullDownMen = [PullDownMenu2  menu];
////    pullDownMen.frame = CGRectMake(0, 0, 100, 40);
//    pullDownMen.showListFrame = CGRectMake(100, 100, 150, 250);
//    pullDownMen.hideListFrame = CGRectMake(100, 100, 150, 45);
//    pullDownMen.getSelectedText = ^(NSString *text){
//        NSLog(@"text = %@", text);
//    };
//    pullDownMen.dataSoure = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
//    [self.view addSubview:pullDownMen];
    
    PullDownMenu *pullMenu = [[PullDownMenu alloc] initWithFrame:CGRectMake(100, 100, 150, 45)];
    pullMenu.showListFrame = CGRectMake(100, 100, 150, 250);
    pullMenu.hideListFrame = CGRectMake(100, 100, 150, 45);
    pullMenu.dataSource = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    [self.view addSubview:pullMenu];

    PullDownMenu *pullMenu2 = [[PullDownMenu alloc] initWithFrame:CGRectMake(100, 300, 150, 45)];
    pullMenu2.showListFrame = CGRectMake(100, 300, 150, 250);
    pullMenu2.hideListFrame = CGRectMake(100, 300, 150, 45);
    pullMenu2.dataSource = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    pullMenu2.defaultDataId = 3;
    pullMenu2.indicatorImageName = @"arrow-left";
    [self.view addSubview:pullMenu2];
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
