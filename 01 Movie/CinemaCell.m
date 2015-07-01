//
//  CinemaCell.m
//  01 Movie
//
//  Created by lyb on 14-10-17.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "CinemaCell.h"
#import "CinemaModel.h"

#define KFontColor rgb(253, 216, 0, 1)

@implementation CinemaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        //设置辅助图标
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //取消点击效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化视图
        [self _initView];
        
    }
    return self;
}

//初始化视图
- (void)_initView {

    //创建评分视图
    UIFont *font = [UIFont fontWithName:[UIFont familyNames][58] size:16];
    _ratingLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
    //设置显示的字体
    _ratingLabel1.font = font;
    _ratingLabel1.textColor = KFontColor;
    _ratingLabel1.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_ratingLabel1];
    
    _ratingLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
    _ratingLabel2.font = [UIFont fontWithName:[UIFont familyNames][58] size:13];
    _ratingLabel2.textColor = KFontColor;
    _ratingLabel2.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_ratingLabel2];
    
    //创建价格视图
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _priceLabel.font = [UIFont systemFontOfSize:18];
    _priceLabel.textColor = KFontColor;
    _priceLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_priceLabel];
    
    //选座图片
    _seatIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cinemaSeatMark@2x"]];
    [self.contentView addSubview:_seatIcon];
    
    //优惠图片
    _couponIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cinemaCouponMark@2x"]];
    [self.contentView addSubview:_couponIcon];
    
    //显示电影名的label
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    //显示子标题
    self.detailTextLabel.textColor = [UIColor lightGrayColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
}

- (void)layoutSubviews {

    //调用父类的方法
    [super layoutSubviews];
    
    //手动添加视图
    if (self.textLabel.superview == nil) {
        [self.contentView addSubview:self.textLabel];
    }
    
    if (self.detailTextLabel.superview == nil) {
        [self.contentView addSubview:self.detailTextLabel];
    }
    
    //处理数据
//    if ([self.model.lowPrice isKindOfClass:[NSNull class]]) {
//        self.model.lowPrice = @"";
//    }
//    
//    if ([self.model.circleName isKindOfClass:[NSNull class]]) {
//        self.model.circleName = @"";
//    }
//    
//    if ([self.model.grade isKindOfClass:[NSNull class]]) {
//        self.model.grade = @"";
//    }
    
    //显示影院名
    self.textLabel.frame = CGRectMake(10, 5, 0, 0);
    self.textLabel.text = self.model.name;
    [self.textLabel sizeToFit];
    
    //防止占据的地方太多
    if (self.textLabel.width > 200) {
        self.textLabel.width = 200;
    }
    
    //显示附近商域
    self.detailTextLabel.frame = CGRectMake(self.textLabel.left, self.textLabel.bottom + 5, 0, 0);
    self.detailTextLabel.text = self.model.circleName;
    [self.detailTextLabel sizeToFit];
    
    //价格
    NSString *price = self.model.lowPrice;
    if (price.length == 0) {
        _priceLabel.text = nil;
    }else {
        int value = [price intValue];
        _priceLabel.text = [NSString stringWithFormat:@"￥%d",value];
        [_priceLabel sizeToFit];
        _priceLabel.right = self.width - 30;
        _priceLabel.top = 20;
    }
    
    //评分
    NSString *grade = self.model.grade;
    if (grade.length > 0 && [grade intValue] > 0) {
        NSArray *comp = [grade componentsSeparatedByString:@"."];
        
        if (comp.count == 2) {
            NSString *r1 = [comp objectAtIndex:0]; //整数部分
            NSString *r2 = [comp objectAtIndex:1];  //小树部分
            
            _ratingLabel1.text = [NSString stringWithFormat:@"%@",r1];
            _ratingLabel2.text = [NSString stringWithFormat:@".%@分",r2];
        }
        
        _ratingLabel1.frame = CGRectMake(self.textLabel.right + 5, self.textLabel.top, 0, 0);
        [_ratingLabel1 sizeToFit];
        
        _ratingLabel2.frame = CGRectMake(_ratingLabel1.right, self.textLabel.top, 0, 0);
        [_ratingLabel2 sizeToFit];
    }else {
        _ratingLabel1.text = nil;
        _ratingLabel2.text = nil;
    }
    
    //图标
    BOOL isSeat = [self.model.isSeatSupport boolValue];
    BOOL isCoupon = [self.model.isCouponSupport boolValue];
    
    if (isSeat) {
        _seatIcon.hidden = NO;
        _seatIcon.frame = CGRectMake(self.textLabel.left, self.detailTextLabel.bottom + 5, 17, 17);
    }else {
        _seatIcon.hidden = YES;
        _seatIcon.frame = CGRectZero;
    }
    
    if (isCoupon) {
        _couponIcon.hidden = NO;
        _couponIcon.frame = CGRectMake(_seatIcon.right + 5, self.detailTextLabel.bottom + 5, 17, 17);
    }else {
        _couponIcon.hidden = YES;
        _couponIcon.frame = CGRectZero;
    }
    
}

@end
