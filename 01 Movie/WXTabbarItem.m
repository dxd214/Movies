//
//  WXTabbarItem.m
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "WXTabbarItem.h"

@implementation WXTabbarItem

//自定义初始化方法
- (id)initWithFrame:(CGRect)frame
      withImageName:(NSString *)name
          withTitle:(NSString *)title {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        //1.创建子视图
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-20)/2, 5, 20, 20)];
        //设置显示的图片
        imageView.image = [UIImage imageNamed:name];
        //设置图片的填充方式
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom, self.width, 24)];
        //设置显示的内容
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:titleLabel];
        
    }
    
    return self;
}

@end
