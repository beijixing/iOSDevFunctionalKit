//
//  DownLoadFont.h
//  iOSDevTecKit
//
//  Created by horse on 2017/1/5.
//  Copyright © 2017年 郑光龙. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SetTextBlock)();

@interface DownLoadFont : NSObject
@property(nonatomic, strong) NSArray *fontNames;
- (void)asynchronouslySetFontName:(NSString *)fontName with:(SetTextBlock)setTextBlock;
@end
