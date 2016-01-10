//
//  ToolBox.m
//  zglTest
//
//  Created by 郑光龙 on 15/10/27.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "ToolBox.h"

@implementation ToolBox

#pragma mark --UIView
+ (UIView *)createViewWithFrame:(CGRect)frame {
    return [[self class] createViewWithFrame:frame andBackgroundColor:[UIColor whiteColor] andIsHidden:NO];
}

+ (UIView *)createViewWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor {
    return [[self class] createViewWithFrame:frame andBackgroundColor:backgroundColor andIsHidden:NO];
}

+ (UIView *)createViewWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor andIsHidden:(BOOL)isHidden {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    view.hidden = isHidden;
    return view;
}

#pragma mark --UIImageView

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName {
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

#pragma mark --UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)textFont text:(NSString *)text {
   return [[self class] createLabelWithFrame:frame textColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft font:textFont text:text];
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)textFont text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = textColor;
    label.backgroundColor = backgroundColor;
    label.textAlignment = textAlignment;
    label.font = textFont;
    label.text = text;
    return label;
}

#pragma mark --UIButton

+ (UIButton *)createButtonWithFrame:(CGRect)frame titleColor:(UIColor*)color selector:(SEL) selector target:(id)target buttonTitle:(NSString*)buttonTitle {
    return [[self class] createButtonWithFrame:frame titleColor:color buttonImageName:nil  selector:selector target:target buttonTitle:buttonTitle ];
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame buttonImageName:(NSString*)imageName selector:(SEL) selector target:(id)target {
    return [[self class] createButtonWithFrame:frame titleColor:nil buttonImageName:imageName selector:selector target:target buttonTitle:nil ];
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame titleColor:(UIColor*)color buttonImageName:(NSString*)imageName selector:(SEL) selector target:(id)target buttonTitle:(NSString*)buttonTitle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:ImageName(imageName) forState:UIControlStateNormal];
    return button;
}


#pragma mark --UITextField
+(UITextField *)createTextFieldWithFrame:(CGRect) frame borderStyle:(UITextBorderStyle)borderStyle textColot:(UIColor *)textcolor placeholder:(NSString *)placeholder textFont:(UIFont *)textFont delegate:(id<UITextFieldDelegate>)delegate text:(NSString *)text returnType:(UIReturnKeyType)returnType keyboardType:(UIKeyboardType)keyboardType {
    UITextField* textField = [[UITextField alloc] initWithFrame:frame];
    textField.textColor = textcolor;
    textField.delegate = delegate;
    textField.borderStyle = borderStyle;
    textField.font = textFont;
    textField.placeholder = placeholder;
    textField.text = text;
    textField.returnKeyType = returnType;
    textField.keyboardType = keyboardType;
    return textField;
}

#pragma mark --UIScrollView
+ (UIScrollView *)createScrollViewWithFrame:(CGRect)frame contentSize:(CGSize)contentSize {
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.contentSize = contentSize;
    return scrollView;
}

#pragma mark -- 手机号码的合法性
+ (void)showMessageTips:(NSString *)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

+ (BOOL)isTelephone:(NSString *)str
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:str]   ||
    [regextestphs evaluateWithObject:str]      ||
    [regextestct evaluateWithObject:str]       ||
    [regextestcu evaluateWithObject:str]       ||
    [regextestcm evaluateWithObject:str];
}

//验证手机号
+ (BOOL)verifyPhone:(NSString *)tf
{
    if (tf.length==0) {
        [[self class] showMessageTips:@"请输入手机号"];
        return NO;
    }
    if (![[self class] isTelephone:tf]) {
        [[self class] showMessageTips:@"手机号格式错误,请重新输入"];
        return NO;
    }
    return YES;
}
#pragma mark -- 自适应宽高

+ (CGSize)sizeForString:(NSString *)aString WithConstrainedToSize:(CGSize)aSize AndFont:(UIFont *)font {
    CGSize size;
    if ([[[UIDevice currentDevice] systemVersion] intValue]>=7.0) {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        size = [aString boundingRectWithSize:aSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [aString sizeWithFont:font constrainedToSize:aSize lineBreakMode:NSLineBreakByCharWrapping];
    }
#pragma clang diagnostic pop
    return size;
    
    //    return fmaxf(20.0f, size.height);
}

#pragma mark --UIWebView
+ (UIWebView *)createWebViewWithFrame:(CGRect)frame localResourceName:(NSString *)fileName resType:(NSString *)resType {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:resType];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
    [webView loadRequest:request];
    return webView;
}

+ (UIWebView *)createWebViewWithFrame:(CGRect)frame andUrl:(NSString *)url {
   
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [webView loadRequest:request];
    return webView;
}

+ (NSString*)getDaysBetweenEndDate:(NSString* )endDate andStartDate:(NSString *)startDate withDateFormat:(NSString *)format{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    df.dateFormat = format;
    
    NSDate *eDate = [df dateFromString:endDate];
    NSDate *sDate = [df dateFromString:startDate];
    
    long eSeconds = [eDate timeIntervalSince1970];
    long sSeconds = [sDate timeIntervalSince1970];
    
    long seconds = eSeconds - sSeconds;
    
    CGFloat days = (CGFloat)seconds/(CGFloat)(24*60*60);
    
    NSString *daysStr = [NSString stringWithFormat:@"%.0f",days ];
    return daysStr;
}

@end
