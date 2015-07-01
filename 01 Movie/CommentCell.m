//
//  CommentCell.m
//  01 WXMovie
//
//  Created by lyb on 14-8-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"

@implementation CommentCell

/*
 {
 "userImage" : "http://img2.mtime.com/images/default/head.gif",
 "nickname" : "yangna988",
 "rating" : "9.0",
 "content" : "儿子很喜欢 一直期盼上映"
 }
 */

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //加载用户图片
    NSString *stringURL = self.model.userImage;
    [_userImage setImageWithURL:[NSURL URLWithString:stringURL]];
    //添加边框
    _userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _userImage.layer.borderWidth = 1;
    //设置弧度
    _userImage.layer.cornerRadius = 5;
    
    //设置label显示数据
    _nickLabel.text = self.model.nickname;
    _ratingLabel.text = self.model.rating;
    _contentLabel.text = self.model.content;
    
    //调整背景视图与内容Label的高度
//    _bjImageView.height = self.height - 10;
//    _contentLabel.height = self.height - 40;
    
    UIImage *resizeImg = [_bjImageView.image stretchableImageWithLeftCapWidth:0 topCapHeight:10];
    _bjImageView.image = resizeImg;
}

//计算单元格的高度
+ (CGFloat)cellHeight:(NSString *)content {

    UIFont *font = [UIFont systemFontOfSize:16.0];
    
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(212, 1000)];
    
    //内容的高度
    float hg = size.height;
    
    return hg + 50;
}

@end
