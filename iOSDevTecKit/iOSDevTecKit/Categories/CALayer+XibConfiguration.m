//
//  CALayer+XibConfiguration.m
//  CreditCardManager
//
//  Created by 郑光龙 on 15/11/17.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}
-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
