//
//  TicketItem.m
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "TicketItem.h"
#import "TicketModel.h"

@implementation TicketItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setTicketModel:(TicketModel *)ticketModel {
    if (_ticketModel != ticketModel) {

        _ticketModel = ticketModel;
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //语种
    self.languageLabel.text = self.ticketModel.language;
    //场次类型
    self.typeLabel.text = self.ticketModel.dimensional;
    //场次时间
    self.timeLabel.text = self.ticketModel.showTime;
    //总座位数量
    self.hallSeatCountLabel.text = [NSString stringWithFormat:@"总座%@",self.ticketModel.hallSeatCount];
    //价格
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.ticketModel.price];
    
    //是否可售
    BOOL isSellable = [self.ticketModel.isSellable boolValue];
    if (isSellable) {
        self.alpha = 1;
        //设置是否可用
        [self setEnabled:YES];
    } else {
        self.alpha = 0.4;
        //设置不可用
        [self setEnabled:NO];
    }
}

@end
