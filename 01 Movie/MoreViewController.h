//
//  MoreViewController.h
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface MoreViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate> {

    UITableView *_tableView;
    NSArray *_data;
    NSArray *_imageNames;
    
    long long sum;  //用于存放图片的缓存大小   单位：字节
}

@end
