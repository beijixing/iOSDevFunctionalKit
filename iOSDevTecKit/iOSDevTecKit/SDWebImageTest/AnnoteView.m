//
//  AnnoteTextView.m
//  iOSDevTecKit
//
//  Created by horse on 2017/1/4.
//  Copyright © 2017年 郑光龙. All rights reserved.
//

#import "AnnoteView.h"
@interface AnnoteView()
@property(nonatomic) NSInteger touchCount;
@end

@implementation AnnoteView

- (instancetype)initWithFrame:(CGRect)frame annoteViewType:(AnnoteViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewType = type;
        self.touchCount = 0;
        if (self.viewType == AnnoteViewTypeText) {
            [self addSubview:self.textView];
        }else if(self.viewType == AnnoteViewTypeImage){
            [self addSubview:self.imageView];
        }
        [self addSubview:self.leftTopView];
        [self addSubview:self.rightTopView];
        [self addSubview:self.rightBottomView];
        [self addSubview:self.leftBottomView];
    }
    return self;
}

- (void)layoutSubviews {
    CGSize frameSize = self.frame.size;
    if (self.viewType == AnnoteViewTypeText) {
        self.textView.frame = CGRectMake(30, 30, frameSize.width-60, frameSize.height-60);
    }else if(self.viewType == AnnoteViewTypeImage) {
        self.imageView.frame = CGRectMake(30, 30, frameSize.width-60, frameSize.height-60);
    }
    
    self.leftTopView.frame = CGRectMake(0, 0, 30, 30);
    self.rightTopView.frame = CGRectMake(frameSize.width-30, 0, 30, 30);
    self.leftBottomView.frame = CGRectMake(0, frameSize.height-30, 30, 30);
    self.rightBottomView.frame = CGRectMake(frameSize.width-30, frameSize.height-30, 30, 30);
}

- (UITextView *)textView {
    if (_textView) {
        return _textView;
    }
    _textView = [[UITextView alloc] init];
    _textView.textColor = [UIColor orangeColor];
    _textView.backgroundColor = [UIColor clearColor];
    return _textView;
}

- (UIImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }
    _imageView = [[UIImageView alloc] init];
    return _imageView;
}

- (UIView *)leftTopView {
    if (_leftTopView) {
        return _leftTopView;
    }
    _leftTopView = [[UIView alloc] init];
//    _leftTopView.backgroundColor = [UIColor greenColor];
//    [_leftTopView.layer addAnimation:[self blinkAnimation] forKey:@"blinkAnim"];
    _leftTopView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"move"].CGImage);
    return _leftTopView;
}

- (UIView *)rightTopView {
    if (_rightTopView) {
        return _rightTopView;
    }
    _rightTopView = [[UIView alloc] init];
//    _rightTopView.backgroundColor = [UIColor greenColor];
//    [_rightTopView.layer addAnimation:[self blinkAnimation] forKey:@"blinkAnim"];
    _rightTopView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"expand"].CGImage);
    return _rightTopView;
}

- (UIView *)rightBottomView {
    if (_rightBottomView) {
        return _rightBottomView;
    }
    _rightBottomView = [[UIView alloc] init];
//    _rightBottomView.backgroundColor = [UIColor greenColor];
    _rightBottomView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"delete"].CGImage);
    return _rightBottomView;
}

- (UIView *)leftBottomView {
    if (_leftBottomView) {
        return _leftBottomView;
    }
    _leftBottomView = [[UIView alloc] init];
//    _leftBottomView.backgroundColor = [UIColor greenColor];
    if (self.viewType == AnnoteViewTypeText){
        _leftBottomView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"font"].CGImage);
    }else if(self.viewType == AnnoteViewTypeImage) {
        _leftBottomView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"rotateleft"].CGImage);
    }
    
    return _leftBottomView;
}

- (CABasicAnimation *)blinkAnimation {
    CABasicAnimation *blinkAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    blinkAnim.fromValue = [NSNumber numberWithFloat:1.0];
    blinkAnim.toValue = [NSNumber numberWithFloat:0.1];
    blinkAnim.duration = 1.0;
    blinkAnim.repeatCount = MAXFLOAT;
    return blinkAnim;
}

- (void)setCornerViewVisibleState:(BOOL)state {
    self.leftTopView.hidden = state;
    self.rightTopView.hidden = state;
    self.leftBottomView.hidden = state;
    self.rightBottomView.hidden = state;
}

- (void)imageViewRotate {
    self.touchCount++;
    float angle = (self.touchCount % 4) * M_PI_2;
    [UIView animateWithDuration:0.2 animations:^{
        self.imageView.transform = CGAffineTransformMakeRotation(-angle);
    }];
}

@end
