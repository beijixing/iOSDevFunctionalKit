//
//  UIView+CornerRaidus.h
//  zglTest
//
//  Created by 郑光龙 on 15/10/27.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface UIView (CornerRaidus)
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
@property (nonatomic, strong)IBInspectable UIColor *borderColor;
- (void)setLayerBoardColor:(UIColor *)boardColor andBoardWidth:(CGFloat)boardWidth andCornerRadius:(CGFloat)radius;

@end
