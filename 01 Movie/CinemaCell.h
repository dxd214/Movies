//
//  CinemaCell.h
//  01 Movie
//
//  Created by lyb on 14-10-17.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CinemaModel;
@interface CinemaCell : UITableViewCell {

    UILabel *_ratingLabel1; //显示评分的整数部分
    UILabel *_ratingLabel2; //显示评分的小树部分
    UILabel *_priceLabel;   //显示价格
    
    UIImageView *_seatIcon; //在线选座标识图
    UIImageView *_couponIcon;   //支持优惠券
    
}

@property(nonatomic, retain)CinemaModel *model;

@end
