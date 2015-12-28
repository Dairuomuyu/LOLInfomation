//
//  rootViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "rootViewController.h"
#import "newsViewController.h"
#import "herosViewController.h"
#import "combatViewController.h"
#import "infosViewController.h"
#import "settingViewController.h"
#import "RDVTabBarItem.h"
#import <AudioToolbox/AudioToolbox.h>
@interface rootViewController ()

@end

@implementation rootViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    // <1> 获取提示音路径
    NSString * path = [[NSBundle mainBundle] pathForResource:@"garen.mp3" ofType:nil];
    // <2> 将字符串路径转化为NSURL
    NSURL * url = [NSURL fileURLWithPath:path];
    // <3> 注册系统音频ID
    SystemSoundID ID ;
    // <4> 创建系统音频
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &ID);
    // <5> 播放系统音频
    AudioServicesPlaySystemSound(ID);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.news
    newsViewController * newsVC = [[newsViewController alloc] init];
    UINavigationController * newsNav = [[UINavigationController alloc] initWithRootViewController:newsVC];
    
    // 2.heros
    herosViewController * herosVC = [[herosViewController alloc] init];
    UINavigationController * herosNav = [[UINavigationController alloc] initWithRootViewController:herosVC];
    
    // 3.combat <#战绩停用#>
//    combatViewController * comVC = [[combatViewController alloc] init];
//    UINavigationController * comNav = [[UINavigationController alloc] initWithRootViewController:comVC];
    
    // 4.infos
    infosViewController * infosVC = [[infosViewController alloc] init];
    UINavigationController * infosNav = [[UINavigationController alloc] initWithRootViewController:infosVC];
    
    // 5.setting
    settingViewController * setVC = [[settingViewController alloc] init];
    UINavigationController * setNav = [[UINavigationController alloc] initWithRootViewController:setVC];
    
    // 6.将子视图添加到tabBar中
    self.viewControllers = @[newsNav,herosNav,infosNav,setNav];
    
    [self customizeTabBarForController:self];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController
{
    // tabBar图片
    NSArray *tabBarItemImages = @[@"tab_icon_news", @"tab_icon_friend", @"tab_icon_quiz",@"tab_icon_more"];
    
    // tabBar标题
    NSArray * titleArr = @[@"新闻",@"英雄",@"资料",@"设置"]; // [@"新闻",@"英雄",@"战绩",@"资料",@"设置"];
    NSInteger index = 0;
    
    // 让字体和图标颜色一起变
    NSDictionary *textAttributes_normal = nil;
    NSDictionary *textAttributes_selected = nil;
    
    // 设置字体颜色、字号
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        textAttributes_normal = @{
                                  NSFontAttributeName: [UIFont systemFontOfSize:9],
                                  NSForegroundColorAttributeName: [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1.0],
                                  };
        textAttributes_selected = @{
                                    NSFontAttributeName: [UIFont systemFontOfSize:9],
                                    NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:113/255.0 blue:183/255.0 alpha:1.0],
                                    };
    }
    
    // 设置tabBar上按钮“选中”和“非选中”时的图片
    for (RDVTabBarItem *item in [[tabBarController tabBar] items])
    {
        item.unselectedTitleAttributes = textAttributes_normal;
        item.selectedTitleAttributes = textAttributes_selected;
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_press",
                                                      [tabBarItemImages objectAtIndex:index]]];
        
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.title = titleArr[index];
        index++;
    }
    
}

@end
