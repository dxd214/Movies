//
//  PosterView.m
//  01 Movie
//
//  Created by lyb on 14-10-11.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "PosterView.h"
#import "PosterCollectionView.h"
#import "IndexCollectionView.h"
#import "MovieModel.h"


//头视图的高度
#define KHeaderViewHeight 100

//电影标题的高度
#define KFooterHeight  30

@implementation PosterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建头视图
        [self _initheaderView];
        
        //创建在头视图上显示的滚动视图
        [self _initIndexTableView];
        
        //创建海报视图
        [self _initPosterView];
        
        //创建显示电影标题的label
        [self _initFooterView];
        
        //创建灯光视图
        [self _initLightView];
        
        //将头视图放到最前面
        [self bringSubviewToFront:_headerView];
        
        //添加轻扫的手势
        _swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        //设置清扫的方向
        _swipe.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:_swipe];
        
        //KVO观察两个滑动视图的currentItem变化
        [_posterCollectionView addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:NULL];
        [_indexView addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:NULL];
        
    }
    return self;
}

#pragma mark - KVO 观察方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    
    //选中的item下标
    NSInteger selcteItem = [[change objectForKey:@"new"] integerValue];
//    NSLog(@"%ld",selcteItem);
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:selcteItem inSection:0];
    
    if (object == _posterCollectionView && selcteItem != _indexView.currentIndex) {
        
        [_indexView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        //更新_indexTable的选中值
        _indexView.currentIndex = selcteItem;
    }
    else if (object == _indexView && selcteItem != _posterCollectionView.currentIndex) {
        
        [_posterCollectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        //更新_posterTable的选中值
        _posterCollectionView.currentIndex = selcteItem;
        
    }
    
    MovieModel *model = self.data[selcteItem];
    _footerlabel.text = model.title;
    
}
#pragma mark - UI界面设计
//创建头视图
- (void)_initheaderView {

    //创建图片并且设置拉伸点
    UIImage *img = [UIImage imageNamed:@"indexBG_home"];
    img = [img stretchableImageWithLeftCapWidth:0 topCapHeight:3];
    //添加到头视图上显示
    _headerView = [[UIImageView alloc] initWithImage:img];
    _headerView.frame = CGRectMake(0, -KHeaderViewHeight, KScreenWidth, KHeaderViewHeight + 26);
    //开启触摸响应
    _headerView.userInteractionEnabled = YES;
    [self addSubview:_headerView];
    
    //添加箭头按钮
    UIButton *arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowButton.tag = 101;
    //设置按钮显示的图片
    [arrowButton setImage:[UIImage imageNamed:@"down_home@2x"] forState:UIControlStateNormal];
    [arrowButton setImage:[UIImage imageNamed:@"up_home@2x"] forState:UIControlStateSelected];
    arrowButton.frame = CGRectMake((KScreenWidth-15)/2, KHeaderViewHeight + 26-20, 15, 15);
    //添加点击事件
    [arrowButton addTarget:self action:@selector(arrowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:arrowButton];
    
}

//创建在头视图上显示的滚动视图
- (void)_initIndexTableView {

    _indexView = [[IndexCollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KHeaderViewHeight)];
//    indexView.backgroundColor = [UIColor orangeColor];
    //设置一页宽度
    _indexView.pagWide = 75;
    [_headerView addSubview:_indexView];
    
}

//创建海报视图
- (void)_initPosterView {

    //创建海报视图
    _posterCollectionView = [[PosterCollectionView alloc] initWithFrame:CGRectMake(0, 26, KScreenWidth, KScreenHeight-64-26-49-KFooterHeight)];
    _posterCollectionView.pageWide = 220;
    [self addSubview:_posterCollectionView];
    
    
}

//创建显示电影标题的label
- (void)_initFooterView {

    _footerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-KFooterHeight, KScreenWidth, KFooterHeight)];
    //设置背景颜色
    _footerlabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"poster_title_home"]];
    //设置字体属性
    _footerlabel.textColor = [UIColor whiteColor];
    _footerlabel.font = [UIFont systemFontOfSize:16];
    _footerlabel.text = @"电影的标题";
    _footerlabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_footerlabel];
    
}

//创建灯光视图
- (void)_initLightView {

    //创建image
    UIImage *img = [UIImage imageNamed:@"light"];
    //创建左侧的图片
    UIImageView *leftImg = [[UIImageView alloc] initWithImage:img];
    leftImg.frame = CGRectMake(15, 0, 124, 204);
    [self addSubview:leftImg];
    
    //创建右侧的图片
    UIImageView *rightImg = [[UIImageView alloc] initWithImage:img];
    rightImg.frame = CGRectMake(self.width-15-124, 0, 124, 204);
    [self addSubview:rightImg];
    
}

//显示视图
- (void)_showHeaderView {

    if (_maskView == nil) {
        //添加模糊视图
        _maskView = [[UIControl alloc] initWithFrame:self.bounds];
        //设置背景颜色
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
        [self insertSubview:_maskView belowSubview:_headerView];
        [_maskView addTarget:self action:@selector(maskAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //开始动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.35];
    
    _headerView.top += KHeaderViewHeight;
    
    [UIView commitAnimations];
    
    //设置button的selected属性值
    UIButton *button = (UIButton *)[_headerView viewWithTag:101];
    button.selected = !button.selected;
    
    //显示模糊视图
    _maskView.hidden = NO;
    //禁用手势
    _swipe.enabled = NO;
    
}

//隐藏视图
- (void)_hideHeaderView {

    //开始动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.35];
    
    _headerView.top -= KHeaderViewHeight;
    
    [UIView commitAnimations];
    
    //设置button的selected属性值
    UIButton *button = (UIButton *)[_headerView viewWithTag:101];
    button.selected = !button.selected;
    
    //隐藏模糊视图
    _maskView.hidden = YES;
    //开启手势
    _swipe.enabled = YES;
}
#pragma mark - 响应事件
//按钮的响应事件
- (void)arrowButtonAction:(UIButton *)button {

    if (button.selected == NO) {
        //显示视图
        [self _showHeaderView];
    }else {
        //隐藏视图
        [self _hideHeaderView];
    }
}

//手势响应事件
- (void)swipeAction:(UISwipeGestureRecognizer *)swipe {

    //显示头视图
    [self _showHeaderView];
    
}

//模糊视图点击响应事件
- (void)maskAction:(UIControl *)ctr {

    //隐藏视图
    [self _hideHeaderView];
    
}
#pragma mark - 加载数据
//加载数据的方法
- (void)loadData:(NSArray *)data {

    self.data = data;
    
    //将数据交给_posterCollectionView
    _posterCollectionView.data = data;
    [_posterCollectionView reloadData];
    //将数据交给_indexView
    _indexView.data = data;
    [_indexView reloadData];
    
    //    设置电影标题的显示
    if (self.data.count > 0) {
        MovieModel *model = [self.data objectAtIndex:0];
        _footerlabel.text = model.title;
    }
    
}

@end
