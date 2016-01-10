//
//  ToolBox.h
//  zglTest
//
//  Created by 郑光龙 on 15/10/27.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ToolBox : NSObject



+ (UIView *)createViewWithFrame:(CGRect)frame;
+ (UIView *)createViewWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor;
+ (UIView *)createViewWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor andIsHidden:(BOOL)isHidden;

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;

+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)textFont text:(NSString *)text;
+ (UILabel *)createLabelWithFrame:(CGRect)frame textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)textFont text:(NSString *)text;


+ (UIButton *)createButtonWithFrame:(CGRect)frame titleColor:(UIColor*)color selector:(SEL) selector target:(id)target buttonTitle:(NSString*)buttonTitle;
+ (UIButton *)createButtonWithFrame:(CGRect)frame buttonImageName:(NSString*)imageName selector:(SEL) selector target:(id)target;
+ (UIButton *)createButtonWithFrame:(CGRect)frame titleColor:(UIColor*)color buttonImageName:(NSString*)imageName selector:(SEL) selector target:(id)target buttonTitle:(NSString*)buttonTitle ;



+ (UITextField *)createTextFieldWithFrame:(CGRect) frame borderStyle:(UITextBorderStyle)borderStyle textColot:(UIColor *)textcolor placeholder:(NSString *)placeholder textFont:(UIFont *)textFont delegate:(id<UITextFieldDelegate>)delegate text:(NSString *)text returnType:(UIReturnKeyType)returnType keyboardType:(UIKeyboardType)keyboardType;

+ (UIScrollView *)createScrollViewWithFrame:(CGRect)frame contentSize:(CGSize)contentSize;

#pragma mark -- 判断手机的合法性
//验证手机号
+ (BOOL)verifyPhone:(NSString *)tf;

#pragma mark -- 自适应宽高

+ (CGSize)sizeForString:(NSString *)aString WithConstrainedToSize:(CGSize)aSize AndFont:(UIFont *)font;



//UIWebView
+ (UIWebView *)createWebViewWithFrame:(CGRect)frame localResourceName:(NSString *)fileName resType:(NSString *)resType;

+ (UIWebView *)createWebViewWithFrame:(CGRect)frame andUrl:(NSString *)url;

//UIAlertController

//UITextView

+ (UITextView *)createTextViewWithFrame:(CGRect)frame;


//UISlider
+ (UISlider *)createSliderWithFrame:(CGRect)frame ;


//UIPickerView
+ (UIPickerView *)createPickerViewWithFrame:(CGRect)frame;


//UIProgressView
+ (UIProgressView *)createProgressViewWithFrame:(CGRect)frame;


+ (NSString*)getDaysBetweenEndDate:(NSString* )endDate andStartDate:(NSString *)startDate withDateFormat:(NSString *)format;
@end
