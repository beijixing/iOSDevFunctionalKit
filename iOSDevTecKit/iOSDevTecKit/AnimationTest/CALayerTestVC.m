//
//  CALayerTestVC.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/7/19.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "CALayerTestVC.h"

@interface CALayerTestVC ()
{
    NSMutableArray *_testViewArr;
    NSInteger _currentViewID;
}
@end

@implementation CALayerTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _testViewArr = [[NSMutableArray alloc] init];
    _currentViewID = 0;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"next" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.center = CGPointMake(self.view.frame.size.width/2-50, 20);
    [button addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;
    
    
    [self cashaplayerDrawTest];
    [self calayerCornerMask];
    [self catextlayerAslabel];
    [self catransformLayer];
    [self caGradientLayer];
    [self caReplicatorLayer];
}

- (void)nextView:(UIButton *)button {
    UIView *lastView = _testViewArr[_currentViewID];
    if (lastView) {
        [lastView removeFromSuperview];
    }
    
    _currentViewID++;
    if (_currentViewID>=_testViewArr.count) {
        _currentViewID = 0;
    }
    
    UIView *currView = _testViewArr[_currentViewID];
    if (currView) {
        [self.view addSubview:currView];
    }
}

//CAShapLayer
- (void)cashaplayerDrawTest {
    UIView *cashaplayerContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    cashaplayerContainer.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:cashaplayerContainer];
    [_testViewArr addObject:cashaplayerContainer];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];

    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //add it to our view
    [cashaplayerContainer.layer addSublayer:shapeLayer];

}

- (void)calayerCornerMask {
    UIView *testView = [[UIView alloc] initWithFrame:self.view.bounds];
    testView.backgroundColor = [UIColor redColor];
    [_testViewArr addObject:testView];

    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *cornerLayer = [CAShapeLayer layer];
    cornerLayer.lineCap = @"round";
    cornerLayer.lineWidth = 5;
    cornerLayer.backgroundColor = [UIColor greenColor].CGColor;
    cornerLayer.path = path.CGPath;
    //[testView.layer addSublayer:cornerLayer];
    testView.layer.mask = cornerLayer;
}

//CATextLayer也要比UILabel渲染得快得多,而CATextLayer使用了Core text
- (void)catextlayerAslabel {
    
    UIView *labelView = [[UIView alloc] initWithFrame:self.view.bounds];
    labelView.backgroundColor = [UIColor whiteColor];
    CATextLayer *textlayer = [CATextLayer layer];
    textlayer.frame = labelView.frame;
    [labelView.layer addSublayer:textlayer];
    [_testViewArr addObject:labelView];
    
    textlayer.foregroundColor = [UIColor redColor].CGColor;
    textlayer.wrapped = YES;
    textlayer.alignmentMode = kCAAlignmentJustified;
    UIFont *font = [UIFont systemFontOfSize:18];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textlayer.font = fontRef;
    textlayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    textlayer.string = @"气象局通知： 原约定于昨天，今天，明天凌晨来的暴雨，因半路资金不足，耽误了点时间，或许明天下午至夜间赶到。这场雨如果下大了肯定不小，如果下小了也肯定不会大，请市民再耐心等待！具体情况等气象台会后报给市民。气象台温馨提醒：今天如果不下雨，明天不下雨的话，这两天就没有雨了，就看后天的了。 气象台郑重劝告美女们最近几天不要穿裙子，容易被撩，雨是好雨，但风不正经！ 市气象局宣！";
    
    textlayer.contentsScale = [UIScreen mainScreen].scale;
}

//CATextLayer 富文本
- (void)catextlayerRichLabel {
    

}

- (CALayer *)faceWithTransform:(CATransform3D)transform
{
    //create cube face layer
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    //apply a random color
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    face.transform = transform;
    return face;
}
- (CALayer *)cubeWithTransform:(CATransform3D)transform andContainerSize:(CGSize)containerSize
{
    //create cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //center the cube layer within the container
//    CGSize containerSize = self.containerView.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    //apply the transform and return
    cube.transform = transform;
    return cube;
}


- (void)catransformLayer {
    
    UIView *catransformLayerContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    catransformLayerContainer.backgroundColor = [UIColor lightGrayColor];
    [_testViewArr addObject:catransformLayerContainer];

    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    catransformLayerContainer.layer.sublayerTransform = pt;
    //set up the transform for cube 1 and add it
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    CALayer *cube1 = [self cubeWithTransform:c1t andContainerSize:catransformLayerContainer.frame.size];
    [catransformLayerContainer.layer addSublayer:cube1];
    //set up the transform for cube 2 and add it
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t andContainerSize:catransformLayerContainer.frame.size];
    [catransformLayerContainer.layer addSublayer:cube2];
}

//CAGradientLayer 渐变色的图层

- (void)caGradientLayer {
    
    UIView *caGradientLayerContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    caGradientLayerContainer.backgroundColor = [UIColor lightGrayColor];
    [_testViewArr addObject:caGradientLayerContainer];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = caGradientLayerContainer.bounds;
    [caGradientLayerContainer.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor orangeColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor purpleColor].CGColor];
    gradientLayer.locations = @[@0.2, @0.3, @0.4, @0.5,@0.6, @0.9,@1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    
}

//CAReplicatorLayer 重复图层
- (void)caReplicatorLayer{
    UIView *caReplicatorLayerContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    caReplicatorLayerContainer.backgroundColor = [UIColor lightGrayColor];
    [_testViewArr addObject:caReplicatorLayerContainer];
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = caReplicatorLayerContainer.bounds;
    [caReplicatorLayerContainer.layer addSublayer:replicator];
    //configure the replicator
    replicator.instanceCount = 10;
    //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 100, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -100, 0);
    replicator.instanceTransform = transform;
    //apply a color shift for each instance
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    //create a sublayer and place it inside the replicator
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
