//
//  NewsModel.h
//  01 Movie
//
//  Created by lyb on 14-10-13.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

/*
 {
 "id" : 1491520,
 "type" : 0,
 "title" : "科幻大作《全面回忆》全新预告片发布",
 "summary" : "",
 "image" : "http://img31.mtime.cn/mg/2012/06/28/100820.21812355.jpg"
 }
 */

@interface NewsModel : BaseModel

//@property(nonatomic, retain)NSNumber *newsId;    //新闻的id
@property(nonatomic, copy)NSString *image;  //图片链接
@property(nonatomic, copy)NSString *summary;    //新闻的子标题
@property(nonatomic, copy)NSString *title;  //新闻标题
@property(nonatomic, retain)NSNumber *type; //新闻的类型

//- (void)setAttributes:(NSDictionary *)jsonDic;

@end
