//
//  PosterCollectionView.h
//  01 Movie
//
//  Created by lyb on 14-10-11.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PosterCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, assign)CGFloat pageWide;   //每一个cell的宽度，每一页的宽度
@property(nonatomic, retain)NSArray *data;  //存放滑动视图的数据
@property(nonatomic, assign)NSInteger currentIndex; //显示在正中间的单元格

@end
