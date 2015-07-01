//
//  ImageListCell.m
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "ImageListCell.h"
#import "UIImageView+WebCache.h"

@implementation ImageListCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
        _imgView.backgroundColor = [UIColor redColor];
        
        //添加边框
        _imgView.layer.borderColor = [UIColor grayColor].CGColor;
        _imgView.layer.borderWidth = 1;
        
        //边框的弧度
        _imgView.layer.cornerRadius = 5;
        
        
        //添加到当前的视图上
        [self.contentView addSubview:_imgView];
        
    }
    return self;
}

//添加数据
- (void)setStringURL:(NSString *)stringURL {

    _stringURL = stringURL;
    
    //给视图加载数据
    [_imgView setImageWithURL:[NSURL URLWithString:_stringURL]];
    
}

@end
