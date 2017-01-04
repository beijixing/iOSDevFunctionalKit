//
//  UIFactory.h
//  iOSDevTecKit
//
//  Created by horse on 2016/12/29.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIFactory : NSObject

/*
    创建UIView，给定frame
*/
+ (UIView *)createViewWith:(CGRect)frame;

/*
    创建UIView，给定frame 和背景色 bgcolor
 */
+ (UIView *)createViewWith:(CGRect)frame backgroundColor:(UIColor *)bgColor;


/*
    创建图片视图，给定frame 和图片名 imageName
 */
+ (UIImageView *)createImageViewWith:(CGRect)frame imageName:(NSString *)imageName;

/*
    创建Label， 给定frame、文字颜色textColor、初始化文字text
 */
+ (UILabel *)createLabelWith:(CGRect)frame text:(NSString *)text;

/*
    创建Label， 给定frame、文字颜色textColor、初始化文字text
 */
+ (UILabel *)createLabelWith:(CGRect)frame textColor:(UIColor *)color text:(NSString *)text;

/*
    创建Label， 给定frame、文字颜色textColor、背景色bgColor、初始化文字text
 */
+ (UILabel *)createLabelWith:(CGRect)frame textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor text:(NSString *)text;

/*
    创建Label， 给定frame、文字颜色textColor、背景色bgColor、对齐方式alignment、初始化文字text
 */
+ (UILabel *)createLabelWith:(CGRect)frame textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor textAlignment:(NSTextAlignment)alignment text:(NSString *)text;

/*
    创建Label， 给定frame、文字颜色textColor、背景色bgColor、对齐方式alignment、字体font、初始化文字text
*/
+ (UILabel *)createLabelWith:(CGRect)frame textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor textAlignment:(NSTextAlignment)alignment textFont:(UIFont *)font text:(NSString *)text;


/*
    创建button，给定frame、 回调函数selector、 回调函数的对象target、按钮标题颜色color、 按钮标题title
 */
+ (UIButton *)createButtonWith:(CGRect)frame selector:(SEL)selector target:(id)target titleColor:(UIColor*)color title:(NSString*)title;

/*
    创建button，给定frame、 回调函数selector、 回调函数的对象target、按钮标题颜色color、按钮的背景颜色bgColor、 按钮标题title
*/
+ (UIButton *)createButtonWith:(CGRect)frame selector:(SEL)selector target:(id)target titleColor:(UIColor*)color backgroudColor:(UIColor *)bgColor title:(NSString*)title;

/*
    创建button，给定frame、 回调函数selector、 回调函数的对象target、正常状态图片normalImage、点击状态的图片selectedImage
 */
+ (UIButton *)createButtonWith:(CGRect)frame selector:(SEL)selector target:(id)target normalImage:(UIImage*)normalImage selectedImage:(UIImage *)selectedImage;


/*
    创建button，给定frame、 回调函数selector、 回调函数的对象target、正常状态图片normalImage、点击状态的图片selectedImage、 禁用状态的图片disabledImage
 */
+ (UIButton *)createButtonWith:(CGRect)frame selector:(SEL)selector target:(id)target normalImage:(UIImage*)normalImage selectedImage:(UIImage *)selectedImage disabledImage:(UIImage *)disabledImage;

/*
    创建button，给定frame、 回调函数selector、 回调函数的对象target、正常状态图片normalImage、点击状态的图片selectedImage、 禁用状态的图片disabledImage、按钮标题title
 */
+ (UIButton *)createButtonWith:(CGRect)frame selector:(SEL)selector target:(id)target normalImage:(UIImage*)normalImage selectedImage:(UIImage *)selectedImage disabledImage:(UIImage *)disabledImage title:(NSString *)title;

/*
 创建TextField，给定frame、 边框类型borderStyle、 文本颜色textColor、 默认提示placeholder
 */
+ (UITextField *)createTextFieldWith:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)textColor placeholder:(NSString *)placeholder;

/*
 创建TextField，给定frame、 边框类型borderStyle、 文本颜色textColor、 字体textFont、代理delegate、 return按钮的类型returnType、 默认提示placeholder
 */
+ (UITextField *)createTextFieldWith:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)textColor textFont:(UIFont *)textFont delegate:(id<UITextFieldDelegate>)delegate returnType:(UIReturnKeyType)returnType placeholder:(NSString *)placeholder;
/*
    创建TextField，给定frame、 边框类型borderStyle、 文本颜色textColor、 字体textFont、代理delegate、 return按钮的类型returnType、 键盘类型keyboardType、 默认提示placeholder、 默认文字text
 */
+ (UITextField *)createTextFieldWith:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)textColor textFont:(UIFont *)textFont delegate:(id<UITextFieldDelegate>)delegate returnType:(UIReturnKeyType)returnType keyboardType:(UIKeyboardType)keyboardType placeholder:(NSString *)placeholder text:(NSString *)text;
@end
