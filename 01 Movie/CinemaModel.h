//
//  CinemaModel.h
//  01 Movie
//
//  Created by lyb on 14-10-17.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseModel.h"

/*
 "lowPrice" : "40.00",
 "grade" : "8.8",
 "coord" : "116.36047,40.01433",
 "distance" : null,
 "address" : "北京市海淀区学清路甲8号，圣熙8号购物中心五层西侧。",
 "name" : "嘉华国际影城",
 "id" : "1396",
 "msg" : null,
 "districtId" : "1015",
 "tel" : "010-82732228",
 "isSeatSupport" : "1",
 "isCouponSupport" : "1",
 "isImaxSupport" : "0",
 "isGroupBuySupport" : "0",
 "circleName" : "五道口"
 */

@interface CinemaModel : BaseModel


@property(nonatomic, copy) NSString *lowPrice;  //价格
@property(nonatomic, copy) NSString *grade;     //评分
@property(nonatomic, copy) NSString *coord;     //经纬度
@property(nonatomic, copy) NSString *address;   //地址
@property(nonatomic, copy) NSString *name;  //影院名称
@property(nonatomic, copy) NSString *cinemaID;  //电影院的ID
@property(nonatomic, copy) NSString *districtId;    //所在区域的ID
@property(nonatomic, copy) NSString *tel;   //影院电话
@property(nonatomic, copy) NSString *isSeatSupport; //是否支持在线选座
@property(nonatomic, copy) NSString *isCouponSupport;   //是否支持优惠券
@property(nonatomic, copy) NSString *isGroupBuySupport; //是否支持团购
@property(nonatomic, copy) NSString *isImaxSupport; //是否支持IMAX
@property(nonatomic, copy) NSString *circleName;    //附近商业区域的名字









@end
