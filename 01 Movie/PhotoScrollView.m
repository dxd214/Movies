//
//  PhotoScrollView.m
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "PhotoScrollView.h"
#import "UIImageView+WebCache.h"

@implementation PhotoScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化子视图
        [self _initView];
    }
    return self;
}

//初始化视图
- (void)_initView {

    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    //设置图片的显示样式
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.backgroundColor = [UIColor redColor];
    [self addSubview:_imageView];
    
    //设置代理
    self.delegate = self;
    self.bounces = NO;
    
    //隐藏滚动条
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    //设置放大或者缩小的倍数
    self.maximumZoomScale = 2;
    self.minimumZoomScale = 1;
    
    //添加双击手势
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action)];
    //设置点击的次数
    tap2.numberOfTapsRequired = 2;
    //设置手指的个数[默认为1]
//    tap2.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap2];
   
    //添加单击手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action)];
    [self addGestureRecognizer:tap1];
    
    //当点击tap2的时，取消tap1
    [tap1 requireGestureRecognizerToFail:tap2];
    
   
    
    
}

//双击响应的事件
- (void)tap1Action {
    
    //zoomScale表示滑动视图缩放倍数
    if (self.zoomScale > 1) {
        //放大状态
        //进行缩小
        [self setZoomScale:1 animated:YES];
    }else {
        //缩小状态
        //进行放大
        [self setZoomScale:2 animated:YES];
    }
    
}

//单击响应的事件
- (void)tap2Action {

    NSLog(@"单击了");
    
    //发送单击了通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClickImage" object:self];
}

- (void)setImageURL:(NSString *)imageURL
{
    if (_imageURL != imageURL)
    {
        _imageURL = imageURL;
        //加载数据
        [_imageView setImageWithURL:[NSURL URLWithString:_imageURL]];
    }
    
}

#pragma mark - UIScrollView delegate
//指定缩放的图片
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return _imageView;

}


@end
