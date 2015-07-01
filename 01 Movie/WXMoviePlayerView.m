//
//  WXMoviePlayerView.m
//  WXMovie
//
//  Created by wei.chen on 13-9-17.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WXMoviePlayerView.h"
#import "WXSlider.h"
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>

#define kBlackColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];

@implementation WXMoviePlayerView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self _initViews];
}

- (void)play {
    _mvPlayerCtrl.contentURL = _movieUrl;
    [_mvPlayerCtrl play];
}

#pragma mark - initViews
- (void)_initViews {
    
    _lastVolume = 0.0f;
    
    [self _initNotification];
    
    [self _initMoviePlayer];
    
    [self _initMoviePlayerCtrl];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];

}

- (void)tapAction {
    BOOL hide = !self.mvBottomView.hidden;
    
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;    
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        [self hiddenAnimated:_mvTopView hide:YES];
        [self hiddenAnimated:_mvLeftView hide:YES];
        [self hiddenAnimated:_mvBottomView hide:hide];
    }else{
        [self hiddenAnimated:_mvTopView hide:hide];
        [self hiddenAnimated:_mvLeftView hide:hide];
        [self hiddenAnimated:_mvBottomView hide:hide];
    }
}

- (void)_initNotification {
    //系统声音改变后通知当前对象
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(volumeChangeAction)
                                                 name:MPMusicPlayerControllerVolumeDidChangeNotification
                                               object:nil];
    
    [[MPMusicPlayerController applicationMusicPlayer] beginGeneratingPlaybackNotifications];
    
    
    //视频时长已读取
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(durationAvailableAction)
                                                 name:MPMovieDurationAvailableNotification
                                               object:nil];
    
    //播放状态改变
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
    //播放结束
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}

- (void)_initMoviePlayerCtrl
{
    self.mvTopView.backgroundColor = kBlackColor;
    self.mvLeftView.backgroundColor = kBlackColor;
    self.mvBottomView.backgroundColor = kBlackColor;
    self.mvCtrlView.backgroundColor = [UIColor clearColor];
    
    self.mvTopView.hidden = YES;
    self.mvLeftView.hidden = YES;
    
    //声音
    _volumeSlider = [[WXSlider alloc] initWithFrame:CGRectZero];
    _volumeSlider.value = [[MPMusicPlayerController applicationMusicPlayer] volume];
    [_volumeSlider addTarget:self action:@selector(resetMovieVolume:) forControlEvents:UIControlEventValueChanged];
    _volumeSlider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    _volumeSlider.frame = CGRectMake(3, -5, 24, 80);
    _volumeSlider.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.mvLeftView addSubview:_volumeSlider];

    
    
    //播放进度
    _playerSlider = [[WXSlider alloc] initWithFrame:CGRectMake(75, -1, 170, 44)];
    _playerSlider.continuous = NO;
    [_playerSlider addTarget:self action:@selector(playProgressChangeAction:) forControlEvents:UIControlEventValueChanged];
    _playerSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.mvBottomView addSubview:_playerSlider];

}

- (void)_initMoviePlayer
{
    MPMoviePlayerController *playerCtrl = [[MPMoviePlayerController alloc] init];
    self.mvPlayerCtrl = playerCtrl;

    
    _mvPlayerCtrl.view.frame = CGRectMake(0, 0, KScreenWidth, 200);
    //设置视频播放的控制样式
    _mvPlayerCtrl.controlStyle = MPMovieControlStyleNone;
    _mvPlayerCtrl.view.backgroundColor = [UIColor blackColor];
    
    
    //视频播放界面底部添加阴影
    _mvPlayerCtrl.view.layer.shadowColor = [UIColor blackColor].CGColor;
    _mvPlayerCtrl.view.layer.shadowOpacity = 0.6;
    _mvPlayerCtrl.view.layer.shadowOffset = CGSizeMake(0, 1);
    _mvPlayerCtrl.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:_mvPlayerCtrl.view.bounds].CGPath;
    
    [self insertSubview:_mvPlayerCtrl.view atIndex:0];
}

#pragma mark -

-(NSString *)formatPlayTime:(NSTimeInterval) duration
{
    int minute = 0, hour = 0, second = duration;
    hour = second/3600;
    minute = (second%3600)/60;
    second = second%60;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second];
}

- (void)hiddenAnimated:(UIView *)view hide:(BOOL)hide
{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (hide){
                             view.alpha = 0;
                         }else{
                             view.hidden = NO;
                             view.alpha = 1;
                         }
                     }
                     completion:^(BOOL finished) {
                         
                         if (hide) {
                             view.hidden = YES;
                         }
                         
                     }];
}

#pragma mark - actions
-(IBAction)showOrHiddenPlayCtrlView
{
    BOOL hide = !self.mvBottomView.hidden;
    
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        [self hiddenAnimated:_mvTopView hide:YES];
        [self hiddenAnimated:_mvLeftView hide:YES];
        [self hiddenAnimated:_mvBottomView hide:hide];
    }else{
        [self hiddenAnimated:_mvTopView hide:hide];
        [self hiddenAnimated:_mvLeftView hide:hide];
        [self hiddenAnimated:_mvBottomView hide:hide];
    }
}

//收到声音改变后的通知
-(void)volumeChangeAction
{
    float volume = [MPMusicPlayerController applicationMusicPlayer].volume;
    _volumeSlider.value = volume;
    if (volume > 0) {
        [_volumeButton setImage:[UIImage imageNamed:@"volume"] forState:UIControlStateNormal];
    }else{
        [_volumeButton setImage:[UIImage imageNamed:@"volume_mute"] forState:UIControlStateNormal];
    }
}

//滑块改变音量
-(void)resetMovieVolume:(WXSlider *)volumeSlider
{
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:volumeSlider.value];
}

//点击静音按钮
- (IBAction)volumeButtonAction:(UIButton *)sender {
    if ([MPMusicPlayerController applicationMusicPlayer].volume > 0) {
        _lastVolume = [MPMusicPlayerController applicationMusicPlayer].volume;
        [MPMusicPlayerController applicationMusicPlayer].volume = 0;
        _volumeSlider.value = 0;
    }else{
        [MPMusicPlayerController applicationMusicPlayer].volume = _lastVolume;
        _volumeSlider.value = _lastVolume;
    }
}

#pragma mark - 用户控制
//视频缩放
- (IBAction)scaleMovieAction:(UIButton *)sender
{
    if (_mvPlayerCtrl.scalingMode == MPMovieScalingModeAspectFit) {
        _mvPlayerCtrl.scalingMode = MPMovieScalingModeAspectFill;
        [sender setImage:[UIImage imageNamed:@"zoomout"] forState:UIControlStateNormal];
    }else{
        _mvPlayerCtrl.scalingMode = MPMovieScalingModeAspectFit;
        [sender setImage:[UIImage imageNamed:@"zoomin"] forState:UIControlStateNormal];
    }
}

//拖拽进度条
- (void)playProgressChangeAction:(WXSlider *)sender {
    NSTimeInterval duration = sender.value*_mvPlayerCtrl.duration;
    [_mvPlayerCtrl setCurrentPlaybackTime:duration];
    self.leftTimeLabel.text = [self formatPlayTime:duration];
}


//用户点击暂停or播放
- (IBAction)changePlayState:(UIButton *)sender {
    if (_mvPlayerCtrl.playbackState == MPMoviePlaybackStatePaused) {
        [_mvPlayerCtrl play];
    }else if (_mvPlayerCtrl.playbackState == MPMoviePlaybackStatePlaying){
        [_mvPlayerCtrl pause];
    }else if (_mvPlayerCtrl.playbackState == MPMoviePlaybackStateStopped){
        [_mvPlayerCtrl play];
    }
}

#pragma mark - 收到通知设置属性
//跟踪播放进度
-(void)movieProgressDutationAction
{
    self.leftTimeLabel.text = [self formatPlayTime:_mvPlayerCtrl.currentPlaybackTime];
    _playerSlider.value = _mvPlayerCtrl.currentPlaybackTime/_mvPlayerCtrl.duration;
    
    //    NSLog(@"dutation");
    [self performSelector:@selector(movieProgressDutationAction) withObject:nil afterDelay:1];
}

//设置右边Label总时长
-(void)durationAvailableAction
{
    self.rightTimeLabel.text = [self formatPlayTime:_mvPlayerCtrl.duration];
}

//收到播放状态改变的通知
- (void)playStateDidChange:(NSNotification *)notification
{
    if (_mvPlayerCtrl.playbackState == MPMoviePlaybackStatePlaying){
        [self performSelector:@selector(movieProgressDutationAction) withObject:nil afterDelay:0.1];
        [_playButton setImage:[UIImage imageNamed:@"pause"]
                     forState:UIControlStateNormal];
    }else {
        //        NSLog(@"pause");
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(movieProgressDutationAction) object:nil];
        [_playButton setImage:[UIImage imageNamed:@"play"]
                     forState:UIControlStateNormal];
    }
}

//视频播放完成
- (void)playDidFinish:(NSNotification *)notification
{
    _playerSlider.value = 0;
    _mvPlayerCtrl.currentPlaybackTime = 0;
    self.leftTimeLabel.text = [self formatPlayTime:0];
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.movieTitleLabel.text = self.movieTitle;
    
    UIInterfaceOrientation toInterfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        _mvPlayerCtrl.view.frame = self.bounds;
        _mvCtrlView.frame = self.bounds;
        self.mvLeftView.hidden = self.mvBottomView.hidden;
        self.mvLeftView.alpha = self.mvBottomView.alpha;
        self.mvTopView.hidden = self.mvBottomView.hidden;
        self.mvTopView.alpha = self.mvBottomView.alpha;
    }else{
        _mvPlayerCtrl.view.frame = CGRectMake(0, 0, KScreenWidth, 200);
        _mvCtrlView.frame = CGRectMake(0, 0, KScreenWidth, 200);
        self.mvLeftView.hidden = YES;
        self.mvTopView.hidden = YES;
    }
}

@end
