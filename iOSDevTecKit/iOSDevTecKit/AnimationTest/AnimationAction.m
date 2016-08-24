//
//  AnimationAction.m
//  iOSDevTecKit
//
//  Created by ybon on 16/1/20.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "AnimationAction.h"
#define DURATION 1.0
typedef enum : NSUInteger {
    Fade = 0,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
} AnimationType;

@interface AnimationAction ()
{
    UIView *_graduallyView;
}
@end

@implementation AnimationAction

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i<10; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        int col = i%2; int row = i/2;
        button.frame = CGRectMake(100+col*120, 200+row*60, 100, 40);
        button.tag = i;
        [button setTitle:[NSString stringWithFormat:@"第%d个button", i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor blueColor];
        [self.view addSubview:button];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-100, 100, 40);
    button.tag = 10010;
    [button setTitle:@"go back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    
//    self.view.backgroundColor = [UIColor greenColor];
    _graduallyView = [[UIView alloc] initWithFrame:CGRectMake(100, 400, 320, 50)];
    [self.view addSubview:_graduallyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClick:(UIButton *)sender {
    AnimationType animationType = sender.tag;
    
    NSString *subtypeString;
    NSInteger _subtype = 0;
    switch (_subtype) {
        case 0:
            subtypeString = kCATransitionFromLeft;
            break;
        case 1:
            subtypeString = kCATransitionFromBottom;
            break;
        case 2:
            subtypeString = kCATransitionFromRight;
            break;
        case 3:
            subtypeString = kCATransitionFromTop;
            break;
        default:
            break;
    }
    _subtype += 1;
    if (_subtype > 3) {
        _subtype = 0;
    }
    
    switch (animationType)
    {
        case Fade:
            [self transitionWithType:kCATransitionFade WithSubtype:subtypeString ForView:self.view];
            [self rainBowView];
            break;
        case Push:
            [self transitionWithType:kCATransitionPush WithSubtype:subtypeString ForView:self.view];
            break;
        case Reveal:
            [self transitionWithType:kCATransitionReveal WithSubtype:subtypeString ForView:self.view];
            break;
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:subtypeString ForView:self.view];
            break;
        case Cube:
            [self transitionWithType:@"cube" WithSubtype:subtypeString ForView:self.view];
            break;
        case SuckEffect:
            [self transitionWithType:@"suckEffect" WithSubtype:subtypeString ForView:self.view];
            break;
        case OglFlip:
            [self transitionWithType:@"oglFlip" WithSubtype:subtypeString ForView:self.view];
            break;
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" WithSubtype:subtypeString ForView:self.view];
            break;
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" WithSubtype:subtypeString ForView:self.view];
            break;
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtypeString ForView:self.view];
            break;
        default:
            break;
    }
    
    if (sender.tag == 10010) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

-(void)addBgImageWithImageName:(NSString *) imageName
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
}



- (void)rainBowView {
    void (^keyFrameBlock)() = ^(){
        // 创建颜色数组
        NSArray *arrayColors = @[[UIColor orangeColor],
                                 [UIColor yellowColor],
                                 [UIColor greenColor],
                                 [UIColor blueColor],
                                 [UIColor purpleColor],
                                 [UIColor redColor]];
        NSUInteger colorCount = [arrayColors count];
        // 循环添加关键帧
        for (NSUInteger i = 0; i < colorCount; i++) {
            [UIView addKeyframeWithRelativeStartTime:i / (CGFloat)colorCount
                                    relativeDuration:1 / (CGFloat)colorCount
                                          animations:^{
                                              [_graduallyView setBackgroundColor:arrayColors[i]];
                                          }];
        }
    };
    [UIView animateKeyframesWithDuration:4.0
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic | UIViewAnimationOptionCurveLinear
                              animations:keyFrameBlock
                              completion:^(BOOL finished) {
                                  // 动画完成后执行
                                  // code...
                              }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
