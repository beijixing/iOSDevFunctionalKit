//
//  CustomTestView2.m
//  AutoLayoutAndSizeClassTest
//
//  Created by Megatron on 16/7/14.
//  Copyright © 2016年 zgl. All rights reserved.
//

#import "LayerContentsImageView.h"

@implementation LayerContentsImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CALayer *subLayer = [[CALayer alloc] init];
        subLayer.backgroundColor = [[UIColor greenColor] CGColor];
//        subLayer.contents = (id)[[UIImage imageNamed:@"180"] CGImage];
        [self.layer addSublayer:subLayer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        UIImage *testImage = [UIImage imageNamed:@"a.jpg"];
//        self.layer.contentsRect = CGRectMake(0, 0, 2, 2);
        self.layer.contents = (__bridge id)[testImage CGImage];
        self.layer.contentsGravity = kCAGravityResizeAspect;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        self.layer.masksToBounds = NO;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
