//
//  SDWebImage.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/11/28.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "SDWebImageTest.h"
//#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "UIFactory.h"
@interface SDWebImageTest ()
{
    int imageIdx;
}
@end

@implementation SDWebImageTest

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"SDWebImageTest";
    
    //
//    [self.netImage sd_setImageWithURL:[NSURL URLWithString:@"http://down.tutu001.com/d/file/20101129/2f5ca0f1c9b6d02ea87df74fcc_560.jpg"] placeholderImage:[UIImage imageNamed:@"anjuke_icon_to_position1"]];
    
    
    //
    
    [self.netImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:@"http://202.99.45.60:8899/WO_UnicomPro/picture/report/rb_ydywrjkzb.png"] andPlaceholderImage:[UIImage imageNamed:@"address_add_location"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        NSLog(@"expectedSize = %ld", expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"ERROR = %@", error);
        _netImage.image = image;
    }];
    
   [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    imageIdx = 1;
    
    
    
        UITextField *textfield = [UIFactory createTextFieldWith:CGRectMake(0, 0, 100, 100) borderStyle:UITextBorderStyleRoundedRect textColor:[UIColor orangeColor] placeholder:@"输入文字"];
        textfield.center = self.view.center;
        [self.view addSubview: textfield];
        [self.view bringSubviewToFront:textfield];
    
}

- (void)changeImage {
    ++imageIdx;
    if (imageIdx >6) {
        imageIdx = 1;
    }
    
//    [self.netImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.20.106/image/%d.jpg", imageIdx]]];
    
    [self.netImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.20.106/image/%d.jpg", imageIdx]] placeholderImage:[UIImage imageNamed:@"address_add_location"] options:SDWebImageProgressiveDownload];
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
