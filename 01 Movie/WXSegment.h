//
//  WXSegment.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXSegment : UIControl

//选择按钮上的标题
@property(nonatomic,readonly)NSArray *items;
//按钮选择的索引
@property(nonatomic,assign)NSInteger selectedIndex;
//按钮上的标题字体
@property(nonatomic,retain)UIFont *font;

- (id)initWithItems:(NSArray *)items;

@end
