//
//  CoreAnimationTestVC.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/12.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "CoreAnimationTestVC.h"

@interface CoreAnimationTestVC ()
{
}
@end

@implementation CoreAnimationTestVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self uiviewAnimation_1];
    [self uiviewAnimationWithBlock];
    
    [self animationOfBasicAnimation];
    
    [self animationOfKeyFrameAnimation];
    
    [self animationOfCAKeyframeAnimationPath];
    
    [self animationOfTransitionAnimation];
}

- (void)uiviewAnimation_1{
    UIView *redView = [ToolBox createViewWithFrame:CGRectMake(0, 0, 100, 100) andBackgroundColor:[UIColor redColor]];
    [self.view addSubview:redView];
    
    //开始动画
    
    [UIView beginAnimations:@"test" context:nil];
    [UIView setAnimationDuration:3.0];
    
    //动画要改变的属性在此处设置
    
    redView.backgroundColor = [UIColor greenColor];
    redView.frame = CGRectMake(220, 300, 50, 50);
    redView.alpha = 0.5;
    
    //提交动画，即执行动画
    [UIView commitAnimations];
    
}

- (void)uiviewAnimationWithBlock {
    
    UIView *redView = [ToolBox createViewWithFrame:CGRectMake(220, 0, 100, 100) andBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:redView];
    
    [UIView animateWithDuration:5 delay:1 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
        
        redView.backgroundColor = [UIColor cyanColor];
        redView.frame = CGRectMake(0, 200, 50, 50);
        redView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        NSLog(@"UIview Animation completion");
    }];
}

/*
 CAAnimation是所有动画类的父亲，但是它不能直接使用，应该使用其子类。
 常见的子类有：
 
 
 CAMediaTiming(一个协议不能直接使用)
 CAAnimation:
 CAPropertyAnimation:（不能直接使用，使用其子类）
 CABasicAnimation（可以）
 CAKeyframeAnimation（可以）
 CATransition（可以）
 CAAnimationGroup（可以）
 */
- (void)animationOfBasicAnimation {
    CABasicAnimation *baseAnimation = [CABasicAnimation animation];
    baseAnimation.toValue =  (id)[UIColor blueColor].CGColor;
    baseAnimation.duration = 2.0;
    baseAnimation.autoreverses = YES;
//    baseAnimation.repeatDuration = 1.0;
    baseAnimation.repeatCount = 5;
    
    UIView *animationView = [ToolBox createViewWithFrame:CGRectMake(120, 120, 80, 80) andBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:animationView];
    
    [animationView.layer addAnimation:baseAnimation forKey:@"backgroundColor"];
}

- (void)animationOfKeyFrameAnimation {
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.values = @[
                                 (id)[UIColor redColor].CGColor,
                                 (id)[UIColor blueColor].CGColor,
                                 (id)[UIColor yellowColor].CGColor,
                                 (id)[UIColor blackColor].CGColor,
                                 ];
    keyFrameAnimation.duration = 4;
    keyFrameAnimation.autoreverses = YES;
    
    UIView *animationView = [ToolBox createViewWithFrame:CGRectMake(120, 300, 80, 80) andBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:animationView];
 
    [animationView.layer addAnimation:keyFrameAnimation forKey:@"backgroundColor"];
}

//使用路径制作动画
-(void)animationOfCAKeyframeAnimationPath{
    //初始化一个View，用来显示动画
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    
    CAKeyframeAnimation *ani=[CAKeyframeAnimation animation];
    //初始化路径
    CGMutablePathRef aPath=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(aPath, nil, 20, 20);
    CGPathAddCurveToPoint(aPath, nil,
                          160, 30,//控制点
                          220, 220,//控制点
                          240, 380);//控制点
    
    ani.path=aPath;
    ani.duration=10;
    
    //设置为渐出
    ani.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //自动旋转方向
    ani.rotationMode=@"auto";
    ani.autoreverses = YES;
    ani.repeatCount = 2;
    
    [redView.layer addAnimation:ani forKey:@"position"];
}


//转场动画
- (void)animationOfTransitionAnimation {
    CATransition *transitionAnim = [CATransition animation];
    transitionAnim.type = kCATransitionPush;
    transitionAnim.subtype = kCATransitionFromRight;
    transitionAnim.duration = 1;
//    transitionAnim.timingFunction = UIViewAnimationCurveEaseInOut;
    
    UIView *animationView = [ToolBox createViewWithFrame:CGRectMake(160, 400, 100, 100) andBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:animationView];
    
    [animationView.layer addAnimation:transitionAnim forKey:nil];
}

@end
