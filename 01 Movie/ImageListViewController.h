//
//  ImageListViewController.h
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface ImageListViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate> {

    UICollectionView *_collectionView;
    
}

@property(nonatomic, retain)NSMutableArray *data;

@end
