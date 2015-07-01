//
//  MoviePlayerViewController.h
//  WXMovie
//
//  Created by wei.chen on 13-9-17.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"

@interface MoviePlayerViewController : BaseViewController

@property(nonatomic, retain)NSURL *movieUrl;
@property(nonatomic, copy) NSString *movieTitle;

@end
