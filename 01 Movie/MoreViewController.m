//
//  MoreViewController.m
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "MoreViewController.h"
#import "SDImageCache.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"更多";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    NSLog(@"%@",NSHomeDirectory());
    
    //创建表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    //去掉背景颜色
    _tableView.backgroundColor = [UIColor clearColor];
    //设置代理方法
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //关闭滑动
    _tableView.scrollEnabled = NO;
    //添加到视图上显示
    [self.view addSubview:_tableView];
    
    //读取plist文件
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MoreList" ofType:@"plist"];
    _data = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    //初始化图片的名字
    _imageNames = @[@"moreClear",
                    @"moreScore",
                    @"moreBusiness",
                    @"moreVersion",
                    @"moreWelcome",
                    @"moreAbout"];
    
    //计算图片的缓存
    [self refreshCaCheSize];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    //计算缓存大小
    [self refreshCaCheSize];
}

#pragma mark - UITableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    //显示的内容
    cell.textLabel.text = _data[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_imageNames[indexPath.row]];
    
    if (indexPath.row == 0) {
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        //将字节转换成M
        float s = sum/(1024*1024.0);
        //添加显示缓存的label
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",s];
    }
    
    return cell;
}

//点击单元格响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        /*
        //清楚缓存
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //取得缓存的路径
        NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/ImageCache"];
        
        //删除文件
        [fileManager removeItemAtPath:imagePath error:nil];
        
        //创建文件
        [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
        
        //计算缓存大小
        [self refreshCaCheSize];
         */
        
        //创建提示窗口
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清空缓存"
                                                            message:@"是否清楚缓存？？"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 1) {
//        //清楚缓存
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        
//        //取得缓存的路径
//        NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/ImageCache"];
//        
//        //删除文件
//        [fileManager removeItemAtPath:imagePath error:nil];
//        
//        //创建文件
//        [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES
//                                attributes:nil
//                                     error:nil];
        
        //清楚缓存
        [[SDImageCache sharedImageCache] clearDisk];
        
        //计算缓存大小
        [self refreshCaCheSize];
    }
    
}

//计算本地缓存
- (void)refreshCaCheSize {

    //取得图片缓存的路径
    NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/ImageCache"];
    sum = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取相应路径下所有文件的名字
    NSArray *fileName = [fileManager subpathsOfDirectoryAtPath:imagePath error:nil];
    
    for (NSString *str in fileName) {
        //获取图片的路径
        NSString *imgPath = [imagePath stringByAppendingPathComponent:str];
        //获取文件的属性字典
        NSDictionary *dic = [fileManager attributesOfItemAtPath:imgPath error:nil];
        
        //取得文件的大小
//        NSNumber *size = [dic objectForKey:NSFileSize];
        long long size = [dic fileSize];
        
        sum += size;
        
    }
    //刷新视图
    [_tableView reloadData];
    
}


@end
