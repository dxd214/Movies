//
//  MovieListModel.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseModel.h"

/*
 {
    "name" : "被偷走的那五年",
    "id" : "43485",
    "grade" : "7.800000000046566",
    "highlight" : "白百合范玮琪大尺上镜 携手台湾魅力男星张孝全追寻爱的记忆",
    "logo" : "http://img3.126.net/movie/product/movie/137662435896110004_148_197.jpg"
 }
 */
@interface MovieListModel : BaseModel

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *movieId;
@property(nonatomic,copy)NSString *grade;
@property(nonatomic,copy)NSString *highlight;
@property(nonatomic,copy)NSString *logo;

@end
