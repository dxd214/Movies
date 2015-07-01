//
//  NorhUSAViewController.m
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "NorhUSAViewController.h"
#import "MovieModel.h"
#import "MovieCell.h"
#import "WXDataService.h"
#import "PosterView.h"

@interface NorhUSAViewController ()

@end

@implementation NorhUSAViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"北美榜";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建数组
    _data = [[NSMutableArray alloc] init];
    
    //创建导航栏上的按钮
    [self _initNavgationItem];
    
    //初始化电影列表视图
    [self _initTableView];
    
    //初始化海报视图
    [self _initPosterView];
    
    //加载数据
//    [self _loadData];
    [self performSelector:@selector(_loadData) withObject:nil afterDelay:.5];
}
#pragma mark - 加载数据
- (void)_loadData {
    
    /*
     json文件解析：JSONKit、SBJson、TouchJson
     */
    
    //    NSJSONSerialization iOS5以后可以使用
    //获取json文件的路径
    //    NSData *data = [NSData dataWithContentsOfFile:path];
    //
    //    /*
    //     NSJSONReadingMutableContainers :返回可变容器，NSMusicDirectory和NSMutableArray
    //     NSJSONReadingMutableLeaves :返回的是JSON对象中的字符串值为：NSMutableString
    //     NSJSONReadingAllowFragments :返回的文件最外层既不是数组也不是字典
    //     */
    //    NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
   
    //-------------------解析本地json------------------
    /*
    //加载数据
    NSDictionary *dicData = [WXDataService requestData:US_BOX];
    //取得subjects对应的value
    NSArray *subArrary = [dicData objectForKey:@"subjects"];
    
    //通过循环遍历
    for (NSDictionary *dic in subArrary) {
        NSDictionary *subDic = [dic objectForKey:@"subject"];
        //创建model对象
        MovieModel *model = [[MovieModel alloc] init];
        //将数据给model
        model.rating = [subDic objectForKey:@"rating"];
        model.images = [subDic objectForKey:@"images"];
        model.title = [subDic objectForKey:@"title"];
        model.year = [subDic objectForKey:@"year"];
        model.original_title = [subDic objectForKey:@"original_title"];
        
        //将model添加到数组中
        [_data addObject:model];
    }
    
    //刷新视图
    [_tableView reloadData];
    
    //海报视图加载数据
    [_postView loadData:_data];
    */
    [WXDataService requestDoubanAPI:usbox_url
                             params:nil
                             method:@"GET"
                         completion:^(id result)
    {
        //取得subjects对应的value
        NSArray *subArrary = [(NSDictionary *)result objectForKey:@"subjects"];
        
        //通过循环遍历
        for (NSDictionary *dic in subArrary) {
            NSDictionary *subDic = [dic objectForKey:@"subject"];
            //创建model对象
            MovieModel *model = [[MovieModel alloc] init];
            //将数据给model
            model.rating = [subDic objectForKey:@"rating"];
            model.images = [subDic objectForKey:@"images"];
            model.title = [subDic objectForKey:@"title"];
            model.year = [subDic objectForKey:@"year"];
            model.original_title = [subDic objectForKey:@"original_title"];
            
            //将model添加到数组中
            [_data addObject:model];
        }
        
        //刷新视图
        [_tableView reloadData];
        
        //海报视图加载数据
        [_postView loadData:_data];
    }];
}
//*_________________________初始化UI视图____________________________________*/
#pragma mark - UI设置
//创建导航栏上的按钮
- (void)_initNavgationItem {

    //1.创建按钮的父视图
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    
    //2.创建按钮
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮的隐藏属性
    button1.hidden = NO;
    button1.tag = 101;
    //设置背景图片
    [button1 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home@2x"] forState:UIControlStateNormal];
    button1.frame = buttonView.bounds;
    //设置显示的图片
    [button1 setImage:[UIImage imageNamed:@"list_home.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮的隐藏属性
    button2.hidden = YES;
    button2.tag = 102;
    //设置背景图片
    [button2 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home@2x"] forState:UIControlStateNormal];
    button2.frame = buttonView.bounds;
    //设置显示的图片
    [button2 setImage:[UIImage imageNamed:@"poster_home.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:button2];
    
    //2.显示到导航栏上
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
    
}

//初始化电影列表视图
- (void)_initTableView {

    //创建表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64-49) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 120;
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x.png"]];
    _tableView.hidden =  NO;
    //设置分割线的颜色
    _tableView.separatorColor = [UIColor grayColor];
    [self.view addSubview:_tableView];
    
}

//初始化海报视图
- (void)_initPosterView {

    _postView = [[PosterView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64-49)];
    _postView.hidden = YES;
    _postView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_postView];
    
}

#pragma mark - 响应事件
- (void)rightButtonAction:(UIButton *)button {
    
    //1.取得按钮的父视图
    UIView *buttonView = self.navigationItem.rightBarButtonItem.customView;
    
    //关闭点击
    buttonView.userInteractionEnabled = NO;
    
    //通过父视图取得两个按钮
    UIButton *button1 = (UIButton *)[buttonView viewWithTag:101];
    UIButton *button2 = (UIButton *)[buttonView viewWithTag:102];
    
    //切换两个按钮的隐藏属性
    button1.hidden = !button1.hidden;
    button2.hidden = !button2.hidden;
    
    //切换翻转方向
    UIViewAnimationTransition transition = button1.hidden ? UIViewAnimationTransitionFlipFromRight:UIViewAnimationTransitionFlipFromLeft;
    
    [self flipView:transition withForView:buttonView];
    
    //切换视图的hidden属性
    _tableView.hidden = !_tableView.hidden;
    _postView.hidden = !_postView.hidden;
    
    //调用自己的方法
    [self flipView:transition withForView:self.view];
    

    //开启按钮点击事件
    [buttonView performSelector:@selector(setUserInteractionEnabled:) withObject:@YES afterDelay:.5];
}

//视图翻转的方法
/*
 transition:翻转效果
 view：翻转的视图
 */
- (void)flipView:(UIViewAnimationTransition)transition withForView:(UIView *)view {
    
    [UIView beginAnimations:nil context:nil];
    //设置动画时间
    [UIView setAnimationDuration:.5];
    
    [UIView setAnimationTransition:transition forView:view cache:YES];
    
    [UIView commitAnimations];
    

}

#pragma mark - UITableView delegate
//返回cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *iden = @"cell_Movie";
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil) {
        cell = [[MovieCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        cell.backgroundColor = [UIColor clearColor];
    }
    //将数据交给cell
    cell.model = _data[indexPath.row];
    
    return cell;
    
}


@end
