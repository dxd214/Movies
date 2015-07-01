//
//  MovieCell.m
//  01 Movie
//
//  Created by lyb on 14-10-10.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "MovieCell.h"
#import "MovieModel.h"
#import "UIImageView+WebCache.h"
#import "StarView.h"

@implementation MovieCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //初始化视图
        [self _initView];
    }
    return self;
}

//初始化视图
- (void)_initView {

    //设置辅助视图
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //取消点击效果
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //创建imageView
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imageView];
    
    //设置两个label
    self.textLabel.textColor = [UIColor orangeColor];
    self.detailTextLabel.textColor = [UIColor whiteColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    
    //星星视图
    _starView = [[StarView alloc] initWithFrame:CGRectZero];
    _starView.scoreLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_starView];
    
}

/*
 1.布局，设置frame值
 2.添加数据
 */

/*
 1.当这个视图添加到其他视图上显示的时候会调用，addSubView
 2.设置frame值的时候会调用
 3.滚动、滑动的时候会调用
 4.旋转视图的时候
 5.修改frame值的时候
 6.初始化的时候不用调用
 */
- (void)layoutSubviews {
    
    /*
     1.有没有创建
     2.有没有设置frame
     3.有没有添加到父视图上
     4.hidden属性是否为YES
     5.是不是被其他视图覆盖的
     */
    
    /*
     如果使用cell内置的子视图的时候需要注意两点：
     1.得先调用父类的layoutSubviews，不然不好设置frame
     2.自带的子视图是懒加载，如果想现实得手动添加
     */
    
    //为了确保使用自带的视图的时候可以设置frame
    [super layoutSubviews];
    
    if (self.textLabel.superview == nil) {
        [self.contentView addSubview:self.textLabel];
    }
    
    if (self.detailTextLabel.superview == nil) {
        [self.contentView addSubview:self.detailTextLabel];
    }
    
    //1.添加数据
    self.textLabel.text = self.model.title;
    NSString *str = [NSString stringWithFormat:@"年份：%@",self.model.year];
    self.detailTextLabel.text = str;
    
    NSDictionary *imgDic = self.model.images;
    //取得图片的连接
    NSString *stringURl = [imgDic objectForKey:@"medium"];
    //将字符串转换成URL
    NSURL *url = [NSURL URLWithString:stringURl];
    //加载图片
    [_imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"123"]];
    
    //2.布局
    _imageView.frame = CGRectMake(10, 10, 75, 100);
    self.textLabel.frame = CGRectMake(_imageView.right + 10, _imageView.top, 200, 20);
    self.detailTextLabel.frame = CGRectMake(_imageView.right + 10, 90, 150, 20);
    
    //星星视图
    NSNumber *score = [self.model.rating objectForKey:@"average"];
    _starView.score = score;
    
    //布局
    _starView.frame = CGRectMake(_imageView.right + 10, self.textLabel.bottom + 20, 0, 20);
    
}



@end
