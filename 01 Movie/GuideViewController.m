//
//  GuideViewController.m
//  01 WXMovie
//
//  Created by lyb on 14-8-25.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "GuideViewController.h"
#import "MainTabbarController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

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

    //隐藏状态栏
    //iOS6
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //将图片存放到数组中
    NSArray *guideImages = @[@"guide1",
                             @"guide2",
                             @"guide3",
                             @"guide4",
                             @"guide5"
                             ];
    //将页数指示图片存放到数组中
    NSArray *progressImages = @[@"guideProgress1",
                                @"guideProgress2",
                                @"guideProgress3",
                                @"guideProgress4",
                                @"guideProgress5"
                                ];
    
    //创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //隐藏滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    //设置显示内容的尺寸
    scrollView.contentSize = CGSizeMake(KScreenWidth*guideImages.count, KScreenHeight);
    //设置分页效果
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    for (int i=0; i<guideImages.count; i++) {
        NSString *imgName1 = guideImages[i];
        NSString *imgName2 = progressImages[i];
        
        //视图背景图片
        UIImageView *guideImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*KScreenWidth, 0, KScreenWidth, KScreenHeight)];
        guideImg.image = [UIImage imageNamed:imgName1];
        [scrollView addSubview:guideImg];
        
        //设置页面指示图片
        UIImageView *progressImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth-173/2)/2, KScreenHeight-26/2-30, 173/2, 26/2)];
        progressImg.image = [UIImage imageNamed:imgName2];
        [guideImg addSubview:progressImg];
        
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

//    scrollView.contentOffset.x    x方向的偏移量
//    scrollView.contentSize.width  显示内容的宽度
//    scrollView.width
//    NSLog(@"scrollView.width：%f",scrollView.width);
//    NSLog(@"scrollView.contentSize.width: %f",scrollView.contentSize.width);
    
    //滑动到最后的时候
//    scrollView.contentOffset.x - (scrollView.contentSize.width-scrollView.width) = 0;
    
    CGFloat sub = scrollView.contentOffset.x - (scrollView.contentSize.width-scrollView.width);
    
    if (sub > 30) {
        
        //显示状态栏
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
        MainTabbarController *mainCtrl = [[MainTabbarController alloc] init];
        
        //取得当前的主window
//        [UIApplication sharedApplication].keyWindow
        /*
         如果视图view直接或者间接的显示window上，则可以通过self.view.window取得window对象
         */
        self.view.window.rootViewController = mainCtrl;
        
        mainCtrl.view.transform = CGAffineTransformMakeScale(.5, .5);
        
        //放大动画
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.5];
        
        mainCtrl.view.transform = CGAffineTransformIdentity;
        //关闭动画
        [UIView commitAnimations];
        
    }
    
}



@end
