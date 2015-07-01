//
//  NewsModel.m
//  01 Movie
//
//  Created by lyb on 14-10-13.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

/*
 目的：将JSON文件中key所对应的value交给model的属性
*/

//- (void)setAttributes:(NSDictionary *)jsonDic {
//
////    self.image = [jsonDic objectForKey:@"image"];
//    //使用一个方法实现json文件中key和model属性值的对应关系
//    NSDictionary *mapDic = [self attributesMapDictionary];
//    
//    for (NSString *jsonKey in mapDic) {
//        //属性名newsId
//        NSString *modelArrt = [mapDic objectForKey:jsonKey];
//        //创建一个方法选择器
//        //方法一：
////        SEL sl = @selector(<#selector#>)
//        //方法二：将字符串转换成方法
////        NSSelectorFromString(<#NSString *aSelectorName#>)
//
//        //取得方法名
//        SEL action = [self stringToSEL:modelArrt];
//        
//        if ([self respondsToSelector:action]) {
//            //取得json文件中的值
//            id jsonValue = [jsonDic objectForKey:jsonKey];
//            
//            //如果jsonValue是空的
//            if ([jsonValue isKindOfClass:[NSNull class]]) {
//                jsonValue = @"";
//            }
//            
//            //调用方法设置
//            [self performSelector:action withObject:jsonValue];
//        }
//        
//        
//        
//    }
//    
//}
//
////实现sel方法
//- (SEL)stringToSEL:(NSString *)attName {
//    //属性名newsId --> setNewsId:
//    
//    //如果这样I会小写
////    [attName capitalizedString];
//    
//    //截取首字母改为大写
//    NSString *firstStr = [[attName substringToIndex:1] uppercaseString];
//    NSString *endStr = [attName substringFromIndex:1];
//    
//    NSString *setterMethod = [NSString stringWithFormat:@"set%@%@:",firstStr,endStr];
//   
//    //转换成方法
//    SEL setter = NSSelectorFromString(setterMethod);
//    
//    return setter;
//}

//- (NSDictionary *)attributesMapDictionary {
//
//    /*
//     model.newsId = [dic objectForKey:@"id"];
//     model.type = [dic objectForKey:@"type"];
//     model.title = [dic objectForKey:@"title"];
//     model.summary = [dic objectForKey:@"summary"];
//     model.image = [dic objectForKey:@"image"];
//     */
//    
//    /*
//     key:json文件中key名
//     value：model的属性值
//     */
//    //mapDic 映射关系
//    NSDictionary *mapDic = [NSDictionary dictionaryWithObjectsAndKeys:
//                            @"newsId",@"id",
//                            @"type",@"type",
//                            @"title",@"title",
//                            @"summary",@"summary",
//                            @"image",@"image",
//                            nil];
//    return mapDic;
//}

@end
