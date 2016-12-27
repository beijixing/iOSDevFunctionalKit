//
//  GifImageView.h
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/26.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GifImageView : UIView
- (instancetype)initWithCenter:(CGPoint)center fileURL:(NSURL *)fileUrl;
- (void)startPlay;
@end
