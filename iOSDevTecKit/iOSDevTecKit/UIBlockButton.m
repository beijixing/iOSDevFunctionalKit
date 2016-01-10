//
//  UIBlockButton.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/3.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "UIBlockButton.h"

@implementation UIBlockButton

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonClick:(id)button {
    _action(self);
}


@end
