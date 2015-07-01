//
//  MovieHeaderView.h
//  01 WXMovie
//
//  Created by lyb on 14-8-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieDetailModel;

@interface MovieHeaderView : UIView  {

    NSMutableArray *_imageArr;  //存放image
    
}

@property (retain, nonatomic) IBOutlet UIButton *movieImage;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *directorLabel;
@property (retain, nonatomic) IBOutlet UILabel *actorLabel;
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UIView *imgsView;

@property(nonatomic, retain)MovieDetailModel *model;


- (IBAction)playAction:(id)sender;

@end
