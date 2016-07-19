//
//  TapGestureLabel.m
//  WoJK
//
//  Created by Megatron on 16/5/17.
//  Copyright © 2016年 zhilong. All rights reserved.
//

#import "TapGestureLabel.h"

@implementation TapGestureLabel
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont fontWithName:@"Arial" size:14.0];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapped:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)actionTapped:(UITapGestureRecognizer *)gesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(labelTapped:)]) {
        [self.delegate labelTapped:self];
    }
}

@end
