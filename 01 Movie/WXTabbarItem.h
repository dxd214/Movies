//
//  WXTabbarItem.h
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXTabbarItem : UIControl

//自定义初始化方法
- (id)initWithFrame:(CGRect)frame
      withImageName:(NSString *)name
          withTitle:(NSString *)title;

@end
