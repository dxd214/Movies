//
//  CinemaDetailViewController.m
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "CinemaDetailViewController.h"
#import "CinemaHeaderView.h"
#import "CinemaModel.h"
#import "MovieListModel.h"
#import "TicketModel.h"
#import "TicketCell.h"
#import "WXSegment.h"
#import "WXDataService.h"
#import "UIUtils.h"

@interface CinemaDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CinemaDetailViewController




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建tableView
    [self _initTableView];
    
    //显示正在加载
    [super showHUD:@"正在加载..."];
    _tableView.hidden = YES;
    
    //加载数据
    [self _loadCinemaData];
}

- (void)_initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-20-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = self.view.backgroundColor;
    //设置单元格的高度
    _tableView.rowHeight = 50;
    //去掉单元格的分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //去掉垂直滚动条
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    //创建头视图
    _cinemaView = [[[NSBundle mainBundle] loadNibNamed:@"CinemaHeaderView" owner:self options:nil] lastObject];
    
    _tableView.tableHeaderView = _cinemaView;
}

- (void)_loadCinemaData {
    
    NSDictionary *params = @{@"cinema_id": self.cinemaId};
    
    [WXDataService request163API:schedule_url params:params method:@"POST" completion:^(id result) {
        
        [self _afterLoadData:result];
        
    }];
}

- (void)_afterLoadData:(NSDictionary *)jsonData {
    _tableView.hidden = NO;
    
    /*__________________1.解析影院数据________________________*/
    NSDictionary *cinemaDic = [jsonData objectForKey:@"cinema"];
    CinemaModel *cinemaModel = [[CinemaModel alloc] initWithContentsOfDic:cinemaDic];
    
    /*__________________2.解析电影列表数据________________________*/
    NSArray *movieList = [jsonData objectForKey:@"movieList"];
    NSMutableArray *movieModels = [NSMutableArray arrayWithCapacity:movieList.count];
    for (NSDictionary *movieDic in movieList) {
        MovieListModel *mm = [[MovieListModel alloc] initWithContentsOfDic:movieDic];
        [movieModels addObject:mm];
    }
    
    /*__________________3.刷新views________________________*/
    _cinemaView.cinemaModel = cinemaModel;
    _cinemaView.movieList = movieModels;
    self.title = cinemaModel.name;
    
    
    /*__________________4.解析、整理场次数据________________________*/
    /*
     结构：
     {
     “20130901”：[
     [场次modle1,场次modle2,场次modle3],
     [场次modle1,场次modle2,场次modle3],
     ...
     ],
     “20130902”:[
     
     ]
     }
     */
    //创建一个存储数据的字典对象
    if (_ticketData == nil) {
        _ticketData = [[NSMutableDictionary alloc] init];
    }
    NSArray *ticketUnitList = [jsonData objectForKey:@"ticketUnitList"];
    for (NSDictionary *ticketDic in ticketUnitList) {
        //1.取得此场次的列表日期
        NSString *showDate = [ticketDic objectForKey:@"showDate"];
        //2.取得此日期的场次列表
        NSArray *ticketList = [ticketDic objectForKey:@"ticketList"];
        
        //3.创建二维数组,用于存储models
        NSMutableArray *ticketModels = [NSMutableArray array];
        [_ticketData setObject:ticketModels forKey:showDate];
        
        NSMutableArray *array2D = [ticketModels lastObject];
        for (int i=0; i<ticketList.count; i++) {
            NSDictionary *ticketDic = ticketList[i];
            //创建场次model
            TicketModel *ticketModel = [[TicketModel alloc] initWithContentsOfDic:ticketDic];
            
            if (array2D == nil || array2D.count == 3) {
                array2D = [NSMutableArray arrayWithCapacity:3];
                [ticketModels addObject:array2D];
            }
            
            [array2D addObject:ticketModel];
            

        }
    }
    
    //获取到所有的日期(未排序)
    NSArray *timeArray = [_ticketData allKeys];
    //对数组中的日期字符串排序
    _dateArray = [timeArray sortedArrayUsingSelector:@selector(compare:)];
  
    
    //刷新场次tableView
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_selectIndex >= _dateArray.count) {
        return 0;
    }
    
    //取得选中的日期："20130901"
    NSString *showDate = [_dateArray objectAtIndex:_selectIndex];
    /*
     取得日期对应的场次列表
     */
    NSArray *ticketArray = [_ticketData objectForKey:showDate];
    
    return ticketArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"ticketCell";
    
    TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[TicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    //取得选中的日期："20130901"
    NSString *showDate = [_dateArray objectAtIndex:_selectIndex];
    /*
     取得日期对应的场次列表
     */
    NSArray *ticketArray = [_ticketData objectForKey:showDate];
    
    cell.data = ticketArray[indexPath.row];
    
    return cell;
}

//返回组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSMutableArray *items = [NSMutableArray array];
    //"20130901"  --> "09月01日"
    for (NSString *dateString in _dateArray)
    {
        NSDate *date = [UIUtils dateFromString:dateString formate:@"yyyyMMdd"];
        NSString *formateString = [UIUtils stringFromDate:date formate:@"MM月dd日"];
        
        [items addObject:formateString];
    }
    
    WXSegment *sg = [[WXSegment alloc] initWithItems:items];
    //选中日期
    sg.selectedIndex = _selectIndex;
    [sg addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    return sg;
}

//返回组的头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

//日期选择的事件
- (void)segmentAction:(WXSegment *)sg {
    //记录选中日期的索引
    _selectIndex = sg.selectedIndex;
    
    //刷新数据，显示选中日期的场次列表
    [_tableView reloadData];
    
}


@end
