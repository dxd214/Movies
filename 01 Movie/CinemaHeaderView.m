//
//  CinemaHeaderView.m
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "CinemaHeaderView.h"
#import "CinemaModel.h"
#import "MovieTableView.h"
#import "MovieListModel.h"

@implementation CinemaHeaderView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    //设置单元格的行高
    _movieTableView.rowHeight = 90;
    
    //当前对象作为MovieTableView的代理对象
    _movieTableView.mtDelegate = self;
}

//设置电影列表数据
- (void)setMovieList:(NSArray *)movieList {
    if (_movieList != movieList)
    {
        _movieList = movieList;
    }
    
    if (self.movieList.count > 0) {
        //将影院列表数据赋给 图片浏览tableView
        _movieTableView.data = self.movieList;
        //刷新tableView
        [_movieTableView reloadData];
        
        
        MovieListModel *movieModel = [self.movieList objectAtIndex:0];
        //刷新电影标题
        [self refreshMovieView:movieModel];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //填充数据
    //影院名称
    self.cinemaLabel.text = _cinemaModel.name;
    //影院地址
    self.adrressLabel.text = _cinemaModel.address;
    
}

//刷新电影的标题与评分
- (void)refreshMovieView:(MovieListModel *)movieModel {
    NSString *name = movieModel.name;
    NSString *grade = movieModel.grade;
    
    self.movieNameLabel.text = name;
    [self.movieNameLabel sizeToFit];
    
    self.ratingLabel.text = [NSString stringWithFormat:@"%0.1f",[grade floatValue]];
    self.ratingLabel.left = self.movieNameLabel.right+5;
}

#pragma mark - MovieTableView delegate
//图片浏览的图片被选中时调用
- (void)movieTableView:(MovieTableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath {
    
    MovieListModel *movieModel = _movieList[indexPath.row];
    //刷新电影标题
    [self refreshMovieView:movieModel];
}

#pragma mark - actions
//显示地图
- (IBAction)showMapAction:(id)sender {
    
}

//拨打电话
- (IBAction)callAction:(UIButton *)sender {
    NSString *tel = self.cinemaModel.tel;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否拨打?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:tel otherButtonTitles:nil, nil];
    [actionSheet showInView:self];
}

#pragma mark - UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSString *tel = self.cinemaModel.tel;
        NSString *urlstring = [NSString stringWithFormat:@"tel://%@",tel];
        NSURL *url = [NSURL URLWithString:urlstring];
        [[UIApplication sharedApplication] openURL:url];        
    }
}

@end
