//
//  TicketCell.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketCell : UITableViewCell {
    NSMutableArray *_ticketItems;
}

@property(nonatomic,retain)NSArray *data;

@end
