//
//  ScrollMessageView.h
//  WoJK
//
//  Created by Megatron on 16/5/16.
//  Copyright © 2016年 zhilong. All rights reserved.
//

/*
    横条单行滚动视图，用来显示广告或公告信息
*/
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
