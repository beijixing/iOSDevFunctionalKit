//
//  PullDownMenuTest.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/23.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "PullDownMenuTest.h"
#import "PullDownMenu.h"
#import "DefinedCell.h"

@interface PullDownMenuTest ()

@end

@implementation PullDownMenuTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PullDownMenu *pullDownMen = [PullDownMenu  menu];
//    pullDownMen.frame = CGRectMake(0, 0, 100, 40);
    pullDownMen.showListFrame = CGRectMake(100, 100, 150, 250);
    pullDownMen.hideListFrame = CGRectMake(100, 100, 150, 35);
    pullDownMen.getSelectedText = ^(NSString *text){
        NSLog(@"text = %@", text);
    };
    
    [self.view addSubview:pullDownMen];

    
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
