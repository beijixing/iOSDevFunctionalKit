//
//  PrefixHeader.h
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/2.
//  Copyright © 2015年 郑光龙. All rights reserved.
//



/*
xcode6以后新建项目时默认不创建PrefixHeader.h文件，需要我们自己创建并进行相关配置。
选中项目，右侧显示Build Settings 在搜索框中输入 Prefix 进行搜索，在Apple LLVM -Language 分组中有Prefix Header 选项，点击右侧空白处，弹出白色悬浮框，按住option键 同时拖动PrefixHeader.h文件到悬浮框中，当显示+号时松开鼠标，这时PrefixHeader的路径会添加到悬浮框中，这个路径是绝对路径，我们需要把它改为相对路径以$(SRCROOT)/开头。
 */
#ifndef PrefixHeader_h
#define PrefixHeader_h

#import <UIKit/UIKit.h>
#import "CONST.h"
#import "ToolBox.h"
#import "BaseViewController.h"
#import <MAMapKit/MAMapKit.h>

#endif /* PrefixHeader_h */
