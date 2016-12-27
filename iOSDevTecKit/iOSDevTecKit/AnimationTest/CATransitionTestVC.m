
//
//  CATransitionTestVC.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/2.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "CATransitionTestVC.h"
#import "ShimmerLabel.h"
#import "GifImageView.h"
#import "GifView.h"

@interface CATransitionTestVC ()
@property (strong, nonatomic) IBOutlet UIImageView *testImageView;
@property (strong, nonatomic) NSArray *images;
@property (nonatomic) NSInteger index;
@end

@implementation CATransitionTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.images = [NSArray arrayWithObjects:@"a.jpg", @"b.png", @"c.jpg", @"alien-spaceship.jpg",  nil];
    
    ShimmerLabel *label = [[ShimmerLabel alloc] initWithFrame:CGRectMake(100, 300, 100, 40)];
    [self.view addSubview:label];
//    [label startShimming];
    
    NSString *fileStr = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"gif"];
    NSURL *fileUrl = [NSURL fileURLWithPath:fileStr];

    
    GifImageView *gif1 = [[GifImageView alloc] initWithCenter:CGPointMake(100, 350) fileURL:fileUrl];
    [gif1 startPlay];
    gif1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:gif1];
    
    fileStr = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"gif"];
    GifView *gif = [[GifView alloc] initWithFrame:CGRectMake(230, 350, 100, 100) filePath:fileStr];
    [self.view addSubview:gif];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)switchImage:(UIButton *)sender {
    
    CATransition *transitionAnimation = [CATransition animation];
    transitionAnimation.type = kCATransitionPush;
    [self.testImageView.layer addAnimation:transitionAnimation forKey:nil];
    
    UIImage *image = [UIImage imageNamed:self.images[_index % self.images.count]];
    self.testImageView.image = image;
    self.index++;
}

- (IBAction)transitionAnimation:(id)sender {
    [self customTransitionAnimation];
}

- (void)customTransitionAnimation {
    //preserve the current view snapshot
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    //insert snapshot view in front of this one
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    //update the view (we'll simply randomize the layer background color)
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //perform animation (anything you like)
    [UIView animateWithDuration:1.0 animations:^{
        //scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        //remove the cover view now we're finished with it
        [coverView removeFromSuperview];
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
