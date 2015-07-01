//
//  TopCell.h
//  01 WXMovie
//
//  Created by lyb on 14-8-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StarView;
@class Movie;

@interface TopCell : UICollectionViewCell
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet StarView *starView;

@property(nonatomic, retain) Movie *model;

@end
