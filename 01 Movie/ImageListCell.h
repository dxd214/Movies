//
//  ImageListCell.h
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageListCell : UICollectionViewCell {

    UIImageView *_imgView;  //图片
    
}

@property(nonatomic, copy)NSString *stringURL;  //图片的链接

@end
