//
//  newsViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "newsViewController.h" // 新闻页面
#import "SCNavTabBarController.h" // 第三方插件
#import "newestViewController.h" // 最新
#import "S5ViewController.h" // 活动
#import "gameViewController.h" // 赛事
#import "girlsViewController.h" // 美女
#import "strategyViewController.h" // 攻略
#import "officialViewController.h" // 官方
#import "videoViewController.h" // 视频
#import "funViewController.h" // 娱乐
#import "talksViewController.h" // 神贴 --- 未启用，被视频代替

@interface newsViewController ()

@end

@implementation newsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新闻";
    
    // 隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
    newestViewController * newestVC = [[newestViewController alloc] init];
    newestVC.title = @"最新";
    
    S5ViewController *S5VC = [[S5ViewController alloc] init];
    S5VC.title = @"活动";
    
    gameViewController *gameVC = [[gameViewController alloc] init];
    gameVC.title = @"赛事";
    
    talksViewController *talkVC = [[talksViewController alloc] init];
    talkVC.title = @"神贴";
    
    girlsViewController *girlVC = [[girlsViewController alloc] init];
    girlVC.title = @"美女";
    
    funViewController *funVC = [[funViewController alloc] init];
    funVC.title = @"娱乐";
    
    strategyViewController *strategyVC = [[strategyViewController alloc] init];
    strategyVC.title = @"攻略";
    
    officialViewController *officialVC = [[officialViewController alloc] init];
    officialVC.title = @"官方";
    
    videoViewController * videoVC = [[videoViewController alloc] init];
    videoVC.title = @"视频";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[newestVC, S5VC, gameVC, videoVC, funVC,officialVC,girlVC,strategyVC];
    [navTabBarController setNavTabBarLineColor:[UIColor redColor]];
    
    // 设置tabBar背景颜色
    [navTabBarController setNavTabBarColor:[UIColor colorWithRed:35/255.0 green:43/255.0  blue:60/255.0  alpha:0.5]];
    // 和tabBar颜色统一
    self.view.backgroundColor = [UIColor colorWithRed:55/255.0 green:63/255.0  blue:80/255.0  alpha:1];
    
    [navTabBarController addParentController:self];
}











@end
