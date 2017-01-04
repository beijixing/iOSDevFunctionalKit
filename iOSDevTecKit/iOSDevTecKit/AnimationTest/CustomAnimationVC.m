//
//  CustomAnimationVC.m
//  iOSDevTecKit
//
//  Created by horse on 2016/12/30.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "CustomAnimationVC.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface CustomAnimationVC ()<CAAnimationDelegate>
@property(nonatomic, strong) UIView *animationView;
@property(nonatomic, strong) NSMutableArray *selectorNameArr;
@property(nonatomic) NSInteger index;
@end

@implementation CustomAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 0;
    
    [self.selectorNameArr addObject:@"boomAnimation"];
    [self.selectorNameArr addObject:@"spreadAnimation"];
    [self.selectorNameArr addObject:@"pointSpreadAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)animationView {
    if (_animationView) {
        return _animationView;
    }
    _animationView = [[UIView alloc] initWithFrame:self.view.bounds];
    _animationView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_animationView];
    [self.view insertSubview:_animationView atIndex:0];
    return _animationView;
}

- (NSMutableArray *)selectorNameArr {
    if (_selectorNameArr) {
        return _selectorNameArr;
    }
    _selectorNameArr = [[NSMutableArray alloc] init];
    return _selectorNameArr;
}


- (IBAction)animationAction:(id)sender {
    self.index++;
    if (self.index >= self.selectorNameArr.count) {
        self.index = 0;
    }
    
    NSString *selectorName = self.selectorNameArr[self.index];
    SEL methodSelector = NSSelectorFromString(selectorName);
     ((void (*)(id,SEL))objc_msgSend)(self,methodSelector);
    
}

#pragma mark Custom Animation
- (void)boomAnimation {
    self.animationView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);

    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:1/0.4 options:0 animations:^{
        self.animationView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)spreadAnimation {
    CGRect rect0 = CGRectMake(MainScreenWidth, 0, 2, MainScreenHeight);
    CGRect rect1 = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight);
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRect:rect0];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRect:rect1];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    self.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    
    animation.duration = 0.5;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    [maskLayer addAnimation:animation forKey:@"NextPath"];
}

- (void)pointSpreadAnimation {
    CGRect rect = CGRectMake(self.view.center.x, self.view.center.y, 2, 2);
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:sqrt(MainScreenHeight * MainScreenHeight + MainScreenWidth * MainScreenWidth) startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    self.animationView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"pointSpread"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
   
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
