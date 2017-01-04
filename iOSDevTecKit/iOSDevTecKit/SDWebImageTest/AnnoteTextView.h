//
//  AnnoteTextView.h
//  iOSDevTecKit
//
//  Created by horse on 2017/1/4.
//  Copyright © 2017年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnoteTextView : UIView
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) UIView *leftTopView;
@property(nonatomic, strong) UIView *rightTopView;
@property(nonatomic, strong) UIView *rightBottomView;
@property(nonatomic, strong) UIView *leftBottomView;
@end
