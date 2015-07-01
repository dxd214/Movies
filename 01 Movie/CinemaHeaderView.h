//
//  CinemaHeaderView.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieTableView.h"

@class CinemaModel;

@interface CinemaHeaderView : UIView<MovieTableViewDelegate,UIActionSheetDelegate>

//影院的model
@property(nonatomic,retain)CinemaModel *cinemaModel;
//电影列表
@property(nonatomic,retain)NSArray *movieList;

#pragma mark - views
@property (retain, nonatomic) IBOutlet UILabel *cinemaLabel;
@property (retain, nonatomic) IBOutlet UILabel *adrressLabel;
@property (retain, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *ratingLabel;
@property (retain, nonatomic) IBOutlet MovieTableView *movieTableView;

- (IBAction)showMapAction:(id)sender;
- (IBAction)callAction:(UIButton *)sender;

@end
