//
//  ProvinceVC2.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/28.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProvinceVC2 : UIViewController
{
    
    __weak IBOutlet UITableView *provinceTable;
}
//通过使用block 变量把选择的省份传递到上层界面， 注意属性的写法 nonatomic, copy;
@property (nonatomic, copy) void (^cellSelectBlcok)(NSString* provinceName);
@end
