//
//  PhotoCell.h
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoScrollView;
@interface PhotoCell : UICollectionViewCell {

    PhotoScrollView *_scrollView;   //滑动视图
    
}

@property(nonatomic, retain)PhotoScrollView *scrollView;

@property(nonatomic, copy)NSString *imageURL;

@end
