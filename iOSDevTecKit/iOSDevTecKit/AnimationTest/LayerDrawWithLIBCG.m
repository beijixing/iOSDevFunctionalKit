//
//  CustomTestView.m
//  AutoLayoutAndSizeClassTest
//
//  Created by Megatron on 16/7/13.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import "LayerDrawWithLIBCG.h"
CGFloat arc(CGFloat angle){
    return angle * (M_PI / 180);
}
@implementation LayerDrawWithLIBCG

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.shadowOpacity =  1.0;
        self.layer.shadowColor = [[UIColor redColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(-1, -2);
        self.layer.shadowRadius = 2;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
   // <颜色>
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);//边框颜色
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);//填充颜色
    //<画线>
    CGContextSetLineWidth(context, 2.0);//横线宽度
    //<横线头尾部样式>
    CGContextSetLineCap(context, kCGLineCapRound);//样式
    
    //设置起始位置
    CGContextMoveToPoint(context, 10, 10);
    //划线
    CGContextAddLineToPoint(context, 100, 100);
    
    //画折线
    CGPoint apoints[3];
    apoints[0] = CGPointMake(10, 10);
    apoints[1] = CGPointMake(10, 100);
    apoints[2] = CGPointMake(100, 90);
//    CGContextAddLines(context, apoints, 3);
    //画矩形
//    CGContextAddRect(context, CGRectMake(10, 10, 120, 100));
    
    
    //画三角形
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, 100, 100);
//    CGContextAddLineToPoint(context, 150, 100);
//    CGContextAddLineToPoint(context, 0, 0);
    
    
    //画圆
//    CGContextAddEllipseInRect(context, CGRectMake(100, 0, 90, 90));
    
    //画圆弧
    CGContextAddArc(context, 200, 50, 20, arc(0), arc(350), 0);

  
    
//    CGContextStrokePath(context);
//    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
}
@end
