//
//  ImageListViewController.m
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "ImageListViewController.h"
#import "WXDataService.h"
#import "ImageListModel.h"
#import "ImageListCell.h"
#import "PhotoViewController.h"
#import "WXNavigationController.h"

@interface ImageListViewController ()

@end

@implementation ImageListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.hidesBottomBarWhenPushed = YES;
        
        self.title = @"厨子戏子痞子";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _data = [[NSMutableArray alloc] init];
    
    //创建滑动视图
    [self _initView];
    
    //加载数据
    [self _loadData];
}

//创建collectionView
- (void)_initView {

    //创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置item的尺寸
    flowLayOut.itemSize = CGSizeMake(80, 80);
    //设置行间距
    flowLayOut.minimumLineSpacing = 0;
    //设置item之间的距离
    flowLayOut.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) collectionViewLayout:flowLayOut];
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    //注册单元格
    [_collectionView registerClass:[ImageListCell class] forCellWithReuseIdentifier:@"ImageCell"];
    
}

//加载数据
- (void)_loadData {

    //加载数据
    NSArray *imageArrary = [WXDataService requestData:IMAGE_LIST];
    
    for (NSDictionary *dic in imageArrary) {
        ImageListModel *model = [[ImageListModel alloc] initWithContentsOfDic:dic];
        
        //将数据存放到数组中
        [_data addObject:model];
    }
    
    //刷新视图
    [_collectionView reloadData];
    
}

#pragma mark - UICollectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    ImageListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    //取得model
    ImageListModel *model = _data[indexPath.item];
    
    //将数据给cell
    cell.stringURL = model.image;
    
    return cell;
    

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    //创建可变数组
    NSMutableArray *mutArrary = [[NSMutableArray alloc] init];
    
    for (ImageListModel *model in _data) {
        NSString *imageString = model.image;
        [mutArrary addObject:imageString];
    }
    
    PhotoViewController *photoCtrl = [[PhotoViewController alloc] init];
    WXNavigationController *navCtrl = [[WXNavigationController alloc] initWithRootViewController:photoCtrl];
    //将数据传给下一个控制器
    photoCtrl.data = mutArrary;
    //将选中的下标传到下一个视图控制器
    photoCtrl.selectedIndexPath = indexPath;
    //设置photoCtrl是模态
    photoCtrl.isModal = YES;
    
    //通过模态弹入
    [self presentViewController:navCtrl animated:YES completion:NULL];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
