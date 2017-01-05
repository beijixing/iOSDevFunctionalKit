//
//  CABasicAnimationTestVC.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/7/28.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

/*
 animationWithKeyPath的值：
 
 　 transform.scale = 比例轉換
 
 transform.scale.x = 闊的比例轉換
 
 transform.scale.y = 高的比例轉換
 
 transform.rotation.z = 平面圖的旋轉
 
 opacity = 透明度
 
 margin
 
 zPosition
 
 backgroundColor    背景颜色
 
 cornerRadius    圆角
 
 borderWidth
 
 bounds
 
 contents
 
 contentsRect
 
 cornerRadius
 
 frame
 
 hidden
 
 mask
 
 masksToBounds
 
 opacity
 
 position
 
 shadowColor
 
 shadowOffset
 
 shadowOpacity
 
 shadowRadius
 
 */
#import "CABasicAnimationTestVC.h"

@interface CABasicAnimationTestVC ()
@property (nonatomic, strong) CALayer *colorLayer;
@end

@implementation CABasicAnimationTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}


- (IBAction)changeColor:(UIButton *)sender {
    int a = 1 ,b = 2;
    
    NSLog(@"%d", a?:b);
    
    [self cabasicAnimationTest2];
    [self distinguishViewAnimation];
    

    NSArray *testArray = [NSArray arrayWithObjects:@"2.0", @"2.3", @"3.0", @"4.0", nil];

    NSNumber *sum = [testArray valueForKeyPath:@"@sum.floatValue"];
    NSNumber *avg = [testArray valueForKeyPath:@"@avg.floatValue"];
   // NSNumber *avg = [testArray valueForKeyPath:@"@max.floatValue"];
    //NSNumber *avg = [testArray valueForKeyPath:@"@min.floatValue"];
    NSLog(@"sum=%@, avg=%@", sum, avg);
}

/**
*  由于没有设置layer 的属性值，当动画执行完毕之后，layer的呈现层移除，看到的还是layer原来的属性值定义的外观。
*/
- (void)cabasicAnimationTest1 {
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //create a basic animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
}

/**
 *在动画执行之前设置相应的属性值，这样动画执行结束后就是最终的属性值定义的外观，设置的时候需要注意当前图层是否正在执行其他动画如果是的话 fromValue的值应取动画执行过程中的值，即presentationLayer的属性值。
 */
- (void)cabasicAnimationTest2 {
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //create a basic animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    animation.delegate = self;//设置动画代理
    //apply animation to layer
    [self applyBasicAnimation:animation toLayer:self.colorLayer];
}

- (void)applyBasicAnimation:(CABasicAnimation *)animation toLayer:(CALayer*)layer {
    animation.fromValue = [layer.presentationLayer ?:layer  valueForKeyPath:animation.keyPath];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [layer setValue:animation.toValue forKeyPath:animation.keyPath];
    [CATransaction commit];
    [layer addAnimation:animation forKey:animation.keyPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  动画结束代理方法
 *
 *  @return
 */
-(void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"动画代理");
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
//    self.colorLayer.backgroundColor = (__bridge CGColorRef) anim.toValue;
//
    [CATransaction commit];
    
    UIView *view = [anim valueForKey:@"distinguishView"]; //识别动画结束回调作用的是哪个UIView视图
    if (view) {
        NSLog(@"view.pos(%f, %f)", view.frame.origin.x, view.frame.origin.y);
        NSLog(@"view.positon(%f,%f)", view.layer.position.x, view.layer.position.y);
    }
}


/**当有多个UIView同时作动画时，如何区分每个view的动画结束事件
 *  像所有的NSObject子类一样，CAAnimation实现了KVC（键-值-编码）协议，于是你可以用-setValue:forKey:和-valueForKey:方法来存取属性。但是CAAnimation有一个不同的性能：它更像一个NSDictionary，可以让你随意设置键值对，即使和你使用的动画类所声明的属性并不匹配。
 */

- (void)distinguishViewAnimation {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
    animation.keyPath = @"position";
    animation.delegate = self;
    [animation setValue:view forKey:@"distinguishView"];
    
    [self applyBasicAnimation:animation toLayer:view.layer];
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
