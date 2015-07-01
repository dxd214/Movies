
//
//  StarView.m
//  01 Movie
//
//  Created by lyb on 14-10-10.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "StarView.h"

@implementation StarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //初始化视图
        [self _initView];
    }
    return self;
}
//nib文件创建的时候调用
- (void)awakeFromNib {

    //视图初始化
    [self _initView];
}

//视图初始化
- (void)_initView {

    //1.创建灰色星星视图
    _grayView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_grayView];
    
    //2.创建黄色星星视图
    _yellowView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_yellowView];
    
    //3.创建评分的label
    _scoreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _scoreLabel.backgroundColor = [UIColor clearColor];
    _scoreLabel.textColor = [UIColor whiteColor];
    [self addSubview:_scoreLabel];
    //4.设置自己的背景颜色
    self.backgroundColor = [UIColor clearColor];
}

//覆写frame的set方法
//设置当前视图的frame的时候会调用
- (void)setFrame:(CGRect)frame {

    //星星视图的宽度
    CGFloat starWide = 5*frame.size.height;
    
    //label的宽度
    frame.size.width = starWide + 30;
    
    [super setFrame:frame];
    
}

- (void)setScore:(NSNumber *)score {

    _score = score;
    
    //让系统重新调用layoutSubviews
    [self setNeedsLayout];
    
}

//布局、添加数据
//注意：不能在这个方法里面设置当前视图的frame，否则会死循环
- (void)layoutSubviews {

    [super layoutSubviews];
    
    /*
     缩放比例：缩放以后的尺寸/缩放之前的尺寸
     */
    
    //灰色星星视图
    UIImage *grayImg = [UIImage imageNamed:@"gray@2x"];
    //将图片作为背景
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImg];
    //缩放灰色星星视图
    _grayView.transform = CGAffineTransformMakeScale(self.height/grayImg.size.width, self.height/grayImg.size.height);
    
    //黄色星星视图
    UIImage *yellowImg = [UIImage imageNamed:@"yellow@2x"];
    //将图片作为背景
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImg];
    //缩放黄色星星视图
    _yellowView.transform = CGAffineTransformMakeScale(self.height/yellowImg.size.width, self.height/yellowImg.size.height);
    
    
    //布局
    CGFloat wide = 5*self.height;
    _grayView.frame = CGRectMake(0, 0, wide, self.height);
    _yellowView.frame = CGRectMake(0, 0, wide, self.height);
    _scoreLabel.frame = CGRectMake(_grayView.right + 5, 0, 30, self.height);
    
    //取得当前的分数
    CGFloat num = [_score floatValue];
    //设置label显示的值
    _scoreLabel.text = [NSString stringWithFormat:@"%.1f",num];
    
    //计算比例
    CGFloat tr = num/10;
    //修改黄色星星的宽度
    _yellowView.width = _yellowView.width*tr;
    
}




@end
