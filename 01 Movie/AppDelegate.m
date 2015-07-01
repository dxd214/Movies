//
//  AppDelegate.m
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchViewController.h"
#import "GuideViewController.h"

#define KShowGuide  @"showGuide"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];

    [self _initLaunch];
    return YES;
}
- (void)_initLaunch
{
    //    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    //存储数据
    //    [userDefaults setObject:@"jack" forKey:@"name"];
    //    //同步数据(别忘了)
    //    [userDefaults synchronize];
    //读取数据
    //    NSString *name = [userDefaults objectForKey:@"name"];
    //    NSLog(@"name:%@",name);
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    BOOL showGuide = [userDefaults boolForKey:KShowGuide];
    
    if (showGuide == NO)
    {//没有显示操作指南，则显示
        self.window.rootViewController = [[GuideViewController alloc] init];
        [userDefaults setBool:YES forKey:KShowGuide];
        //将数据同步到本地的文件中
        [userDefaults synchronize];
    }
    else
    {
        
        self.window.rootViewController = [[LaunchViewController alloc] init];
    }
    
    //    self.window.rootViewController = [[MainTabbarController alloc] init];
    
    //设置状态栏的样式
    //iOS6
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    //如果在iOS6中直接设置就可以了，但是在iOS7中还要修改plist文件中的View controller-based status bar appearance属性 NO。如果是YES，则无法使用UIApplication设置状态栏的样式
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
