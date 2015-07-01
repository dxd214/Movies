//
//  CinemaDetailViewController.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"

@class CinemaHeaderView;
@interface CinemaDetailViewController : BaseViewController {
    //场次表视图
    UITableView *_tableView;
    CinemaHeaderView *_cinemaView;  //影院的头视图
    
    /*
     结构：
      {
         “20130901”：[
            [场次modle1,场次modle2,场次modle3],
            [场次modle1,场次modle2,场次modle3],
            ...
         ],
         “20130902”:[
     
         ]
      }
     */
    NSMutableDictionary *_ticketData;
    
    /*
     结构:
     ["20130901","20130902",...]
     */
    NSArray *_dateArray;
    
    //选择的日期索引
    int _selectIndex;
}

@property(nonatomic,copy)NSString *cinemaId;

@end
