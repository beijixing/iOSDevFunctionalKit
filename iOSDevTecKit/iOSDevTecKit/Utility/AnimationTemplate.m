//
//  AnimationTemplate.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/23.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "AnimationTemplate.h"

@implementation AnimationTemplate
+ (void) transitionWithType:(NSString *) type Subtype:(NSString *) subtype ForView : (UIView *) view Duration:(float)duration
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = duration;
    
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

+ (void)transitionWithType:(NSString *)type Subtype:(NSString *)subtype ForView:(UIView *)view Property:(NSString *)property {
    //自定义动画行为
    CATransition *transion = [CATransition animation];
    transion.type = type;
    transion.subtype = subtype;
    view.layer.actions = @{property : transion}; //keypoint
}

+ (void)basicAnimationWithToValue:(id)value Duration:(float)duration RepeatCount:(int)cnt Autoreverses:(BOOL)reverses ForView:(UIView *)view {
    CABasicAnimation *baseAnimation = [CABasicAnimation animation];
    baseAnimation.toValue = value;
    baseAnimation.duration = duration;
    baseAnimation.autoreverses = reverses;
    //    baseAnimation.repeatDuration = 1.0;
    baseAnimation.repeatCount = cnt;
    [view.layer addAnimation:baseAnimation forKey:nil];
}

+ (void)basicAnimationWithToValue:(id)value Duration:(float)duration ForView:(UIView *)view {
    CABasicAnimation *baseAnimation = [CABasicAnimation animation];
    baseAnimation.toValue = value;
    baseAnimation.duration = duration;
    baseAnimation.autoreverses = NO;
    //    baseAnimation.repeatDuration = 1.0;
    baseAnimation.repeatCount = 0;
    [view.layer addAnimation:baseAnimation forKey:nil];
}
@end
