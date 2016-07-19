//
//  UIView+CornerRaidus.m
//  zglTest
//
//  Created by 郑光龙 on 15/10/27.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "UIView+CornerRaidus.h"
#import <objc/runtime.h>

@implementation UIView (CornerRaidus)
- (CGFloat)cornerRadius
{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}


- (CGFloat)borderWidth
{
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

- (UIColor *)borderColor
{
    return objc_getAssociatedObject(self, @selector(borderColor));
}
- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setLayerBoardColor:(UIColor *)boardColor andBoardWidth:(CGFloat)boardWidth andCornerRadius:(CGFloat)radius
{
    self.layer.borderColor = [boardColor CGColor];
    self.layer.borderWidth = boardWidth;
    self.layer.cornerRadius = radius;
}


//- (void)circleTopCorner:(UITableViewCell *)cell {
//    CGRect bounds = CGRectMake(0, 0,  self.billDetailGroupTable.frame.size.width, cell.frame.size.height);
//    UIBezierPath *maskPath=  [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer=[[CAShapeLayer alloc] init];
//    maskLayer.frame=cell.layer.bounds;
//    maskLayer.path=maskPath.CGPath;
//    cell.layer.mask=maskLayer;
//    cell.layer.masksToBounds=YES;
//}
//
//
//- (void)circleBottomCorner:(UITableViewCell *)cell {
//    CGRect bounds = CGRectMake(0, 0,  self.billDetailGroupTable.frame.size.width, cell.frame.size.height);
//    UIBezierPath *maskPath=  [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer=[[CAShapeLayer alloc] init];
//    maskLayer.frame=cell.layer.bounds;
//    maskLayer.path=maskPath.CGPath;
//    cell.layer.mask=maskLayer;
//    cell.layer.masksToBounds=YES;
//}

@end
