//
//  ShimmerLabel.h
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/25.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  原理介绍：使用蒙版实现彩色文本滚动闪烁的效果，两个大小位置一样的Label，文字内容也一样,层级位于上面的Label就是提供效果的Label，所有的操作都是针对这个Label进行的。设置上层Label的文字颜色与蒙版层颜色一样（蒙版层是CAlayer 或者其子类），并且把蒙版层添加到上层Label中，并设置上层Label图层的遮盖层为蒙版图层 （label.layer.mask=maskLayer），设置蒙版图层的大小，这时候上层Label只有蒙版大小的位置显示在屏幕上，其余部分被裁剪掉了，如果再给蒙版曾加上一个循环执行的动画，就可以看到文字跑马灯式的变色高亮效果。
 */
@interface ShimmerLabel : UIView
@end
