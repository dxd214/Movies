//
//  StarView.h
//  01 Movie
//
//  Created by lyb on 14-10-10.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView {

    UIView *_grayView;  //灰色星星视图
    UIView *_yellowView;    //黄色星星视图
}

@property(nonatomic, retain)NSNumber *score;    //评分

@property(nonatomic, retain)UILabel *scoreLabel;    //评分的label

@end
