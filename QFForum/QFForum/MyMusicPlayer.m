//
//  MyMusicPlayer.m
//  MyXmppDemo
//
//  Created by 张广洋 on 15/12/5.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "MyMusicPlayer.h"

#import <AVFoundation/AVFoundation.h>

@interface MyMusicPlayer()
<AVAudioPlayerDelegate>
{
    AVAudioPlayer * _bgAudioPlayer;
    AVAudioPlayer * _soundEffectAudioPlayer;
}

@property (nonatomic) BOOL Need_Play;

@end

@implementation MyMusicPlayer

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)init{
    if (self=[super init]) {
        //读取是否播放音效
        [self readNeedPlay];
        //监听音效设置
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(readNeedPlay)
                                                    name:@"soundEffectSetChanged"
                                                  object:nil];
    }
    return self;
}

+(instancetype)player{
    static MyMusicPlayer * _player=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _player=[[MyMusicPlayer alloc]init];
    });
    return _player;
}

-(void)playWindBgSound{
    if (!self.Need_Play) {
        return;
    }
    [self playBackgroundSoundWithReSource:@"slowWind" type:@"mp3" loopNum:-1];
}

-(void)playWater0{
    if (!self.Need_Play) {
        return;
    }
    [self playSoundEffectWithReSource:@"water0" type:@"MP3"];
}

-(void)playWater1{
    if (!self.Need_Play) {
        return;
    }
    [self playSoundEffectWithReSource:@"water1" type:@"wav"];
}

-(void)playBackgroundSoundWithReSource:(NSString *)soundResource type:(NSString *)type loopNum:(NSInteger)ln{
    if ([_bgAudioPlayer isPlaying]) {
        [self stop];
    }
    //获取音频文件沙盒路径
    NSString * audioFilePath=[[NSBundle mainBundle]pathForResource:soundResource ofType:type];
    //转换成url
    NSURL * audioURL=[NSURL fileURLWithPath:audioFilePath];
    //实例化播放器
    _bgAudioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:audioURL error:nil];
    _bgAudioPlayer.volume=0.5;
    _bgAudioPlayer.numberOfLoops=ln;
    _bgAudioPlayer.delegate=self;
    //准备播放
    [_bgAudioPlayer prepareToPlay];
    [_bgAudioPlayer play];
}

-(void)playSoundEffectWithReSource:(NSString *)soundResource type:(NSString *)type{
    if ([_soundEffectAudioPlayer isPlaying]) {
        [_soundEffectAudioPlayer stop];
        _soundEffectAudioPlayer=nil;
    }
    //获取音频文件沙盒路径
    NSString * audioFilePath=[[NSBundle mainBundle]pathForResource:soundResource ofType:type];
    //转换成url
    NSURL * audioURL=[NSURL fileURLWithPath:audioFilePath];
    //实例化播放器
    _soundEffectAudioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:audioURL error:nil];
    _soundEffectAudioPlayer.volume=0.5;
    _soundEffectAudioPlayer.numberOfLoops=0;
    _soundEffectAudioPlayer.delegate=self;
    //准备播放
    [_soundEffectAudioPlayer prepareToPlay];
    [_soundEffectAudioPlayer play];
}

-(void)stop{
    if ([_bgAudioPlayer isPlaying]) {
        [_bgAudioPlayer stop];
        _bgAudioPlayer=nil;
    }
}


#pragma mark - audioPlayer代理方法 -

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    player=nil;
}


#pragma mark - 获取是否播放音乐 -

-(void)readNeedPlay{
    BOOL need=[[NSUserDefaults standardUserDefaults]boolForKey:@"soundEffectOpen"];
    self.Need_Play=need;
}

@end
