//
//  AnnoteTextView.h
//  iOSDevTecKit
//
//  Created by horse on 2017/1/4.
//  Copyright © 2017年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, AnnoteViewType) {
    AnnoteViewTypeText,
    AnnoteViewTypeImage,
};

@interface AnnoteView : UIView
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) UIView *leftTopView;
@property(nonatomic, strong) UIView *rightTopView;
@property(nonatomic, strong) UIView *rightBottomView;
@property(nonatomic, strong) UIView *leftBottomView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic) AnnoteViewType viewType;
- (instancetype)initWithFrame:(CGRect)frame annoteViewType:(AnnoteViewType)type;
- (void)setCornerViewVisibleState:(BOOL)state;
@end
