//
//  PosterView.h
//  01 Movie
//
//  Created by lyb on 14-10-11.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PosterCollectionView;
@class IndexCollectionView;

@interface PosterView : UIView {

    UIImageView *_headerView;   //头视图
    UIControl *_maskView;   //模糊视图
    UISwipeGestureRecognizer *_swipe;    //轻扫手势
    PosterCollectionView *_posterCollectionView;
    IndexCollectionView *_indexView;
    UILabel *_footerlabel;
}

@property(nonatomic, retain)NSArray *data;

//加载数据的方法
- (void)loadData:(NSArray *)data;

@end
