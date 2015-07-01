//
//  MovieDetailModel.m
//  01 WXMovie
//
//  Created by lyb on 14-8-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "MovieDetailModel.h"

@implementation MovieDetailModel

//- (NSDictionary *)attributesMapDictionary:(NSDictionary *)dic {
//
//    NSDictionary *mapDic = @{
//                             @"image" : @"image",
//                             @"titleCn" : @"titleCn",
//                             @"type" : @"type",
//                             @"directors" : @"directors",
//                             @"actors" : @"actors",
//                             @"release" : @"releaseDic",
//                             @"location" : @"location",
//                             @"date" : @"date",
//                             @"images" : @"images"
//                             };
//    return mapDic;
//}

// 目的：将JSON文件中key所对应的value交给model的属性

- (id)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self)
    {
        self.releaseDic = dic[@"release"];
    }
    
    return self;
}
@end
