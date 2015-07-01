//
//  PhotoScrollView.h
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoScrollView : UIScrollView<UIScrollViewDelegate> {

    UIImageView *_imageView;    //图片视图
    
}

@property(nonatomic, copy)NSString *imageURL;

@end
