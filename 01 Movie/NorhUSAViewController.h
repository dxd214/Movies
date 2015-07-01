//
//  NorhUSAViewController.h
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseViewController.h"
@class PosterView;
@interface NorhUSAViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate> {

    UITableView *_tableView;    //表视图
    
    PosterView *_postView;  //海报视图
}

@property(nonatomic, retain)NSMutableArray *data;  //存放在表视图上显示的数据
@end
