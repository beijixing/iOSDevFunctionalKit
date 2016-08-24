//
//  ReflectionView.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/7/27.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "ReflectionView.h"

@implementation ReflectionView

+(Class)layerClass {
    return [CAReplicatorLayer class];
}

- (void)setUp {
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
    layer.instanceCount = 2;
    //move reflection instance below original and flip vertically
    CATransform3D transform = CATransform3DIdentity;
    CGFloat verticalOffset = self.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    layer.instanceTransform = transform;
    //reduce alpha of reflection layer
    layer.instanceAlphaOffset = -0.6;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [self setUp];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
