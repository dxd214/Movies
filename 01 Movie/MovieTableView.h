//
//  MovieTableView.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BasePictureTableView.h"

@class MovieTableView;
@protocol MovieTableViewDelegate <NSObject>

//当图片被选中时调用
- (void)movieTableView:(MovieTableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath;

@end

@interface MovieTableView : BasePictureTableView

@property(nonatomic,assign)id<MovieTableViewDelegate> mtDelegate;  //代理对象

@end
