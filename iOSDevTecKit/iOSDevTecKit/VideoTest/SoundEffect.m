//
//  PlaySound.m
//  iOSDevTecKit
//
//  Created by horse on 16/9/19.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "SoundEffect.h"
#import <AudioToolbox/AudioToolbox.h>
@implementation SoundEffect

void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
}


+(void)playWithSoundFile:(NSString *)fileName fileType:(NSString *)type {
    NSString *audioFile=[[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID=0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    //2.播放音频
    AudioServicesPlaySystemSound(soundID);//播放音效
//    AudioServicesPlayAlertSound(soundID);//播放音效并震动
}
@end
