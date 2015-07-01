//
//  TopCell.m
//  01 WXMovie
//
//  Created by lyb on 14-8-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "TopCell.h"
#import "Movie.h"
#import "StarView.h"
#import "UIImageView+WebCache.h"

@implementation TopCell

//加载XIB的时候不会调用init方法
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

- (void)awakeFromNib {

    //设置标题的背景颜色
    _titleLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    //剧中显示
    _titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setModel:(Movie *)model {

    _model = model;
    [self setNeedsLayout];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //取得图片的链接
    NSString *urlString = [self.model.images objectForKey:@"medium"];
    [_imageView setImageWithURL:[NSURL URLWithString:urlString]];
    
    _titleLabel.text = self.model.title;
    _starView.score = [self.model.rating objectForKey:@"average"];
    _starView.scoreLabel.font = [UIFont systemFontOfSize:12];
    _starView.scoreLabel.textColor = [UIColor whiteColor];
}

@end
