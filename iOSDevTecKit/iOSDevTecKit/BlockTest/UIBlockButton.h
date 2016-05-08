//
//  UIBlockButton.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/3.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonAction)(UIButton *);

@interface UIBlockButton : UIButton
@property(nonatomic, copy)ButtonAction action;
@end
