//
//  TicketItem.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TicketModel;
/*
 类描述：场次视图
 */
@interface TicketItem : UIControl {
    
}

@property(nonatomic,retain)TicketModel *ticketModel;

@property (retain, nonatomic) IBOutlet UILabel *languageLabel;
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UILabel *hallSeatCountLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;

@end
