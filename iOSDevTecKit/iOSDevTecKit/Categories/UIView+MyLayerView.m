//
//  UIView+MyLayerView.m
//  zglTest
//
//  Created by 郑光龙 on 15/10/27.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "UIView+MyLayerView.h"

@implementation UIView (MyLayerView)

- (void)setMyViewLayerBoardColor:(UIColor *)boardColor AndBoardWidth:(CGFloat)boardWidth AndCornerRadius:(CGFloat)radius
{
    self.layer.borderColor = [boardColor CGColor];
    self.layer.borderWidth = boardWidth;
    self.layer.cornerRadius = radius;
}

@end
