//
//  WXDataService.h
//  01 Movie
//
//  Created by lyb on 14-10-10.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CompletionHandle) (id result);
/*
 类描述：
 提供数据的工具类
 */
@interface WXDataService : NSObject


//请求数据工具方法
+ (id)requestData:(NSString *)jsonName;


//请求豆瓣的API接口
+ (void)requestDoubanAPI:(NSString *)subURL
                  params:(NSDictionary *)params
                  method:(NSString *)method
              completion:(CompletionHandle)block;

//请求网易的API接口
+ (void)request163API:(NSString *)subURL
               params:(NSDictionary *)params
               method:(NSString *)method
           completion:(CompletionHandle)block;
@end
