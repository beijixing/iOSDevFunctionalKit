//
//  ScrollMessageView.h
//  WoJK
//
//  Created by Megatron on 16/5/16.
//  Copyright © 2016年 zhilong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScrollMessageView;
@protocol ScrollMessageViewDelegate <NSObject>

- (void)scrollMessageView:(ScrollMessageView*)messageView clicked:(BOOL)click;

@end

@interface ScrollMessageView : UIView
@property(nonatomic, copy) NSString *messageTypeName;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, assign) id <ScrollMessageViewDelegate> delegate;
- (void)startTimer;
@end
