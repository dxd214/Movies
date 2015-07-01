//
//  NewsCell.h
//  01 Movie
//
//  Created by lyb on 14-10-13.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;
@interface NewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property(nonatomic, retain)NewsModel *model;

@end
