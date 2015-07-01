//
//  MovieHeaderView.m
//  01 WXMovie
//
//  Created by lyb on 14-8-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "MovieHeaderView.h"
#import "UIImageView+WebCache.h"
#import "MovieDetailModel.h"
#import "UIButton+WebCache.h"

@implementation MovieHeaderView

- (void)awakeFromNib {

    //设置边框
    _imgsView.layer.borderColor = [UIColor grayColor].CGColor;
    //设置边框的宽度
    _imgsView.layer.borderWidth = 1;
    //设置边框的弧度
    _imgsView.layer.cornerRadius = 5;
    
    _imageArr = [[NSMutableArray alloc] init];
    
    for (int i=0; i<4; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5 + (65+5)*i, 5, 65, 70)];
        [_imgsView addSubview:image];
        [_imageArr addObject:image];
    }
}

- (void)setModel:(MovieDetailModel *)model {

    _model = model;
    [self setNeedsLayout];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //加载按钮图片
    NSString *urlString = self.model.image;
    [_movieImage setImageWithURL:[NSURL URLWithString:urlString]];
    //标题label
    _titleLabel.text = self.model.titleCn;
    
    //导演
    NSString *directors = [self.model.directors componentsJoinedByString:@","];
    _directorLabel.text = [NSString stringWithFormat:@"导演:%@",directors];
    
    //演员
    NSString *actors = [self.model.actors componentsJoinedByString:@","];
    _actorLabel.text =  actors;
    
    //类型
    NSString *type = [self.model.type componentsJoinedByString:@","];
    _typeLabel.text = [NSString stringWithFormat:@"类型:%@",type];
    
    //放映的时间和地点
    NSString *time = [[self.model.releaseDic allValues] componentsJoinedByString:@"  "];
    _timeLabel.text = time;
    
    for (int i=0; i<4; i++) {
        UIImageView *imgView = _imageArr[i];
        if (i<self.model.images.count) {
            imgView.hidden = NO;
            NSString *urlString = [self.model.images objectAtIndex:i];
            [imgView setImageWithURL:[NSURL URLWithString:urlString]];
        }else {
            imgView.hidden = YES;
        }
    }
}

//点击播放按钮响应的事件
- (IBAction)playAction:(id)sender {

    NSLog(@"开始播放");

}
@end
