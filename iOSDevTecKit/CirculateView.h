//
//  HeaderView.h
//  YbYoutianNew
//
//  Created by macbook on 16/1/3.
//  Copyright © 2016年 YBON. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CirculateViewDelegate <NSObject>
@optional
- (void)circulateViewClicked:(NSInteger)adIndex;
@end

@interface CirculateView : UIView<UIScrollViewDelegate>
@property (nonatomic, assign) id<CirculateViewDelegate> delegate;
//对外公开一个接口，刷新显示的数据
-(void)addScrollImages:(NSArray *)images;
@end
