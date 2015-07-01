//
//  BaseViewController.h
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;
@interface BaseViewController : UIViewController

@property(nonatomic, retain)MBProgressHUD *hud;
@property(nonatomic, assign)BOOL isModal;   //判断是否为模态视图

//加载提示
- (void)showHUD:(NSString *)title;

//隐藏提示
- (void)hiddenHUD;

@end
