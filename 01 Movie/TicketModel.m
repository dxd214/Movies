//
//  TicketListModel.m
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "TicketModel.h"

@implementation TicketModel


- (id)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self)
    {
        self.ticketId = dic[@"id"];
    }
    
    return self;
}
@end
