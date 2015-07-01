//
//  MainTabbarController.m
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "MainTabbarController.h"
#import "NorhUSAViewController.h"
#import "NewsViewController.h"
#import "TOPViewController.h"
#import "CinemaViewController.h"
#import "MoreViewController.h"
#import "WXNavigationController.h"
#import "WXTabbarItem.h"

@interface MainTabbarController ()

@end

@implementation MainTabbarController

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

    //创建三级控制器
    [self _initCtrls];
 
    //自定义标签工具栏
    [self _initTabbar];
}

//创建三级控制器
- (void)_initCtrls {

    //1.创建视图控制器
    NorhUSAViewController *north = [[NorhUSAViewController alloc] init];
    NewsViewController *new = [[NewsViewController alloc] init];
    CinemaViewController *cinema = [[CinemaViewController alloc] init];
    TOPViewController *top = [[TOPViewController alloc] init];
    MoreViewController *more = [[MoreViewController alloc] init];
    //将视图控制器存放到数组中
    NSArray *viewCtrls = @[north,new,top,cinema,more];
    
    //2.创建导航控制器
    NSMutableArray *navCtrlArrarys = [[NSMutableArray alloc] initWithCapacity:viewCtrls.count];
    for (int i=0; i<viewCtrls.count; i++) {
        UIViewController *viewCtrl = viewCtrls[i];
        WXNavigationController *navCtrl = [[WXNavigationController alloc] initWithRootViewController:viewCtrl];
        [navCtrlArrarys addObject:navCtrl];
    }
    
    //3.创建标签控制器
    self.viewControllers = navCtrlArrarys;
    
}

//自定义标签工具栏
- (void)_initTabbar {

    //1.删除tabbar上的按钮
    NSArray *subViews = [self.tabBar subviews];
//    NSLog(@"subViews:%@",subViews);
    for(UIView *view in subViews) {
       //将UITabBarButton转换成类
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            //从tabbar上面删除
            [view removeFromSuperview];
        }
    }
    
    //2.设置背景颜色
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg_all"]];
    
    //3.添加选中图片
    _selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 2, 51, 45)];
    _selectedImg.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    [self.tabBar addSubview:_selectedImg];
    
    //4.添加自定义的按钮
    //创建数组存放图片的名字
    NSArray *imageName = @[@"movie_cinema.png",
                           @"msg_new.png",
                           @"start_top250.png",
                           @"icon_cinema.png",
                           @"more_setting.png"];
    //创建数组存放标题
    NSArray *titleArrary = @[@"电影",@"新闻",@"TOP",@"影院",@"更多"];
    
    //每个按钮的宽度
    CGFloat wide = KScreenWidth/5.0;
    
    //for循环创建按钮
    for (int i=0; i<imageName.count; i++) {
        NSString *name = imageName[i];
        NSString *title = titleArrary[i];
        CGRect frame = CGRectMake(i*wide, 0, wide, 49);
        WXTabbarItem *tabbarItem = [[WXTabbarItem alloc] initWithFrame:frame withImageName:name withTitle:title];
        tabbarItem.tag = i;
        [self.tabBar addSubview:tabbarItem];
        //添加点击事件
        [tabbarItem addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

//按钮的点击事件
- (void)itemAction:(WXTabbarItem *)item {

    //切换视图控制器
    self.selectedIndex = item.tag;
    
    //添加动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    
    _selectedImg.center = item.center;
    
    [UIView commitAnimations];
    
    
}



@end
