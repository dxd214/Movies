//
//  IndexCollectionView.m
//  01 WXMovie
//
//  Created by lyb on 14-8-19.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "IndexCollectionView.h"
#import "IndexCell.h"
#import "MovieModel.h"

static NSString *iden = @"Cell_Index";

@implementation IndexCollectionView

- (id)initWithFrame:(CGRect)frame
{
    //创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置布局
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayOut.minimumLineSpacing = 0;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayOut];
    if (self) {

        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        //设置代理对象
        self.delegate =self;
        self.dataSource = self;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        
        //注册单元格
        [self registerClass:[IndexCell class] forCellWithReuseIdentifier:iden];
        
    }
    return self;
}

#pragma mark - UICollectionView 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _data.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    IndexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    
    MovieModel *model = self.data[indexPath.row];
    
    cell.stringURL = [model.images objectForKey:@"small"];
    
    return cell;
    
}

//设置每个item的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(self.pagWide, CGRectGetHeight(self.frame));
    
}

//设置item显示的位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

//        CGFloat top, left, bottom, right;
    CGFloat wid = (CGRectGetWidth(self.frame)-_pagWide)/2;
    return UIEdgeInsetsMake(0, wid, 0, wid);
    
    
}

//手指将要离开屏幕的时候调用的方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    //x方向的偏移量
    CGFloat offsetX = targetContentOffset->x;
    
    CGFloat x = offsetX + _pagWide/2;
    //页数
    int pageNum = x/_pagWide;
    
    //根据速度判断
    if (velocity.x > .6 && velocity.x < 1 && pageNum < self.data.count-1) {
        pageNum ++;
    }
    else if (velocity.x < -.6 && velocity.x > -1 && pageNum > 0) {
        pageNum --;
    }
    
    targetContentOffset->x = pageNum*_pagWide;
    
    //记录下当前的页数
    self.currentIndex = pageNum;
    
}

//点击item调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.currentIndex != indexPath.item) {
        //滑动到视图中间
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.currentIndex = indexPath.item;
    }
    
}


@end
