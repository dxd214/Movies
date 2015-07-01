//
//  TicketListModel.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseModel.h"
/*
 {
     "language" : "国语",
     "id" : "5720972",
     "status" : "0",
     "url" : null,
     "price" : "35",
     "showTime" : "09:05",
     "dimensional" : "2D",
     "partnerId" : "2",
     "listPrice" : "35",
     "closeTime" : "2013-09-01 08:05:00",
     "showDate" : "20130901",
     "isSellable" : "0",
     "hallSeatCount" : "155"
 }
 */
@interface TicketModel : BaseModel

@property(nonatomic,copy)NSString *language;
@property(nonatomic,copy)NSString *ticketId;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *showTime;
@property(nonatomic,copy)NSString *dimensional;
@property(nonatomic,copy)NSString *partnerId;
@property(nonatomic,copy)NSString *listPrice;
@property(nonatomic,copy)NSString *closeTime;
@property(nonatomic,copy)NSString *showDate;
@property(nonatomic,copy)NSString *isSellable;
@property(nonatomic,copy)NSString *hallSeatCount;

@end
