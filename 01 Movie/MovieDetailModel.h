//
//  MovieDetailModel.h
//  01 WXMovie
//
//  Created by lyb on 14-8-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseModel.h"

/*
 "image" : "http://img31.mtime.cn/mt/2012/06/28/131128.94272291.jpg",
 "titleCn" : "摩尔庄园2海妖宝藏",
 "titleEn" : "Legend of The Moles-Treasure of Scylla",
 "rating" : "7.7",
 "year" : "2012",
 "content" : "摩尔庄园大电影系列第二部：《摩尔庄园海妖宝藏》继续讲述快乐、勇敢、热爱和平的小摩尔们战胜邪恶",
 "type" : [ "动画", "动作", "奇幻", "冒险" ],
 "url" : "http://movie.mtime.com/157836/",
 "directors" : [ "刘可欣" ],
 "actors" : ["阿黄","阿龟","阿宇","阿红","凤姐"],
 "release" : {
 "location" : "中国",
 "date" : "2012-7-5"
 },
 "imageCount" : 16,
 "images" : [ "http://img31.mtime.cn/pi/2012/06/14/193026.85486289.jpg",
 "http://img31.mtime.cn/pi/2012/06/14/193028.65049217.jpg",
 "http://img31.mtime.cn/pi/2012/06/14/193029.38103098.jpg",
 "http://img31.mtime.cn/pi/2012/06/14/193030.29253345.jpg" ],

 */

@interface MovieDetailModel : BaseModel


@property(nonatomic, copy) NSString *date;  //日期
@property(nonatomic, copy) NSString *image; //显示电影图片
@property(nonatomic, copy) NSString *location;  //地区
@property(nonatomic, copy) NSString *titleCn;   //电影名称
@property(nonatomic, retain) NSArray *actors;   //演员
@property(nonatomic, retain) NSArray *directors;    //导演
@property(nonatomic, retain) NSArray *images;   //图片URL
@property(nonatomic, retain) NSArray *type; //电影类型
@property(nonatomic, retain) NSDictionary *releaseDic;  //上映信息







@end
