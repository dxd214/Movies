//
//  TOPViewController.m
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "TOPViewController.h"
#import "Movie.h"
#import "TopCell.h"
#import "WXDataService.h"
#import "MovieDetailViewController.h"

@interface TOPViewController ()

@end

@implementation TOPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"TOP250";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //初始化视图
    [self _initView];
    
    //加载数据
    [self loadData];
    
}

//初始化视图
- (void)_initView {
    
    //创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //每个item的宽度
    CGFloat wd = (KScreenWidth-30)/3;
    //设置item的宽高
    flowLayOut.itemSize = CGSizeMake(wd, 140);
    //设置行距
    flowLayOut.minimumLineSpacing = 10;
    //设置每个item之间的距离
    flowLayOut.minimumInteritemSpacing = 10;
    
    //创建collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64-49) collectionViewLayout:flowLayOut];
    //隐藏滚动条
    _collectionView.showsVerticalScrollIndicator = NO;
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    //注册cell
    //错误
    //    [_collectionView registerClass:[TopCell class] forCellWithReuseIdentifier:@"top_cell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"TopCell" bundle:Nil] forCellWithReuseIdentifier:@"top_cell"];
}

//加载数据
- (void)loadData {
    
    NSDictionary *dic = [WXDataService requestData:top250];
    NSArray *arrary = [dic objectForKey:@"subjects"];
    
    self.data = [NSMutableArray arrayWithCapacity:arrary.count];
    
    for (NSDictionary *subject in arrary) {
        //将字典中数据交给model
        Movie *movie = [[Movie alloc] initWithContentsOfDic:subject];
//        Movie *movie = [[Movie alloc] init];
//        movie.rating = [subject objectForKey:@"rating"];
//        movie.images = [subject objectForKey:@"images"];
//        movie.movieID = [subject objectForKey:@"id"];
//        movie.title = [subject objectForKey:@"title"];
//        movie.year = [subject objectForKey:@"year"];
        
        [self.data addObject:movie];
    }
    
    //刷新视图
    [_collectionView reloadData];
}

#pragma mark - UICollectionView dataSouce
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _data.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"top_cell" forIndexPath:indexPath];
    cell.model = [_data objectAtIndex:indexPath.item];
    return cell;
    
}

//设置显示的位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 5, 0, 5);
    
}

//点击item响应的事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieDetailViewController *detailCtl = [[MovieDetailViewController alloc] initWithNibName:@"MovieDetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailCtl animated:YES];
    
}

@end
