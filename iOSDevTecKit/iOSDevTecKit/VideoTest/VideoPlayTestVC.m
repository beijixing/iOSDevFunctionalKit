//
//  VideoTestVC.m
//  iOSDevTecKit
//
//  Created by ybon on 16/1/21.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "VideoPlayTestVC.h"
//#import <MediaPlayer/MediaPlayer.h>
//#import <MediaToolbox/MediaToolbox.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface VideoPlayTestVC ()

@end

@implementation VideoPlayTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn1 = [ToolBox createButtonWithFrame:CGRectMake(10, 0, 100, 40) titleColor:[UIColor redColor] selector:@selector(btnClick:) target:self buttonTitle:@"网络视频"];
    btn1.tag = 0;
    
    UIButton *btn2 = [ToolBox createButtonWithFrame:CGRectMake(150, 0, 100, 40) titleColor:[UIColor redColor] selector:@selector(btnClick:) target:self buttonTitle:@"本地视频"];
    btn2.tag = 1;
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
}

- (void)btnClick:(UIButton *)btn {
    if (btn.tag == 0) {
        [self openOnlineMovie];
    }else if(btn.tag == 1) {
        [self openLocalMovie];
    }
}

- (void)openOnlineMovie {
    AVPlayerViewController *movieController = [[AVPlayerViewController alloc] init];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://211.149.209.45/group7/hm_BYX/uploadfiles/2015/07/201507011539053405.mp4"]];
    movieController.player = player;
    [self presentViewController:movieController animated:YES completion:^{
    }];
}

- (void)openLocalMovie {
    AVPlayerViewController *movieController = [[AVPlayerViewController alloc] init];
    NSString *videoPath = [[NSBundle mainBundle]pathForResource:@"macol" ofType:@"mp4"];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:videoPath]];
    movieController.player = player;
    [self presentViewController:movieController animated:YES completion:^{
    }];
}

/*
 -(void)openmovie
 
 {
 
 MPMoviePlayerViewController *movie = [[MPMoviePlayerViewControlleralloc]initWithContentURL:[NSURLURLWithString:@视频网络地址]];
 
 
 
 [movie.moviePlayer prepareToPlay];
 
 [self presentMoviePlayerViewControllerAnimated:movie];
 
 [movie.moviePlayersetControlStyle:MPMovieControlStyleFullscreen];
 
 
 
 [movie.viewsetBackgroundColor:[UIColorclearColor]];
 
 
 
 [movie.view setFrame:self.view.bounds];
 
 [[NSNotificationCenterdefaultCenter]addObserver:self
 
 
 
 selector:@selector(movieFinishedCallback:)
 
 
 
 name:MPMoviePlayerPlaybackDidFinishNotification
 
 
 
 object:movie.moviePlayer];
 
 
 
 }
 
 -(void)movieFinishedCallback:(NSNotification*)notify{
 
 
 
 // 视频播放完或者在presentMoviePlayerViewControllerAnimated下的Done按钮被点击响应的通知。
 
 
 
 MPMoviePlayerController* theMovie = [notifyobject];
 
 
 
 [[NSNotificationCenterdefaultCenter]removeObserver:self
 
 
 
 name:MPMoviePlayerPlaybackDidFinishNotification
 
 
 
 object:theMovie];
 
 
 
 [selfdismissMoviePlayerViewControllerAnimated];
 
 
 
 }
 */
@end
