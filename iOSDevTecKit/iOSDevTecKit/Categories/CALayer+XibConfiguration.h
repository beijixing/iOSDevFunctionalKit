//
//  CALayer+XibConfiguration.h
//  CreditCardManager
//
//  Created by 郑光龙 on 15/11/17.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (XibConfiguration)

// This assigns a CGColor to borderColor.
//@property(nonatomic, assign) UIColor* borderUIColor;
-(void)setBorderUIColor:(UIColor*)color;
-(UIColor*)borderUIColor;

@end
