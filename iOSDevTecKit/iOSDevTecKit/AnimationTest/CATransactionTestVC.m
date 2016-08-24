//
//  CATransactionTestVC.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/7/28.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "CATransactionTestVC.h"

@interface CATransactionTestVC ()
@property (strong, nonatomic) IBOutlet UIView *testView;
@property (strong, nonatomic) CALayer *colorLayer;
@property (nonatomic)  int flag;
@end

@implementation CATransactionTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = self.testView.bounds;
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.testView.layer addSublayer:self.colorLayer];
    [self customAttAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeViewColor:(UIButton *)sender {
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
}

- (void)customAttAnimation {
    //自定义动画行为
    CATransition *transion = [CATransition animation];
    transion.type = kCATransitionPush;
    transion.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor" : transion}; //keypoint
}

- (void)caTransactionAnimation {
    [CATransaction begin];//开始一个新的事务,通过改变CALayer属性，产生动画
    [CATransaction setAnimationDuration:3.0];
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    [CATransaction commit];
}

- (void)uiviewAnimation {//uiview 通过 actionForLayer:forKey:返回nil 禁用了属性变化时的动画，只有在 animation block中 actionForLayer:forKey: 返回值才不为空，才能在改变属性的时候产生动画效果
    if (self.flag == 0) {
        self.flag = 1;
    }else {
        self.flag = 0;
    }

    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        [UIView animateWithDuration:3.0 animations:^{
            self.testView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
            self.testView.center = CGPointMake(arc4random()%(int)self.view.frame.size.width, arc4random()%(int)self.view.frame.size.height);
            self.testView.transform = CGAffineTransformMakeRotation(M_PI*self.flag);
        }];
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
