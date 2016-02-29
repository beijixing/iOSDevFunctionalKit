//
//  SearchControllerTest.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 16/1/5.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchControllerTest : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@end
