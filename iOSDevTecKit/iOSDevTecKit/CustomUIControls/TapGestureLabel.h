//
//  TapGestureLabel.h
//  WoJK
//
//  Created by Megatron on 16/5/17.
//  Copyright © 2016年 zhilong. All rights reserved.
//

/*
    添加了点击事件的label
 */
#import <UIKit/UIKit.h>

@class TapGestureLabel;
@protocol TapGestureLabelDelegate <NSObject>

- (void)labelTapped:(TapGestureLabel *)label;

@end

@interface TapGestureLabel : UILabel
@property(nonatomic, assign) id<TapGestureLabelDelegate> delegate;
@end
