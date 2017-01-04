//
//  UIFactory.m
//  iOSDevTecKit
//
//  Created by horse on 2016/12/29.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

#pragma mark View
+(UIView *)createViewWith:(CGRect)frame {
    return [self createViewWith:frame backgroundColor:nil];
}

+ (UIView *)createViewWith:(CGRect)frame backgroundColor:(UIColor *)bgColor {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = bgColor ? bgColor : [UIColor whiteColor];
    return view;
}


#pragma mark ImageView
+ (UIImageView *)createImageViewWith:(CGRect)frame imageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

#pragma mark Label
+ (UILabel *)createLabelWith:(CGRect)frame text:(NSString *)text {
    return [self createLabelWith:frame textColor:nil text:text];
}

+ (UILabel *)createLabelWith:(CGRect)frame textColor:(UIColor *)color text:(NSString *)text {
    return [self createLabelWith:frame textColor:color backgroundColor:nil text:text];
}
+ (UILabel *)createLabelWith:(CGRect)frame textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor text:(NSString *)text {
    return [self createLabelWith:frame textColor:color backgroundColor:bgColor textAlignment:NSTextAlignmentLeft text:text];
}
+ (UILabel *)createLabelWith:(CGRect)frame textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor textAlignment:(NSTextAlignment)alignment text:(NSString *)text {
    return [self createLabelWith:frame textColor:color backgroundColor:bgColor textAlignment:alignment textFont:nil text:text];
}

+ (UILabel *)createLabelWith:(CGRect)frame textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor textAlignment:(NSTextAlignment)alignment textFont:(UIFont *)font text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = color;
    label.backgroundColor = bgColor;
    label.textAlignment = alignment;
    label.font = font;
    label.text = text;
    return label;
}

#pragma mark Button

+ (UIButton *)createButtonWith:(CGRect)frame selector:(SEL)selector target:(id)target titleColor:(UIColor*)color title:(NSString*)title {
    return [self createButtonWith:frame selector:selector target:target titleColor:color backgroudColor:nil title:title];
}

+ (UIButton *)createButtonWith:(CGRect)frame selector:(SEL)selector target:(id)target titleColor:(UIColor*)color backgroudColor:(UIColor *)bgColor title:(NSString*)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.backgroundColor = bgColor;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)createButtonWith:(CGRect)frame selector:(SEL)selector target:(id)target normalImage:(UIImage*)normalImage selectedImage:(UIImage *)selectedImage {
    return [self createButtonWith:frame selector:selector target:target normalImage:normalImage selectedImage:selectedImage disabledImage:nil];
}

+ (UIButton *)createButtonWith:(CGRect)frame selector:(SEL)selector target:(id)target normalImage:(UIImage*)normalImage selectedImage:(UIImage *)selectedImage disabledImage:(UIImage *)disabledImage {
    return [self createButtonWith:frame selector:selector target:target normalImage:normalImage selectedImage:selectedImage disabledImage:disabledImage title:nil];
}

+ (UIButton *)createButtonWith:(CGRect)frame selector:(SEL)selector target:(id)target normalImage:(UIImage*)normalImage selectedImage:(UIImage *)selectedImage disabledImage:(UIImage *)disabledImage title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button setImage:disabledImage forState:UIControlStateDisabled];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

#pragma mark UITextField 
+ (UITextField *)createTextFieldWith:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)textColor placeholder:(NSString *)placeholder {
    return [self createTextFieldWith:frame borderStyle:borderStyle textColor:textColor textFont:nil delegate:nil returnType:UIReturnKeyDefault placeholder:placeholder];
}

+ (UITextField *)createTextFieldWith:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)textColor textFont:(UIFont *)textFont delegate:(id<UITextFieldDelegate>)delegate returnType:(UIReturnKeyType)returnType placeholder:(NSString *)placeholder {
    return [self createTextFieldWith:frame borderStyle:borderStyle textColor:textColor textFont:textFont delegate:delegate returnType:returnType keyboardType:UIKeyboardTypeDefault placeholder:placeholder text:nil];
}
+ (UITextField *)createTextFieldWith:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)textColor textFont:(UIFont *)textFont delegate:(id<UITextFieldDelegate>)delegate returnType:(UIReturnKeyType)returnType keyboardType:(UIKeyboardType)keyboardType placeholder:(NSString *)placeholder text:(NSString *)text {
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = borderStyle;
    textField.textColor = textColor;
    textField.font = textFont;
    textField.delegate = delegate;
    textField.returnKeyType = returnType;
    textField.keyboardType = keyboardType;
    textField.placeholder = placeholder;
    textField.text = text;
    return textField;
}



@end
