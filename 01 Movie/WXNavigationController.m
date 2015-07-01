//
//  WXNavigationController.m
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "WXNavigationController.h"

@interface WXNavigationController ()

@end

@implementation WXNavigationController

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
    
    //设置导航栏的背景视图
    //获取当前设置的型号
    NSString *name = iOS7 ? @"nav_bg_all_64":@"nav_bg_all";
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:name] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏的字体样式和大小
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20],
                                                 NSForegroundColorAttributeName : [UIColor whiteColor]
                                                 }];
    
    //设置导航栏不穿透
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
}

//设置状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {

//调用当前正在显示的视图的这个方法
//    UIStatusBarStyle style = [self.topViewController preferredStatusBarStyle];
    
//    return style;
    
    return UIStatusBarStyleLightContent;    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
