//
//  CinemaModel.m
//  01 Movie
//
//  Created by lyb on 14-10-17.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "CinemaModel.h"

@implementation CinemaModel

- (id)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self)
    {
        self.cinemaID = dic[@"id"];
    }
    
    return self;
}
@end
