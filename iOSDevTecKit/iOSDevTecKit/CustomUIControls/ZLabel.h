//
//  ZLabel.h
//  WoJK
//
//  Created by Megatron on 16/5/27.
//  Copyright © 2016年 zhilong. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 可以设置竖直方向对齐方式的Label类
 */
IB_DESIGNABLE
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface ZLabel : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}
@property (nonatomic) IBInspectable VerticalAlignment verticalAlignment;
@end
