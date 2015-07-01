//
//  MoviePlayerViewController.m
//  WXMovie
//
//  Created by wei.chen on 13-9-17.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MoviePlayerViewController.h"
#import "WXMoviePlayerView.h"

@interface MoviePlayerViewController ()

@end

@implementation MoviePlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WXMoviePlayerView *playerView = [[[NSBundle mainBundle] loadNibNamed:@"WXMoviePlayerView" owner:self options:nil] lastObject];
    playerView.movieUrl = self.movieUrl;
    playerView.movieTitle = self.movieTitle;
    [self.view addSubview:playerView];
    [playerView play];    
}

#pragma mark - 旋转控制
//IOS5 控制旋转的开关
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

//IOS6 返回支持旋转的方向
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
