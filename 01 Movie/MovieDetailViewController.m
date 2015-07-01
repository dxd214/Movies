//
//  MovieDetailViewController.m
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieDetailModel.h"
#import "MovieHeaderView.h"
#import "CommentModel.h"
#import "CommentCell.h"
#import "WXDataService.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.title = @"电影详情";
        
        self.hidesBottomBarWhenPushed = YES;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //初始化视图
    [self _initView];
    
    //加载头视图的数据
    [self loadRequestData];
    
    //加载评论视图的数据
    [self  loadCommentData];
    
}

//初始化视图
- (void)_initView {
    
    //设置表视图的背景颜色
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    //设置分割线的颜色
    _tableView.separatorColor = [UIColor darkGrayColor];
    //cell的高度
    _tableView.rowHeight = 60;
    //设置代理方法
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

//加载头视图的数据
- (void)loadRequestData {
    
    NSDictionary *jsonDic = [WXDataService requestData:movie_detail];
    
    MovieDetailModel *movieDetail = [[MovieDetailModel alloc] initWithContentsOfDic:jsonDic];
    
    MovieHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MovieHeaderView" owner:self options:nil] lastObject];
    headerView.model = movieDetail;
    
    _tableView.tableHeaderView = headerView;
    //取消点击延迟高亮
    _tableView.delaysContentTouches = NO;
    
}

//加载评论列表的数据
- (void)loadCommentData {
    
    //创建数组
    _data = [[NSMutableArray alloc] init];
    
    NSDictionary *jsonData = [WXDataService requestData:movie_comment];
    
    NSArray *list = [jsonData objectForKey:@"list"];
    
    for (NSDictionary *dic in list) {
        CommentModel *model = [[CommentModel alloc] initWithContentsOfDic:dic];
        [_data addObject:model];
    }
    
    //刷新视图
    [_tableView reloadData];
    
}

#pragma mark - UITableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *iden = @"cell_comment";
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.model = _data[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.selectIndexPath.row && self.selectIndexPath != nil) {
        
        //取得显示的类容
        CommentModel *model = [_data objectAtIndex:indexPath.row];
        NSString *content = model.content;
//        NSLog(@"%f",[CommentCell cellHeight:content]);
        //计算高度
        return [CommentCell cellHeight:content];
    }
    
    return 60;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1、记录选中的单元格
    self.selectIndexPath = indexPath;
    
    //2.刷新视图
    //    [tableView reloadData];
    //刷新指定的多个单元格
    NSArray *indexPaths = @[indexPath];
    [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}



@end
