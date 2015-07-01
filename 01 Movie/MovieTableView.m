//
//  MovieTableView.m
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MovieTableView.h"
#import "MovieListModel.h"
#import "UIImageView+WebCache.h"

@implementation MovieTableView

//通过覆写此方法，重新设置滑动的起始位置
- (void)setRowHeight:(CGFloat)rowHeight
{
    [super setRowHeight:rowHeight];
    
    self.contentInset = UIEdgeInsetsMake(0, 0, self.width-rowHeight, 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"posterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //将cell.contentView顺时针旋转90度
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        //创建图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, self.rowHeight-10, self.height)];
        imgView.tag = 100;
        imgView.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:imgView];

        
        cell.contentView.alpha = 0.3;
        if (indexPath.row == 0) {
            cell.contentView.alpha = 1;
        }
    }
    
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:100];
    MovieListModel *movieModel = self.data[indexPath.row];
    NSString *urlstring = movieModel.logo;
    [imgView setImageWithURL:[NSURL URLWithString:urlstring]];
    
    return cell;
}

#pragma mark - UIScrollView delegate
//滚动时，实时调用的协议方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int row = (self.contentOffset.y+self.rowHeight/2)/self.rowHeight;
    if (row < 0 || row >= self.data.count) {
        return;
    }
    
    if (self.selectedInexPath.row != row) {
        //1.先要将上次选中的单元格变灰
        UITableViewCell *lastCell = [self cellForRowAtIndexPath:self.selectedInexPath];
        lastCell.contentView.alpha = 0.3;
        
        //2.将当前选中的单元格变亮
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        UITableViewCell *currentCell = [self cellForRowAtIndexPath:indexPath];
        currentCell.contentView.alpha = 1;
        
        self.selectedInexPath = indexPath;
        
        //3.通知代理对象，index变动了
        if ([self.mtDelegate respondsToSelector:@selector(movieTableView:selectedIndexPath:)]) {
            //调用代理对象的协议方法
            [self.mtDelegate movieTableView:self selectedIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
//    [super scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
//    
//    //1.先要将上次选中的单元格变灰
//    UITableViewCell *lastCell = [self cellForRowAtIndexPath:self.selectedInexPath];
//    lastCell.contentView.alpha = 0.3;
//    
//    //2.将当前选中的单元格变亮
//    UITableViewCell *currentCell = [self cellForRowAtIndexPath:indexPath];
//    currentCell.contentView.alpha = 1;
//}

@end
