//
//  ProvinceViewController.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/28.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "ProvinceViewController.h"

@interface ProvinceViewController ()
{
    NSArray *provinces;
}
@end

@implementation ProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"省份选择";
    
    provinces = [NSArray arrayWithObjects:@"北京",@"天津",@"上海", @"内蒙古",@"山东",@"河北", @"河南", @"山西", @"甘肃", @"新疆", nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName = [NSString stringWithFormat:@"cellName"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    NSString *province = [provinces objectAtIndex:indexPath.row];
    cell.textLabel.text = province;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *province = [provinces objectAtIndex:indexPath.row];
    [self.delegate selectProvince:province];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
