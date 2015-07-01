//
//  PosterCollectionView.m
//  01 Movie
//
//  Created by lyb on 14-10-11.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "PosterCollectionView.h"
#import "PosterCell.h"

static NSString *iden = @"cell";

@implementation PosterCollectionView

- (id)initWithFrame:(CGRect)frame
{
    //创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置滑动方向
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置行之间的距离[单元格的水平最小距离]
    flowLayOut.minimumLineSpacing = 0;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayOut];
    if (self) {

        //设置代理对象
        self.delegate = self;
        self.dataSource = self;
        
        //隐藏滚动条
        self.showsHorizontalScrollIndicator = NO;
        
        //设置减速方式
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        
        //注册单元格
        [self registerClass:[PosterCell class] forCellWithReuseIdentifier:iden];
    }
    return self;
}

#pragma mark - collectionView dataSource
//返回的单元格的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _data.count;
}
//取单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    PosterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    
    //设置背景
    cell.contentView.backgroundColor = [UIColor blackColor];
    
    //将数据给cell
    cell.model = _data[indexPath.row];
    
    return cell;
    
}

//设置单元格的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    self.height
//    CGRectGetHeight(self.frame)   通过frame值取得高度
    
    CGSize size = CGSizeMake(self.pageWide, CGRectGetHeight(self.frame));
    
    return size;
}

//点击单元格调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.currentIndex == indexPath.item) {
        //翻转
        //通过indexPath取得cell
        PosterCell *cell = (PosterCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //关闭点击事件
        collectionView.allowsSelection = NO;
        //翻转动画
        [cell flipCell];
        
        //打开点击事件
        [collectionView performSelector:@selector(setAllowsSelection:) withObject:@YES afterDelay:.35];
    }else {
    
        //将点击的cell滑动到视图的中间
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        //记录下当前显示的cell
        self.currentIndex = indexPath.item;
        
    }
    
}

//设置cell的显示位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

//    CGFloat top, left, bottom, right  0
    
    CGFloat offsetX = (KScreenWidth - _pageWide)/2;
    
    UIEdgeInsets insert = UIEdgeInsetsMake(0, offsetX, 0, offsetX);
    
    return insert;
    
}

//手指离开屏幕后调用的方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

//    velocity表示x和y方向的速度
//    NSLog(@"velocity:%@",NSStringFromCGPoint(velocity));
//    *targetContentOffset是x和y方向的偏移量
//    NSLog(@"%@",NSStringFromCGPoint(*targetContentOffset));

    //手指离开屏幕以后x方向的偏移量
    CGFloat offsetX = targetContentOffset->x + _pageWide/2;
    
    int index = offsetX/_pageWide;
    
    if (velocity.x > 0.6 && velocity.x < 1 && index < self.data.count - 1) {
        index ++;
    }else if(velocity.x < -0.6 && velocity.x > -1 && index > 0 ){
        index --;
    }
    
    targetContentOffset -> x = index*_pageWide;
    
    //记录下正在中间的单元格
//    _currentIndex = index;
    self.currentIndex = index;
}
#pragma mark - 复用问题
//cell结束显示的时候调用的方法
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    //取得结束显示的cell
     PosterCell *pCell = (PosterCell *)cell;
    
    //将imgeView显示到上面
    [pCell.contentView bringSubviewToFront:pCell.imageView];
    
}




@end
