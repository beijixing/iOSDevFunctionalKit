//
//  UIWebView+Error.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/22.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "UIWebView+Error.h"
@implementation UIWebView (Error)
- (void)loadError{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"404" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
}
@end
