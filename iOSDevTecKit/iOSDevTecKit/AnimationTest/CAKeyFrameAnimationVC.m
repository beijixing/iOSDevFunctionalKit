//
//  CAKeyFrameAnimationVC.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/7/29.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "CAKeyFrameAnimationVC.h"

@interface CAKeyFrameAnimationVC ()
@property (strong, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) CALayer *colorLayer;
@property (strong, nonatomic) IBOutlet UIView *animationView;
@end

@implementation CAKeyFrameAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.colorLayer = [CALayer layer];
    self.colorLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.colorLayer.frame = self.colorView.bounds;
    [self.colorView.layer addSublayer:self.colorLayer];
    
    [self createKeyFrameAnimationWithPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)keyFrameAnimationAction:(id)sender {
    CAKeyframeAnimation *keyFrameAniamtion = [CAKeyframeAnimation animation];
    keyFrameAniamtion.keyPath = @"backgroundColor";
    keyFrameAniamtion.duration = 5.0;
    keyFrameAniamtion.values = @[
                                  (__bridge id)[UIColor greenColor].CGColor,
                                  (__bridge id)[UIColor yellowColor].CGColor,
                                  (__bridge id)[UIColor blackColor].CGColor,
                                  (__bridge id)[UIColor redColor].CGColor,
                                  (__bridge id)[UIColor purpleColor].CGColor,
                                  (__bridge id)[UIColor orangeColor].CGColor
                                 ];
    [self.colorLayer addAnimation:keyFrameAniamtion forKey:nil];
}


- (void)createKeyFrameAnimationWithPath {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, 50)];
    [path addCurveToPoint:CGPointMake(300, 50) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 100)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 3.0;
    [self.animationView.layer addSublayer:shapeLayer];
    
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 50);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"alien-spaceship.jpg"].CGImage;
    [self.animationView.layer addSublayer:shipLayer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    [shipLayer addAnimation:animation forKey:nil];
}


/**
 *  虚拟属性
 *
 *  用transform.rotation而不是transform做动画的好处如下：
 
 我们可以不通过关键帧一步旋转多于180度的动画。
 可以用相对值而不是绝对值旋转（设置byValue而不是toValue）。
 可以不用创建CATransform3D，而是使用一个简单的数值来指定角度。
 不会和transform.position或者transform.scale冲突（同样是使用关键路径来做独立的动画属性）。
 transform.rotation属性有一个奇怪的问题是它其实并不存在。这是因为CATransform3D并不是一个对象，它实际上是一个结构体，也没有符合KVC相关属性，transform.rotation实际上是一个CALayer用于处理动画变换的虚拟属性。
 
 你不可以直接设置transform.rotation或者transform.scale，他们不能被直接使用。当你对他们做动画时，Core Animation自动地根据通过CAValueFunction来计算的值来更新transform属性。
 
 CAValueFunction用于把我们赋给虚拟的transform.rotation简单浮点值转换成真正的用于摆放图层的CATransform3D矩阵值。你可以通过设置CAPropertyAnimation的valueFunction属性来改变，于是你设置的函数将会覆盖默认的函数
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
