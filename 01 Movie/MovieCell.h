//
//  MovieCell.h
//  01 Movie
//
//  Created by lyb on 14-10-10.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieModel;
@class StarView;
@interface MovieCell : UITableViewCell {

    UIImageView *_imageView;    //电影图片
    StarView *_starView;    //星星视图
    
}

@property(nonatomic, retain)MovieModel *model;

@end
