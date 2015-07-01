//
//  MovieModel.h
//  01 Movie
//
//  Created by lyb on 14-10-10.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {
 "rating" : {
 "stars" : "40",
 "average" : 7.3,
 "min" : 0,
 "max" : 10
 },
 "collect_count" : 49,
 "images" : {
 "small" : "http:\/\/img3.douban.com\/view\/photo\/icon\/public\/p1943399384.jpg",
 "large" : "http:\/\/img3.douban.com\/view\/photo\/photo\/public\/p1943399384.jpg",
 "medium" : "http:\/\/img3.douban.com\/view\/photo\/thumb\/public\/p1943399384.jpg"
 },
 "id" : "3170961",
 "alt" : "http:\/\/movie.douban.com\/subject\/3170961\/",
 "title" : "双枪",
 "subtype" : "movie",
 "year" : "2013",
 "original_title" : "2 Guns"
 }
 */

@interface MovieModel : NSObject

@property(nonatomic, retain)NSDictionary *rating;   //评分信息
@property(nonatomic, retain)NSDictionary *images;   //图片的URL
@property(nonatomic, copy)NSString *title;  //电影的标题
@property(nonatomic, copy)NSString *year;   //电影的出版年份
@property(nonatomic, copy)NSString *original_title; //电影的原标题





@end
