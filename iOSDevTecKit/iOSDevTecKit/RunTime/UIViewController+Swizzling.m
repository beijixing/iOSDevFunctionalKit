//
//  UIViewController+Swizzling.m
//  iOSDevTecKit
//
//  Created by horse on 2017/7/11.
//  Copyright © 2017年 郑光龙. All rights reserved.
//

#import "UIViewController+Swizzling.h"

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

//Swizzling 方法交换
@implementation UIViewController (Swizzling)
+(void)load {
#ifdef DEBUG
    
//    Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
//    
//    Method logViewWillAppear = class_getInstanceMethod(self, @selector(logViewWillAppear:));
//    
//    method_exchangeImplementations(viewWillAppear, logViewWillAppear);
    swizzleMethod([self class], @selector(viewWillAppear:), @selector(logViewWillAppear:));
#endif
}

- (void)logViewWillAppear:(BOOL)animated {
    
    NSString *className = NSStringFromClass([self class]);
    
    //在这里，你可以进行过滤操作，指定哪些viewController需要打印，哪些不需要打印
    if ([className hasPrefix:@"UI"] == NO) {
        NSLog(@"%@ will appear",className);
    }
    
    //下面方法的调用，其实是调用viewWillAppear
    [self logViewWillAppear:animated];
    
}




@end



/*
 一种更简单的方式
 
 void (gOriginalViewDidAppear)(id, SEL, BOOL);
 
 void newViewDidAppear(UIViewController *self, SEL _cmd, BOOL animated)
 {
 // call original implementation
 gOriginalViewDidAppear(self, _cmd, animated);
 
 // Logging
 [Logging logWithEventName:NSStringFromClass([self class])];
 }
 
 + (void)load
 {
 Method originalMethod = class_getInstanceMethod(self, @selector(viewDidAppear:));
 gOriginalViewDidAppear = (void *)method_getImplementation(originalMethod);
 
 if(!class_addMethod(self, @selector(viewDidAppear:), (IMP) newViewDidAppear, method_getTypeEncoding(originalMethod))) {
 method_setImplementation(originalMethod, (IMP) newViewDidAppear);
 }
 }
 */
