//
//  Common.h
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#ifndef _1_Movie_Common_h
#define _1_Movie_Common_h

//屏幕的宽高尺寸
#define KScreenWidth   [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height

//设备型号的判断
#define iOS7            [[UIDevice currentDevice].systemVersion floatValue] >= 7.0

/*___________________________JSON文件的宏定义________________________________*/
#define US_BOX          @"us_box.json"  //列表视图的数据文件
#define NEWS_List       @"news_list.json"   //新闻列表界面
#define NEWS_WEB        @"news_detail.json" //网页显示的内容
#define IMAGE_LIST      @"image_list.json"  //图片列表视图
#define  top250         @"top250.json"   //top模块显示的数据
#define  movie_detail   @"movie_detail.json" //电影详情头视图
#define  movie_comment  @"movie_comment.json"    //电影评论列表
#define  Cinema_List    @"cinema_list.json"    //电影院列表文件
#define  District_List  @"district_list.json"  //电影院的区名文件

/*_____________________________三色值宏定义__________________________________*/
#define rgb(r,g,b,a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/*_________________请求数据url_________________________*/
#define usbox_url @"/v2/movie/us_box"
#define top250_url @"/v2/movie/top250"
#define cinema_list_url @"/m/cinema/list.html"
#define schedule_url @"/m/cinema/schedule.html"

//安全释放
#define WXRelease(obj) [obj release];obj = nil;

////////////////////////////////////////////////////////////////////////
//设置是否调试模式
#define WXDEBUG 0

#if WXDEBUG
#define WXLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define WXLog(xx, ...)  ((void)0)
#endif // #ifdef DEBUG
////////////////////////////////////////////////////////////////////////

#endif
