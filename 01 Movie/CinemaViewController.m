//
//  CinemaViewController.m
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "CinemaViewController.h"
#import "WXDataService.h"
#import "CinemaModel.h"
#import "CinemaCell.h"

@interface CinemaViewController ()

@end

@implementation CinemaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"影院";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _cinemaDictionary = [[NSMutableDictionary alloc] init];
    
    //创建导航栏上的按钮
    [self _initNavgiationItem];
    
    //初始化视图
    [self _initView];
    
    //加载数据
    [self _loadData];
}

#pragma mark - UI
//创建导航栏上的按钮
- (void)_initNavgiationItem {

    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置显示的图片
    [locationButton setImage:[UIImage imageNamed:@"movieLocationIcon@2x"] forState:UIControlStateNormal];
    locationButton.frame = CGRectMake(0, 0, 20, 20);
    [locationButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:locationButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)_initView {

    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.rowHeight = 70;
    //创建下拉刷新控件（iOS6以后才有的）
    UIRefreshControl *refreshCtrl = [[UIRefreshControl alloc] init];
    self.refreshControl = refreshCtrl;
    //设置下拉控件的标题
    refreshCtrl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    //添加响应事件
    [refreshCtrl addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
}

//下拉刷新响应事件
- (void)refreshAction {

    //刷新视图
    [self.tableView reloadData];
    
    //结束刷新
//    [self.refreshControl endRefreshing];
    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
    
}

#pragma mark - loadData
//加载数据
- (void)_loadData {

    //1.加载影院列表数据
    NSDictionary *jsonDic = [WXDataService requestData:Cinema_List];
    
    //取得cinemaList对应的数组
    /*
     [],[]
     */
    NSArray *cinemaList = [jsonDic objectForKey:@"cinemaList"];
    
    /*
     最后的数据形式
     {
     "区ID123": [model1,model2,model3];
     "区ID123": [model1,model2,model3];
     "区ID": [model1,model2,model3];
     }
     */
    
    for (NSDictionary *dic in cinemaList) {
        CinemaModel *model = [[CinemaModel alloc] initWithContentsOfDic:dic];
        //取得此model的区ID
        NSString *districtId = model.districtId;
        
        //取得数组
        NSMutableArray *cinemaArrary = [_cinemaDictionary objectForKey:districtId];
        
        if (cinemaArrary == nil) {
            //创建存放model的数组
            cinemaArrary = [NSMutableArray array];
            [_cinemaDictionary setObject:cinemaArrary forKey:districtId];
        }
        //在数组中添加model
        [cinemaArrary addObject:model];
        
    }
    
    //2.加载District_List数据
    NSDictionary *districtDic = [WXDataService requestData:District_List];
    _districtArrary = [districtDic objectForKey:@"districtList"];
    
    
    //刷新视图
    [self.tableView reloadData];
    
}

/*
 最后的数据形式
 {
 "区ID": [model1,model2,model3];
 "区ID": [model1,model2,model3];
 "区ID": [model1,model2,model3];
 }
 */
//NSMutableDictionary *_cinemaDictionary;


/*
 [
 {name:东城区， id ： 123},
 {name:东城区， id ： 123},
 ]
 */
//NSArray *_districtArrary;

#pragma mark - UITableView dataSource
//1.设置组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

//    return 3;
    return _districtArrary.count;
}

//2.设置每一组有多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    BOOL signal = close[section];
    
    if (signal == NO) {
        return 0;
    }
    
    //取得字典
    NSDictionary *dic = [_districtArrary objectAtIndex:section];
    //取得对应的区ID
    NSString *districtID = [dic objectForKey:@"id"];
    
    //根据区ID找到对应的数组
    NSArray *arrary = [_cinemaDictionary objectForKey:districtID];
    
    return arrary.count;
    
}
//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *iden = @"cell_Cinema";
    
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil) {
        cell = [[CinemaCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    //取得字典
    NSDictionary *dic = [_districtArrary objectAtIndex:indexPath.section];
    //取得对应的区ID
    NSString *districtID = [dic objectForKey:@"id"];
    
    //根据区ID找到对应的数组
    NSArray *arrary = [_cinemaDictionary objectForKey:districtID];
    
    CinemaModel *model = [arrary objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = model.name;

    cell.model = model;
    
    return cell;
}

//设置组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    //取得需要显示的数据（区名）
    NSDictionary *districtDic = [_districtArrary  objectAtIndex:section];
    NSString *name = [districtDic objectForKey:@"name"];
    
    UIControl *titleView = [[UIControl alloc] initWithFrame:CGRectZero];
    titleView.tag = section;
    titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hotMovieBottomImage@2x"]];
    [titleView addTarget:self action:@selector(sectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = name;
    [titleLabel sizeToFit];
    
    [titleView addSubview:titleLabel];
    
    return titleView;
    
}

//设置组的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 40;
}

//头视图的点击事件
- (void)sectionAction:(UIControl *)contrl {

    //取得点击的组
    long section = contrl.tag;
    
    //切换开关状态
    close[section] = !close[section];
    
    //刷新视图
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
    
}

//按钮的点击事件
- (void)buttonAction:(UIButton *)button {

    NSLog(@"显示地图");
    
}


@end
