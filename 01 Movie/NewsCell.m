//
//  NewsCell.m
//  01 Movie
//
//  Created by lyb on 14-10-13.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "NewsCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"

@implementation NewsCell

- (void)awakeFromNib
{
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //设置图片
    NSString *stringURL = self.model.image;
    //加载图片
    [_imgView setImageWithURL:[NSURL URLWithString:stringURL]];
    
    //设置标题
    _titleLabel.text = self.model.title;
    
    //新闻类型
    long type = [self.model.type longValue];
    if (type == 0) {  //普通新闻
        //隐藏类型图片
        _typeImg.hidden = YES;
        //设定_summaryLabel的位置
        _summaryLabel.left = _titleLabel.left;
    }else if (type == 1) {  //图片新闻
    
        //显示类型图片
        _typeImg.hidden = NO;
        
        _typeImg.image = [UIImage imageNamed:@"sctpxw"];
        _summaryLabel.left = _typeImg.right + 5;
    }else if (type == 2) {
        //显示视频
        _typeImg.hidden = NO;
        
        _typeImg.image = [UIImage imageNamed:@"scspxw"];
        _summaryLabel.left = _typeImg.right + 5;
    }
    
    _summaryLabel.text = self.model.summary;
    
}

@end
