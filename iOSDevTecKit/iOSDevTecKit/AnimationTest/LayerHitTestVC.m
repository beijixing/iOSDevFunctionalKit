//
//  LayerHitTestVC.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/7/28.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "LayerHitTestVC.h"

@interface LayerHitTestVC ()
@property(nonatomic, strong) CALayer *colorLayer;
@end

@implementation LayerHitTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}


/**
    模型图层和呈现图层的hittest 效果有所不同：这里的模型图层是self.colorLayer,呈现图层是self.colorLayer.presentationLayer 。当对self.colorLayer 使用hittest方法检测是否被点击时，只能在动画结束的时候检测到用户的点击事件。而使用self.colorLayer.presentationLayer 的hittest 方法可以在动画执行中响应用户点击事件。
    当设置了图层的位置属性后，模型图层的实际位置已经在新位置上了， 如果没有使用移动动画，呈现图层也已经在新位置上。如果使用动画，呈现图层会以动画的形式移动到新位置上。

 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    }else{
        [CATransaction begin];
        [CATransaction setAnimationDuration:3.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
