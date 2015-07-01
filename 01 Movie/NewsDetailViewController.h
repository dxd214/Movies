//
//  NewsDetailViewController.h
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface NewsDetailViewController : BaseViewController<UIWebViewDelegate> {

    UIWebView *_webView;    //网页视图
    UIActivityIndicatorView *_activityView;//加载提示
}

@end
