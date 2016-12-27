//
//  ShimmerLabel.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/25.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "ShimmerLabel.h"

@interface ShimmerLabel ()
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UILabel *maskLabel;
@property(nonatomic, strong) CAGradientLayer *maskLayer;
@end

@implementation ShimmerLabel


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addSubview:self.contentLabel];
    [self addSubview:self.maskLabel];
    
    
    [self.maskLabel.layer addSublayer:self.maskLayer];
    self.maskLabel.layer.mask = self.maskLayer;
    
    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    basicAnim.fromValue =  [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-10, 0, 1)];
     basicAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.frame.size.width, 0, 1)];
    basicAnim.autoreverses = YES;
    basicAnim.duration = 2.0;
    basicAnim.repeatCount = CGFLOAT_MAX;
    [self.maskLayer addAnimation:basicAnim forKey:@"transform"];
}

- (void)layoutSubviews {
    self.contentLabel.frame = self.bounds;
    self.maskLabel.frame = self.bounds;
    self.maskLayer.frame = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height);
}

- (UILabel *)contentLabel {
    if (_contentLabel) {
        return _contentLabel;
    }
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:17.0];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.text = @"hello world";
    return _contentLabel;
}

- (UILabel *)maskLabel {
    if (_maskLabel) {
        return _maskLabel;
    }
    _maskLabel = [[UILabel alloc] init];
    _maskLabel.font = [UIFont systemFontOfSize:17.0];
    _maskLabel.textColor = [UIColor redColor];
    _maskLabel.text = @"hello world";
    return _maskLabel;
}

- (CAGradientLayer *)maskLayer {
    if (_maskLayer) {
        return _maskLayer;
    }
    _maskLayer = [[CAGradientLayer alloc] init];
    _maskLayer.backgroundColor = [UIColor redColor].CGColor;
    _maskLayer.startPoint = CGPointMake(0, 0.5);
    _maskLayer.endPoint = CGPointMake(1, 0.5);
    _maskLayer.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor blackColor].CGColor, (id)[UIColor redColor].CGColor, (id)[UIColor redColor].CGColor, (id)[UIColor redColor].CGColor, (id)[UIColor redColor].CGColor];
//     _maskLayer.locations = @[@(0.0), @(0.5 - w - sw), @(0.5 - w), @(0.5 + w), @(0.5 + w + sw), @(1)];
    return _maskLayer;
}

- (void)startShimming {
}
@end
