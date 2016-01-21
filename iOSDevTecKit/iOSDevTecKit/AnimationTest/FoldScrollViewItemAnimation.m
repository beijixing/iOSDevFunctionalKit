//
//  HomeVCViewController.m
//  JinFu
//
//  Created by ybon on 15/12/16.
//  Copyright © 2015年 ybon. All rights reserved.
//

#import "FoldScrollViewItemAnimation.h"
#import "AnimationAction.h"

typedef void(^animComplete)(BOOL finished);
@interface FoldScrollViewItemAnimation ()
{
    UIScrollView *_bankScrollView;
    NSMutableArray *_scrollViewItemArr;
    NSMutableArray *_cardInfoArr;
    NSMutableArray *_adDataArr;
    NSMutableArray *_addedServiceArr;
    BOOL bShowScrollView;
    __block NSInteger _currentAnimationIndex;
}
@end

@implementation FoldScrollViewItemAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首 页";
    [self initScrollView];
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureAction:)];
    [self.bankTable addGestureRecognizer:pinchGesture];
    self.bankTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    typeof(self) __weak WeakSelf = self;
    [self setRightNavigationBarButtonItemWithImage:@"rightArrow" andAction:^{
        AnimationAction *animationAction = [[AnimationAction alloc] init];
//        WeakSelf.definesPresentationContext = YES;
        animationAction.view.backgroundColor = [UIColor colorWithRed:1.0f green:0 blue:0 alpha:0.5];
        /*
            模态视图关键部位
            animationAction.modalPresentationStyle = UIModalPresentationOverCurrentContext;
         */
        animationAction.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [WeakSelf presentViewController:animationAction animated:YES completion:^{
        }];
//        [WeakSelf.navigationController pushViewController:animationAction animated:YES];
    }];
}

/*
 UIViewController *vc=[[UIViewController alloc]init];
 vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
 [self presentViewController:vc animated:NO completion:^{
 vc.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
 }]
 */

- (void)viewWillAppear:(BOOL)animated {
    [self.bankTable reloadData];
}

- (void)initScrollView{
    _scrollViewItemArr = [[NSMutableArray alloc] init];
    bShowScrollView = YES;
    _bankScrollView = [[UIScrollView alloc] init];
//    _bankScrollView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped)];
    [_bankScrollView addGestureRecognizer:tapGesture];
    _bankScrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - 49 - 64);
    [self updateBankScrollViewData];
}

- (void)updateBankScrollViewData {
    CGFloat contentSizeHeight = (10 - 1)*60 + 183;
    _bankScrollView.contentSize = CGSizeMake(self.bankTable.frame.size.width, contentSizeHeight);
    for (int i = 0; i<10; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i*60, 320, 183)];
        view.tag = i;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 50)];
        label.text = [NSString stringWithFormat:@"第%d个view", i];
        [view addSubview:label];
        view.backgroundColor = [self randomColor];
        [_scrollViewItemArr addObject:view];
        [_bankScrollView addSubview:view];
    }
}


- (void)resetScrollItemFrame {
    int i = 0;
    for (UIView *view in _scrollViewItemArr) {
        [UIView animateWithDuration:0.1 delay:i*0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            if (view) {
                view.frame = CGRectMake(0, i*60, 320, 183);
            }
            
        } completion:^(BOOL finished) {
            if (i==8) {
                bShowScrollView = YES;
                NSLog(@"最后一个完成");
            }
            
        }];
        i++;
    }
    
    CGFloat contentSizeHeight = (10 - 1)*60 + 183;
    _bankScrollView.contentSize = CGSizeMake(self.bankTable.frame.size.width, contentSizeHeight);
}


- (UIColor*)randomColor{
    NSInteger red = random()%255;
    NSInteger green = random()%255;
    NSInteger blue = random()%255;
    UIColor *randColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    return randColor;
}


- (void)pinchGestureAction:(UIPinchGestureRecognizer *)gesture {
    if (gesture.scale < 0.5) {
        if (!bShowScrollView) {
            [self resetScrollItemFrame];
//            [self.bankTable reloadData];
        }
    }
}

- (void)scrollViewTapped {
    if (!bShowScrollView) {
        return;
    }
    int i = 0;
    for (NSInteger j = _scrollViewItemArr.count; j>0; j--) {
        UIView *view = [_scrollViewItemArr objectAtIndex:j-1];
        [UIView animateWithDuration:0.1 delay:i*0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            if (view) {
                CGRect oldFrame = view.frame;
                CGRect newFrame = CGRectMake(oldFrame.origin.x,oldFrame.origin.y+ (j-1)*123, oldFrame.size.width, oldFrame.size.height);
                view.frame = newFrame;
            }
            
        } completion:^(BOOL finished) {
                if (i==8) {
                    bShowScrollView = NO;
                    NSLog(@"最后一个完成");
                }
                
            }];
        i++;
    }
    
    _bankScrollView.contentSize = CGSizeMake(self.view.frame.size.width, _scrollViewItemArr.count * 183);
}

- (void)endScrollViewAction {
    bShowScrollView = NO;
    [self.bankTable reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 183;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (bShowScrollView) {
        return _bankScrollView.frame.size.height;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (bShowScrollView) {
        return _bankScrollView;
    }
    return NULL;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (bShowScrollView) {
        return 0;
    }else {
        return [_scrollViewItemArr count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"cellname";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.backgroundColor = [self randomColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end
