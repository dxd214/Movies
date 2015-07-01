//
//  TOPViewController.h
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface TOPViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    
    UICollectionView *_collectionView;
    
}

@property(nonatomic, retain)NSMutableArray *data;  //存放显示的数据

@end
