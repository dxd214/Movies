//
//  WXSegment.m
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WXSegment.h"

@implementation WXSegment {
    NSMutableArray *_images;
    NSMutableArray *_labels;
}


- (id)initWithItems:(NSArray *)items {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _items = items;

        self.selectedIndex = 0;
        
        [self _initViews];
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    //重新调用layoutSubviews
    [self setNeedsLayout];
    
    //发送一个事件，事件名:UIControlEventValueChanged
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setFont:(UIFont *)font {
    if (_font != font) {
        _font = font;
        
        //重新调用layoutSubviews
        [self setNeedsLayout];
    }
}

//创建子视图
- (void)_initViews {
    
    _images = [[NSMutableArray alloc] initWithCapacity:self.items.count];
    _labels = [[NSMutableArray alloc] initWithCapacity:self.items.count];
    
    for (int i=0; i<self.items.count; i++) {
        //1.创建item的背景图片
        UIImage *image = [UIImage imageNamed:@"segment-n@2x.png"];
        UIImage *highlighteImage = [UIImage imageNamed:@"segment-h@2x.png"];
        UIImageView *itemBackgroud = [[UIImageView alloc] initWithImage:image highlightedImage:highlighteImage];
        [self addSubview:itemBackgroud];
        [_images addObject:itemBackgroud];
        
        //2.创建item上的Label
        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        itemLabel.textColor = [UIColor whiteColor];
        itemLabel.font = [UIFont systemFontOfSize:14.0];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [itemBackgroud addSubview:itemLabel];
        [_labels addObject:itemLabel];
        
       
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat itemWidth = self.width/self.items.count;
    for (int i=0; i<_images.count; i++) {
        UIImageView *itemBackgroud = [_images objectAtIndex:i];
        UILabel *itemLabel = [_labels objectAtIndex:i];
        
        itemBackgroud.frame = CGRectMake(itemWidth*i, 0, itemWidth, self.height);
        itemLabel.frame = itemBackgroud.bounds;
        itemLabel.text = [self.items objectAtIndex:i];
        
        if (self.font != nil) {
            itemLabel.font = self.font;
        }
        
        if (self.selectedIndex == i) {
            itemBackgroud.highlighted = YES;
        }
    }
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//触摸结束时调用
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    //item的高度
    CGFloat itemWidth = self.width/self.items.count;
    //获取选中的图片索引
    int index = p.x / itemWidth;
    
    if (index < _images.count) {
        //1.上次选中的图片，取消高亮
        UIImageView *lastImg = [_images objectAtIndex:self.selectedIndex];
        lastImg.highlighted = NO;
        
        //2.当前选中的图片，设置高亮
//        UIImageView *currentImg = [_images objectAtIndex:index];
//        currentImg.highlighted = YES;
        
        //修改selectedIndex，会将此索引对应的图片设置为高亮
        self.selectedIndex = index;
    }
    
}



@end
