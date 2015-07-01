//
//  WXDataService.m
//  01 Movie
//
//  Created by lyb on 14-10-10.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "WXDataService.h"
#import "ASIFormDataRequest.h"

#define DOUBAN_URL @"https://api.douban.com"
#define WY163_URL @"http://piao.163.com"
/*
 json解析的框架:
 
 JSONKit   性能好
 SBJSON
 TouchJSON
 NSJSONSerialization  ios5.0新增的类，性能最好
 */
@implementation WXDataService


//请求数据工具方法
+ (id)requestData:(NSString *)fileName {

    /*
     JSON文件的解析：JSONKit.TouchJson.SBJson
     */
    //ios5以后有了系统的解析方法NSJSONSerialization
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    //获取JSON文件的数据
    NSData *data = [NSData dataWithContentsOfFile:filePath];
   
    /*
     NSJSONReadingMutableContainers  ：返回的是可变容器，NSMutableArray和NSMutableDic
     NSJSONReadingMutableLeaves :返回可变的字符串
     NSJSONReadingAllowFragments ：返回的数据最外层既不是数组也不是字典
     */
    
    id dataSource = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return dataSource;
    
}
//请求豆瓣的API接口
+ (void)requestDoubanAPI:(NSString *)subURL
                  params:(NSDictionary *)params
                  method:(NSString *)method
              completion:(CompletionHandle)block
{
    NSString *urlstring = [NSString stringWithFormat:@"%@%@",DOUBAN_URL,subURL];
    
    //请求网络//网址//参数
    [self requestAPI:urlstring
              params:params
              method:method
          completion:block];
}

//请求网易的API接口
+ (void)request163API:(NSString *)subURL
               params:(NSDictionary *)params
               method:(NSString *)method
           completion:(CompletionHandle)block
{
    NSString *baseParams = @"app_id=1&mobileType=iPhone&ver=2.6&channel=appstore&deviceId=9E89CB6D-A62F-438C-8010-19278D46A8A6&apiVer=6&city=110000";
    
    NSString *urlstring = [NSString stringWithFormat:@"%@/%@?%@",WY163_URL,subURL,baseParams];
    
    //请求网络
    [self requestAPI:urlstring
              params:params
              method:method
          completion:block];
}
+ (void)requestAPI:(NSString *)urlstring
            params:(NSDictionary *)params
            method:(NSString *)method
        completion:(CompletionHandle)block
{
    //1.网址
    NSURL *url = [NSURL URLWithString:urlstring];
    //2.请求
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.requestMethod = method;
    request.timeOutSeconds = 30;
    
    //处理请求参数
    if ([method isEqualToString:@"GET"])
    {
        
        NSMutableString *paramsstring = [NSMutableString string];
        NSArray *allkeys = params.allKeys;
        for (int i=0; i<params.count; i++)
        {
            NSString *key = allkeys[i];
            NSString *value = [params objectForKey:key];
            
            [paramsstring appendFormat:@"%@=%@",key,value];
            
            if (i < params.count -1)
            {
                [paramsstring appendString:@"&"];
            }
        }
        
        if (paramsstring.length > 0)
        {
            
            //将请求参数拼接到url后面
            NSString *paramsURL = [NSString stringWithFormat:@"%@?%@",urlstring,paramsstring];
            //重新设置请求的url
            request.url = [NSURL URLWithString:paramsURL];
            
        }
        
    }
    else if([method isEqualToString:@"POST"])
    {
        
        for (NSString *key in params)
        {
            NSString *value = [params objectForKey:key];
            
            //将请求参数添加到请求体中
            [request addPostValue:value forKey:key];
            
        }
        
    }
    
    //请求完成之后回调的block
    [request setCompletionBlock:^{
        //主线程调用的
        
        NSString *responsestring = request.responseString;
//        NSLog(@"url:%@",request.url);
//        NSLog(@"result=%@",responsestring);
        
        NSData *data = request.responseData;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        block(result);
        
    }];
    
    //请求失败调用的block
    [request setFailedBlock:^{
        NSLog(@"请求网络失败:%@",request.error);
    }];
    
    [request startAsynchronous];
}




@end
