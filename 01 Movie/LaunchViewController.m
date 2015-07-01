//
//  LaunchViewController.m
//  01 WXMovie
//
//  Created by lyb on 14-8-25.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "LaunchViewController.h"
#import "MainTabbarController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //设置背景图片
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default"]];
    
    //加载图片
    [self _loadImageView];
    
    //视图动画
    [self _showAnimation];
}

- (void)_loadImageView {
     

    //计算图片的宽高
    CGFloat width = KScreenWidth/4.0;
    CGFloat height = KScreenHeight/6.0;
    
    //图片的总数
    int count = 16;
    
    int x=0, y=0;
    
    _imageArrary = [[NSMutableArray alloc] init];
    
    for (int i=0; i<count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        //设置显示的图片
        NSString *imageName = [NSString stringWithFormat:@"%d@2x",i+1];
        imgView.image = [UIImage imageNamed:imageName];
        //设置图片的透明度
        imgView.alpha = 0;
        [_imageArrary addObject:imgView];
        [self.view addSubview:imgView];
        
        if (i<4)
        {
            y=0;    x=i*width;
        }
        else if (i<9)
        {
            //i...4
            x=KScreenWidth-width;   y=(i-3)*height;
        }
        else if (i<12)
        {
            //x-3   3-x
            //i...9
            y=KScreenHeight-height; x= KScreenWidth-(i-7)*width;
        }
        else
        {
            //i...12
            x=0;    y=KScreenHeight-(i-10)*height;
        }
        
        imgView.left = x;
        imgView.top = y;
    }

}

- (void)_showAnimation
{

    if (_index >= _imageArrary.count)
    {
        //显示主界面
        [self _showMainView];
        //跳出递归
        return;
    }
    
    //取得图片
    UIImageView *imageView = [_imageArrary objectAtIndex:_index];
    [UIView animateWithDuration:.1 animations:^{
         imageView.alpha = 1;
    } completion:^(BOOL finished) {
        _index ++;
        //等动画结束的以后，递归调用显示下一张图片
        [self performSelector:@selector(_showAnimation) withObject:nil afterDelay:.1];
    }];
    
}

//显示主界面
- (void)_showMainView
{

    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.view.window.rootViewController = [[MainTabbarController alloc] init];
    
}



@end
