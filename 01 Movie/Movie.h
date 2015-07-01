//
//  Movie.h
//  01 WXMovie
//
//  Created by lyb on 14-8-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

/*
 "rating" : {
 "stars" : "50",
 "average" : 9.5,
 "min" : 0,
 "max" : 10
 },
 "collect_count" : 659005,
 "images" : {
 "small" : "http:\/\/img3.douban.com\/view\/photo\/icon\/public\/p480747492.jpg",
 "large" : "http:\/\/img3.douban.com\/view\/movie_poster_cover\/lpst\/public\/p480747492.jpg",
 "medium" : "http:\/\/img3.douban.com\/view\/movie_poster_cover\/spst\/public\/p480747492.jpg"
 },
 "id" : "1292052",
 "alt" : "http:\/\/movie.douban.com\/subject\/1292052\/",
 "title" : "肖申克的救赎",
 "subtype" : "movie",
 "year" : "1994",
 "original_title" : "The Shawshank Redemption"
 */

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface Movie : BaseModel


@property(nonatomic, copy) NSString *title; //标题
@property(nonatomic, copy) NSString *movieID;    //id
@property(nonatomic, copy) NSString *year;   //年份
@property(nonatomic, retain) NSDictionary *images;   //图片URL
@property(nonatomic, retain) NSDictionary *rating;  //评分




@end
