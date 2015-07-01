//
//  CommentModel.h
//  01 WXMovie
//
//  Created by lyb on 14-8-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseModel.h"

/*
 {
 "userImage" : "http://img2.mtime.com/images/default/head.gif",
 "nickname" : "yangna988",
 "rating" : "9.0",
 "content" : "儿子很喜欢 一直期盼上映"
 }
 */

@interface CommentModel : BaseModel

@property (nonatomic, copy) NSString *content;      //评论内容
@property (nonatomic, copy) NSString *nickname;     //用户名
@property (nonatomic, copy) NSString *rating;       //评分
@property (nonatomic, copy) NSString *userImage;    //用户头像URL

@end
