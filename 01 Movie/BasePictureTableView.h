//
//  PosterTableView.h
//  WXMovie
//
//  Created by wei.chen on 13-8-31.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePictureTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSArray *data;
//当前选中的单元格IndexPath
@property(nonatomic,retain)NSIndexPath *selectedInexPath;

@end
