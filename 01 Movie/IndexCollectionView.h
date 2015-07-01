//
//  IndexCollectionView.h
//  01 WXMovie
//
//  Created by lyb on 14-8-19.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, assign)CGFloat pagWide;    //页面的宽度
@property(nonatomic, retain)NSArray *data;  //数据
@property(nonatomic, assign)NSInteger currentIndex;    //当前显示的页数

@end
