//
//  PhotoCell.m
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotoScrollView.h"

@implementation PhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        //初始化子视图
        [self _initView];
        
    }
    return self;
}

//视图初始化
- (void)_initView {

    _scrollView = [[PhotoScrollView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_scrollView];
    
}

- (void)setImageURL:(NSString *)imageURL {


    if(_imageURL != imageURL)
    {
        _imageURL = [imageURL copy];
        _scrollView.imageURL = _imageURL;
    }
}

@end
