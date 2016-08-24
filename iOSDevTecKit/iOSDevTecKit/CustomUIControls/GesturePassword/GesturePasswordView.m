//
//  GesturePasswordView.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "GesturePasswordView.h"
#import "GesturePasswordButton.h"
#import "TentacleView.h"

@implementation GesturePasswordView {
    NSMutableArray * buttonArray;
    
    CGPoint lineStartPoint;
    CGPoint lineEndPoint;
    
}
//@synthesize imgView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        float headIconImgViewPosY = (frame.size.height > 568)?(frame.size.height/2-240):(frame.size.height/2-220);
//        self.headIconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-35, headIconImgViewPosY, 70, 70)];
//        [self.headIconImgView setBackgroundColor:[UIColor whiteColor]];
//        [self.headIconImgView.layer setCornerRadius:35];
//        [self.headIconImgView.layer setBorderColor:[UIColor grayColor].CGColor];
//        [self.headIconImgView.layer setBorderWidth:3];
//        [self addSubview:self.headIconImgView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headIconImgViewPosY, frame.size.width, 40)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = @"设置手势密码";
        [self addSubview:self.titleLabel];
        
        float stateViewPosY = (frame.size.height > 568)?(frame.size.height/2-160):(frame.size.height/2-170);
        self.state = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2-140, stateViewPosY, 280, 30)];
        [self.state setTextAlignment:NSTextAlignmentCenter];
        [self.state setFont:[UIFont systemFontOfSize:14.f]];
        self.state.text = @"请输入密码";
        [self addSubview:self.state];
        
        buttonArray = [[NSMutableArray alloc]initWithCapacity:0];
        float gestureViewPosY = (frame.size.height > 568)?(frame.size.height/2-110):(frame.size.height/2-130);
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width/2-160, gestureViewPosY , 320, 320)];
        for (int i=0; i<9; i++) {
            NSInteger row = i/3;
            NSInteger col = i%3;
            // Button Frame
            
            NSInteger distance = 320/3;
            NSInteger size = distance/1.5;
            NSInteger margin = size/4;
            GesturePasswordButton * gesturePasswordButton = [[GesturePasswordButton alloc]initWithFrame:CGRectMake(col*distance+margin, row*distance, size, size)];
            [gesturePasswordButton setTag:i];
            [view addSubview:gesturePasswordButton];
            [buttonArray addObject:gesturePasswordButton];
        }
        frame.origin.y=0;
        [self addSubview:view];
       
        self.tentacleView = [[TentacleView alloc]initWithFrame:view.frame];
        [self.tentacleView setButtonArray:buttonArray];
        [self.tentacleView setTouchBeginDelegate:self];
        [self.tentacleView setTouchEndDelegate:self];
        [self addSubview:self.tentacleView];
        
        float forgetButtonViewPosY = (frame.size.height > 568.0) ? (frame.size.height - 80 ):(frame.size.height - 40);
        self.forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-150, forgetButtonViewPosY, 120, 30)];
        [self.forgetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.forgetButton setTitle:@"用密码登录" forState:UIControlStateNormal];
        [self.forgetButton addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.forgetButton];
        
//        float changeButtonViewPosY = (frame.size.height > 568)?(frame.size.height/2):(frame.size.height/2);
//        self.changeButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2+30, changeButtonViewPosY, 120, 30)];
//        [self.changeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
//        [self.changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.changeButton setTitle:@"重置手势密码" forState:UIControlStateNormal];
//        [self.changeButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchDown];
//        [self addSubview:self.changeButton];
//         self.changeButton.backgroundColor = [UIColor blueColor];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        250 / 255.0,  157 / 255.0, 101 / 255.0, 1.00,
        255 / 255.0, 113 / 255.0, 93 / 255.0, 1.00,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (0.0,0.0) ,CGPointMake(0.0,self.frame.size.height),
                                kCGGradientDrawsBeforeStartLocation);
}

- (void)gestureTouchBegin {
    [self.state setText:@""];
}

- (void)gestureTouchEndWithDotCounts:( NSInteger )count {
    if (count < 3) {
        self.state.text = @"至少绘制3个点,请重试";
    }
}


-(void)forget{
    if (self.gesturePasswordDelegate && [self.gesturePasswordDelegate respondsToSelector:@selector(forget)]) {
        [self.gesturePasswordDelegate forget];
    }
}

-(void)change{
    if (self.gesturePasswordDelegate && [self.gesturePasswordDelegate respondsToSelector:@selector(change)]) {
        [self.gesturePasswordDelegate change];
    }
}


@end
