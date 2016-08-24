//
//  AnimationTemplate.h
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/23.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationTemplate : NSObject
/**
 *  在给定的View上执行一个动画，动画的类型由 type 和 subtype 确定。
 *
 *  @param type     动画类型
 *  @param subtype  动画子类型
 *  @param view     执行动画的视图
 *  @param duration 动画执行时间
    type 类型有：kCATransitionFade
                kCATransitionPush
                kCATransitionReveal
                kCATransitionMoveIn
 以上是系统给定的几个动画类型，除此之外还有下面几个字符串定义的动画
                @"cube" 立方体旋转效果
                @"suckEffect" 吸收效果
                @"oglFlip" 翻转效果
                @"rippleEffect" 睡眠波纹效果
                @"pageUnCurl" 页面卷曲效果
    subtype 类型有：kCATransitionFromLeft
                    kCATransitionFromBottom
                    kCATransitionFromRight
                    kCATransitionFromTop
 */
+ (void) transitionWithType:(NSString *) type Subtype:(NSString *) subtype ForView : (UIView *) view Duration:(float)duration;

/**
 *  为视图的某一个可动画属性添加自定义动画行为
 *
 *  @param type     动画类型
 *  @param subtype  动画子类型
 *  @param view     执行动画的视图
 *  @param property 要做动画的视图属性
 */
+ (void)transitionWithType:(NSString *)type Subtype:(NSString *)subtype ForView:(UIView *)view Property:(NSString *)property;


+ (void)basicAnimationWithToValue:(id)value Duration:(float)duration RepeatCount:(int)cnt Autoreverses:(BOOL)reverses ForView:(UIView *)view;
+ (void)basicAnimationWithToValue:(id)value Duration:(float)duration ForView:(UIView *)view;

@end
