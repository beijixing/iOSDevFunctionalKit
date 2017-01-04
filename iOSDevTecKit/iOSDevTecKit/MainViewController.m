//
//  MainViewController.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/3.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "MainViewController.h"
#import "ZTabBarController.h"
#import "TableHeaderView.h"
#import "UIFactory.h"
#define lastOpenSection 9999


@interface MainViewController ()<TableHeaderViewDelegate, UITabBarControllerDelegate>
{
    NSArray *_modulesName;
    NSMutableArray  *_sourceDataOpenState;
    NSInteger _lastOpenedSection;
    NSDictionary *_moduleViewControllerDict;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"知识点列表";
    _lastOpenedSection = lastOpenSection;
    
    _modulesName = [NSArray arrayWithObjects:
                   @"TabBarController",
                   @"TableView",
//                   @"ScrollViewVC",
//                   @"PageViewVC",
//                   @"CollectionViewVC",
                   @"BlockTest",
                   @"DelegateTest",
//                   @"AFNetworkingVC",
//                   @"FMDBVC",
                   @"SDWebImageTest",
                   @"MapTest",
//                   @"DrawerContrllerTest",
                   @"CoreAnimationTest",
                   @"PullDownMenuTest",
                   @"SearchController",
                   @"ScrollViewTest",
                   @"ModalViewTest",
                   @"VideoPlayer",
                   @"ProgramThaught",
                   @"PickerViewTest",
                   @"CoreDataTest",
                   nil];
    _moduleViewControllerDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                @[@"ZTabBarController"],
                                 @"TabBarController",
                                @[@"TableViewTestVC", @"LinkedTableTestVC"],
                                 @"TableView",
                                @[@"BlockTestVC"],
                                 @"BlockTest",
                                @[@"DelegateTestVC"],
                                 @"DelegateTest",
                                @[@"SDWebImageTest", @"AnnotateImage"],
                                 @"SDWebImageTest",
                                @[@"MapTestVC",@"StaticAnnotationTest"],
                                 @"MapTest",
                                @[@"CoreAnimationTestVC", @"TransformTestVC", @"CALayerTestVC", @"CATransactionTestVC", @"LayerHitTestVC", @"CABasicAnimationTestVC", @"CAKeyFrameAnimationVC", @"CAAnimationGroupTestVC", @"CATransitionTestVC", @"CustomAnimationVC"],
                                 @"CoreAnimationTest",
                                @[@"PullDownMenuTest"],
                                 @"PullDownMenuTest",
                                @[@"SearchControllerTest"],
                                 @"SearchController",
                                @[@"FoldScrollViewItemAnimation"],
                                 @"ScrollViewTest",
                                @[@"ModalTestVC"],
                                 @"ModalTest",
                                @[@"VideoPlayTestVC"],
                                 @"VideoPlayer",
                                @[ @"LineProgram",@"FunctionProgram"],
                                 @"ProgramThaught",
                                @[@"PickerViewTestVC"],
                                 @"PickerViewTest",
                                @[@"TestCoreDataVC"],
                                  @"CoreDataTest",
                                nil];
    [self initSourceDataOpenState];
    [self setupTableview];

}

- (void)setupTableview {
    [self.modulesTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)leftBtnClick {
    NSLog(@"leftBtnClick");
    [self presentViewController:[[ZTabBarController alloc] init] animated:YES completion:^{
    }];
}

#pragma mark --TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSNumber *number = _sourceDataOpenState[section];
    BOOL state = [number boolValue];
    if (state) {
        NSString *moduleName = _modulesName[section];
        NSArray *moduleArr = [_moduleViewControllerDict objectForKey:moduleName];
        return moduleArr.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_modulesName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName = [NSString stringWithFormat:@"cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *moduleName = _modulesName[indexPath.section];
    NSArray *moduleArr = [_moduleViewControllerDict objectForKey:moduleName];
    NSString *title = moduleArr[indexPath.row];
    cell.textLabel.text = title;
    cell.textLabel.textColor = [UIColor grayColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *moduleName = _modulesName[indexPath.section];
    NSArray *moduleArr = [_moduleViewControllerDict objectForKey:moduleName];
    NSString *viewControllerName = moduleArr[indexPath.row];
    /*
     NSClassFromString 无需引入头文件
     1 弱化连接，因此并不会把没有的Framework也link到程序中。
     2 不需要使用import，因为类是动态加载的，只要存在就可以加载。
     */
    UIViewController *vc = [[NSClassFromString(viewControllerName) alloc] init];
    if([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabbarController = (UITabBarController *)vc;
        tabbarController.delegate = self;
    }
    [self.navigationController pushViewController:vc animated:YES];
//    
//    UIView *view = [[UIView alloc] init];
//    [view setCenter:<#(CGPoint)#>]
    
   NSString *daysStr = [ToolBox getDaysBetweenEndDate:@"2015-12-27 8:00:00" andStartDate:@"2015-12-23 22:00:00" withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSLog(@"%@", daysStr);

}


- (void)initSourceDataOpenState{
    _sourceDataOpenState = [[NSMutableArray alloc] init];
    for (int i = 0; i< [_modulesName count]; i++) {
        [_sourceDataOpenState addObject:[NSNumber numberWithBool:false]];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
//    view.backgroundColor = [UIColor whiteColor];
//    return view;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerFooterViewIdentify = @"headerFooter";
    TableHeaderView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerFooterViewIdentify];
    if (!headerFooterView) {
        headerFooterView = [[TableHeaderView alloc] initWithReuseIdentifier:headerFooterViewIdentify];
        headerFooterView.delegate = self;
        headerFooterView.contentView.backgroundColor = [UIColor whiteColor];
    }

    headerFooterView.sectionIndex = section;
    headerFooterView.sectionTitle = [NSString stringWithFormat:@"%@", _modulesName[section]];
    headerFooterView.isOpen = [_sourceDataOpenState[section] boolValue];
    headerFooterView.layer.cornerRadius = 10;
    return headerFooterView;
}

#pragma mark - TableHeaderViewDelegate
- (void)headerViewDidTaped:(TableHeaderView *)tableHeaderView sectionIndex:(NSInteger)sectionIndex
{
    if (_lastOpenedSection != lastOpenSection  &&  _lastOpenedSection != sectionIndex) {
        //说明 有未关闭section 需先关闭
        NSNumber *number = _sourceDataOpenState[_lastOpenedSection];
        if ([number boolValue]) {
            NSNumber *numberNew = [NSNumber numberWithBool:![number boolValue]];
            [_sourceDataOpenState replaceObjectAtIndex:_lastOpenedSection withObject:numberNew];
        }
    }
    
    NSNumber *number = _sourceDataOpenState[sectionIndex];
    NSNumber *numberNew = [NSNumber numberWithBool:![number boolValue]];
    [_sourceDataOpenState replaceObjectAtIndex:sectionIndex withObject:numberNew];
    _lastOpenedSection = sectionIndex;
    [self.modulesTable reloadData];
}


#pragma mark UITabBarControllerDelegate 
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromBottom;
//    [tabBarController.view.layer addAnimation:transition forKey:nil];

    [UIView  transitionWithView:tabBarController.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}
@end
