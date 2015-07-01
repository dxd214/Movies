//
//  MovieDetailViewController.h
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface MovieDetailViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>{

    __weak IBOutlet UITableView *_tableView;

}

@property (nonatomic, retain) NSMutableArray *data; //存放显示的数据

@property (nonatomic, retain) NSIndexPath *selectIndexPath; //记录选中的单元格

@end
