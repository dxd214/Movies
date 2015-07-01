//
//  WXMoviePlayerView.h
//  WXMovie
//
//  Created by wei.chen on 13-9-17.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPMoviePlayerController;
@class WXSlider;

@interface WXMoviePlayerView : UIView {
    WXSlider *_playerSlider;     //播放进度
    WXSlider *_volumeSlider;    //声音
    float _lastVolume;
}

- (void)play;

@property(nonatomic, retain)MPMoviePlayerController *mvPlayerCtrl;
@property(nonatomic, retain)NSURL *movieUrl;
@property(nonatomic, copy) NSString *movieTitle;

@property (retain, nonatomic) IBOutlet UIView *mvCtrlView;
@property (retain, nonatomic) IBOutlet UIView *mvTopView;
@property (retain, nonatomic) IBOutlet UIView *mvLeftView;
@property (retain, nonatomic) IBOutlet UIView *mvBottomView;
@property (retain, nonatomic) IBOutlet UIButton *playButton;
@property (retain, nonatomic) IBOutlet UIButton *volumeButton;
@property (retain, nonatomic) IBOutlet UILabel *leftTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *rightTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *movieTitleLabel;

- (IBAction)scaleMovieAction:(UIButton *)sender;
- (IBAction)volumeButtonAction:(UIButton *)sender;
- (IBAction)changePlayState:(UIButton *)sender;
- (IBAction)showOrHiddenPlayCtrlView;

@end

