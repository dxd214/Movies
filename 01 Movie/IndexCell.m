//
//  IndexCell.m
//  01 WXMovie
//
//  Created by lyb on 14-8-19.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "IndexCell.h"
#import "UIImageView+WebCache.h"

@implementation IndexCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.contentView.transform = CGAffineTransformMakeScale(.9, .9);
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_imageView];
        
    }
    return self;
}

- (void)setStringURL:(NSString *)stringURL {

    _stringURL = stringURL;
    //将字符串转化成URL
    NSURL *url = [NSURL URLWithString:self.stringURL];
    [_imageView setImageWithURL:url];

}

@end
