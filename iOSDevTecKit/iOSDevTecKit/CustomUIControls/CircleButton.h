//
//  CircleButton.h
//  HiSchool
//
//  Created by ybon on 16/3/8.
//  Copyright © 2016年 ybon. All rights reserved.
//
/**
 *  UIImageView 下面添加一个Label，布局采用 frame 和 Masonry 结合的方式。
 可以设置控件的点击事件，使用block传递。
 *
 */
#import <UIKit/UIKit.h>
typedef void(^CircleButtonClick)(NSInteger tag, NSString *title);

@interface CircleButton : UIView
@property (nonatomic, copy)CircleButtonClick btnClickBlock;
- (void)addButtonImage:(UIImage *)image andSelectedImage:(UIImage *)selectedImage;
- (void)setupTitileLabelFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)txt;
;
- (void)addButtonImageWithURL:(NSURL *)imageUrl selectedImageWithUrl:(NSURL *)selectedImageUrl placeHolder:(NSString *)placeHolder;
@end
