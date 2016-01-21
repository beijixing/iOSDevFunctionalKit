//
//  ModalTestVC.m
//  iOSDevTecKit
//
//  Created by ybon on 16/1/21.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "ModalTestVC.h"
#define DURATION 0.2
@interface ModalTestVC ()
{
    
}
@end

@implementation ModalTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [ToolBox createButtonWithFrame:CGRectMake(100, 100, 100, 40) titleColor:[UIColor redColor] selector:@selector(buttonClick:) target:self buttonTitle:@"弹出视图"];
    [self.view addSubview:button];
    button.tag = 0;
    
    UIButton *button1 = [ToolBox createButtonWithFrame:CGRectMake(100, 200, 100, 40) titleColor:[UIColor redColor] selector:@selector(buttonClick:) target:self buttonTitle:@"AlerController"];
    [self.view addSubview:button1];
     button1.tag = 1;
    
    UIButton *button2 = [ToolBox createButtonWithFrame:CGRectMake(100, 300, 100, 40) titleColor:[UIColor redColor] selector:@selector(buttonClick:) target:self buttonTitle:@"ActionSheetController"];
    [self.view addSubview:button2];
     button2.tag = 2;
}

- (void)buttonClick:(UIButton *)sender {
    
    NSInteger btnTag = sender.tag;
    if (btnTag == 0) {
        [self modalViewTest1];
    }else if (btnTag == 1) {
        [self addAlertView];
    }else if (btnTag == 2) {
        
    }
}

- (void)addAlertView {
    UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:@"测试" message:@"请求失败滚蛋" preferredStyle:UIAlertControllerStyleActionSheet];
    
    typeof(self) __weak WeakSelf = self;
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIPreviewActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"addAlertView");
    }];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:^{

    }];
}

- (void)modalViewTest1{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
//    view.backgroundColor = [UIColor greenColor];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, MainScreenHeight-200, 100, 100)];
    label.text = @"测试1";
    [view addSubview:label];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [view addGestureRecognizer:tapGesture];
    [self.view addSubview:view];
    [self transitionWithType:kCATransitionMoveIn WithSubtype:kCATransitionFromTop ForView: view];
}


- (void)tapGesture:(UITapGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect oldFrame = view.frame;
        view.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y + MainScreenHeight, oldFrame.size.width, oldFrame.size.height);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}


- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
