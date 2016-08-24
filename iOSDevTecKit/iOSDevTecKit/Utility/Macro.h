//
//  Macro.h
//  E-attendance
//
//  Created by Kevin on 14-9-19.
//  Copyright (c) 2014年 bitwayapp. All rights reserved.
//

#ifndef E_attendance_Macro_h
#define E_attendance_Macro_h

//测试专用输出

#ifdef DEBUG
#define DebugLog(format, ...) NSLog((@"%s [Line %d]" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DebugLog(format, ...)
#endif


// ---------------------------------------------
#pragma mark  - UI相关
#define ScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define OrangeColor    [UIColor colorFromHexString:@"#f64d09"]
#define BlueColor    [UIColor colorFromHexString:@"#38b7f0"]




// ---------------------------------------------
#pragma mark  - 帮助宏
#define AboveiOS7_1 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.1)
#define AboveiOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define AboveiOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define isiOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)

#define isiOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)


#define APPKEY  [AppConfig sharedInstance].appkey
#define APPCERT [AppConfig sharedInstance].appcert
#define USERID  [UserTool sharedUser].userId

#define HomeURL [NSString stringWithFormat:@"%@/app.php?s=/Home/index.html",AppURLHost]


#endif
