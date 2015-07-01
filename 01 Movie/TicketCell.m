//
//  TicketCell.m
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "TicketCell.h"
#import "TicketItem.h"

@implementation TicketCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)_initViews {
    _ticketItems = [[NSMutableArray alloc] initWithCapacity:3];
    for (int i=0; i<3; i++) {
        TicketItem *tickItem = [[[NSBundle mainBundle] loadNibNamed:@"TicketItem" owner:self options:nil] lastObject];
        tickItem.tag = i;
        [tickItem addTarget:self action:@selector(ticketAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:tickItem];
        [_ticketItems addObject:tickItem];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i=0; i<_ticketItems.count; i++) {
        TicketItem *tickItem = _ticketItems[i];
        tickItem.frame = CGRectMake(tickItem.width*i, 0, self.width/3, self.height);
        
        if (i < _data.count) {
            tickItem.hidden = NO;
            tickItem.ticketModel = _data[i];
        } else {
            tickItem.hidden = YES;
        }
    }
}

- (void)ticketAction:(TicketItem *)ticketItem {
    NSLog(@"选中此场次购票");
}

@end
