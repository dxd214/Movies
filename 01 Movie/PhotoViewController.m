//
//  PhotoViewController.m
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCell.h"
#import "PhotoScrollView.h"

static NSString *iden = @"Photo_cell";

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        //不可以在这里对根视图操作
//        self.view.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"图片浏览";
    //设置导航栏黑色半透明
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏的样式 barStyle
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //设置导航栏半透明
    self.navigationController.navigationBar.translucent = YES;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x.png"]];
    
    //创建滑动视图
    [self _initView];
    
    //滑动到选中的视图
    [_collectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    //注册一个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"ClickImage" object:nil];
}

//通知响应的方法
- (void)notification:(NSNotification *)notf {

    _isHidden = !_isHidden;
    
    if (iOS7) {
        [self prefersStatusBarHidden];
    }else {
        [[UIApplication sharedApplication] setStatusBarHidden:_isHidden];
    }
    
    //隐藏导航栏和状态栏
    [self.navigationController setNavigationBarHidden:_isHidden animated:YES];
    
}

//iOS7以后使用的方法
- (BOOL)prefersStatusBarHidden {

    return _isHidden;
    
}

//创建滑动视图
- (void)_initView {

    //创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //修改方向为水平滑动
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置item的尺寸
    flowLayOut.itemSize = CGSizeMake(KScreenWidth, KScreenHeight-64);
    //设置行间距
    flowLayOut.minimumLineSpacing = 0;
    
    //创建collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:flowLayOut];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //设置分页效果
    _collectionView.pagingEnabled = YES;
    
    [self.view addSubview:_collectionView];
    
    //注册单元格
    [_collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:iden];
}

#pragma mark - UICollectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor greenColor];
    //将数据交给cell
    cell.imageURL = _data[indexPath.item];
    
    return cell;
    
}
#pragma mark - 当单元格消失时，使滑动视图恢复原图大小
//当单元格结束显示的时候调用的方法
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    //取得对应的cell
    PhotoCell *pCell = (PhotoCell *)cell;
   
    //获取到显示在cell上的scrollView
    PhotoScrollView *pScrollView = pCell.scrollView;
    
    //缩小到原图大小
    [pScrollView setZoomScale:1];
    
}



@end
