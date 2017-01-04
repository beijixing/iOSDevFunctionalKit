//
//  AnnoteTextView.m
//  iOSDevTecKit
//
//  Created by horse on 2017/1/4.
//  Copyright © 2017年 郑光龙. All rights reserved.
//

#import "AnnoteTextView.h"

@implementation AnnoteTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textView];
        [self addSubview:self.leftTopView];
        [self addSubview:self.rightTopView];
        [self addSubview:self.rightBottomView];
        [self addSubview:self.leftBottomView];
    }
    return self;
}

- (void)layoutSubviews {
    CGSize frameSize = self.frame.size;
    self.textView.frame = CGRectMake(30, 30, frameSize.width-60, frameSize.height-60);
    self.rightTopView.frame = CGRectMake(0, 0, 30, 30);
    self.leftTopView.frame = CGRectMake(frameSize.width-30, 0, 30, 30);
    self.rightBottomView.frame = CGRectMake(0, frameSize.height-30, 30, 30);
    self.leftBottomView.frame = CGRectMake(frameSize.width-30, frameSize.height-30, 30, 30);
}

- (UITextView *)textView {
    if (_textView) {
        return _textView;
    }
    _textView = [[UITextView alloc] init];
    _textView.textColor = [UIColor orangeColor];
    _textView.backgroundColor = [UIColor yellowColor];
    return _textView;
}

- (UIView *)leftTopView {
    if (_leftTopView) {
        return _leftTopView;
    }
    _leftTopView = [[UIView alloc] init];
    _leftTopView.backgroundColor = [UIColor greenColor];
    return _leftTopView;
}

- (UIView *)rightTopView {
    if (_rightTopView) {
        return _rightTopView;
    }
    _rightTopView = [[UIView alloc] init];
    _rightTopView.backgroundColor = [UIColor greenColor];
    return _rightTopView;
}

- (UIView *)rightBottomView {
    if (_rightBottomView) {
        return _rightBottomView;
    }
    _rightBottomView = [[UIView alloc] init];
    _rightBottomView.backgroundColor = [UIColor greenColor];
    return _rightBottomView;
}

- (UIView *)leftBottomView {
    if (_leftBottomView) {
        return _leftBottomView;
    }
    _leftBottomView = [[UIView alloc] init];
    _leftBottomView.backgroundColor = [UIColor greenColor];
    return _leftBottomView;
}

@end
