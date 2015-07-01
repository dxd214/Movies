//
//  CommentCell.h
//  01 WXMovie
//
//  Created by lyb on 14-8-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentModel;
@interface CommentCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *userImage;
@property (retain, nonatomic) IBOutlet UIImageView *bjImageView;
@property (retain, nonatomic) IBOutlet UILabel *nickLabel;
@property (retain, nonatomic) IBOutlet UILabel *contentLabel;
@property (retain, nonatomic) IBOutlet UILabel *ratingLabel;

@property(nonatomic, retain)CommentModel *model;

//计算单元格的高度
+ (CGFloat)cellHeight:(NSString *)content;

@end
