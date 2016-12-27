//
//  TransformTestVC.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/7/19.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "TransformTestVC.h"
#import "CubeVC.h"

@interface TransformTestVC ()
@property (strong, nonatomic) IBOutlet UIImageView *imageViewTest;
@property (strong, nonatomic) IBOutlet UIImageView *ImageViewAffineTest;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewTrransform3DTest;
@end

@implementation TransformTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    //蒙版效果
    CALayer *maskLayer = [[CALayer alloc] init];
    maskLayer.frame = self.imageViewTest.bounds;
    maskLayer.contents = (__bridge id)[[UIImage imageNamed:@"180"] CGImage];
    maskLayer.contentsGravity = kCAGravityResizeAspect;
    
//    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"position"];
//    basicAnim.duration = 3.0;
//    [basicAnim setFromValue:[NSValue valueWithCGPoint:CGPointMake(80, 0)]];
//    [basicAnim setToValue:[NSValue valueWithCGPoint:CGPointMake(200, 100)]];
//    basicAnim.autoreverses = YES;
//    basicAnim.repeatCount = 10;
//    [maskLayer addAnimation:basicAnim forKey:@"position"];
    
    maskLayer.position = CGPointMake(200, 100);
    
    self.imageViewTest.layer.mask = maskLayer;
    
    
    //create opaque button
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake(50, 150);
    [self.view addSubview:button1];
    //create translucent button
    UIButton *button2 = [self customButton];
    
    button2.center = CGPointMake(250, 150);
    button2.alpha = 0.5;
    [self.view addSubview:button2];
    //enable rasterization for the translucent button
    //    button2.layer.shouldRasterize = YES;
    //    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self affineTransformTest];
    [self transform3DTest];
}

//2D仿射变换
- (void)affineTransformTest {
    CGAffineTransform transformRotation = CGAffineTransformIdentity;
    //    transformRotation = CGAffineTransformScale(transformRotation, 1.5, 1.5);
    //    transformRotation = CGAffineTransformRotate(transformRotation, M_PI_4);
    //    transformRotation = CGAffineTransformTranslate(transformRotation , 80, 30);
    //
    //
    transformRotation = CGAffineTransformMakeShear(0.1, 0);
    self.ImageViewAffineTest.transform = transformRotation;
    
}

CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}


//3D  变换
- (void)transform3DTest {
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = 1.0 / 500;
    transform3D = CATransform3DRotate(transform3D, M_PI_4, 0, 1, 0);
    
    self.imageViewTrransform3DTest.layer.transform = transform3D;
}

- (UIButton *)customButton
{
    //create button
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    return button;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cubeVc:(UIButton *)sender {
    CubeVC *cubeVc = [[CubeVC alloc] init];
    [self presentViewController:cubeVc animated:YES completion:^{
        
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
