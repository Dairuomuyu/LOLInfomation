//
//  AppDelegate.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "AppDelegate.h"
#import "rootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册远程推送
    [self registerNotificationToServer:application];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏title颜色w
    NSDictionary * textA = @{
                             NSFontAttributeName : [UIFont systemFontOfSize:18],
                             NSForegroundColorAttributeName : [UIColor whiteColor],
                             };
    [[UINavigationBar appearance] setTitleTextAttributes:textA];
    // 设置所有导航背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:23/255.0 green:27/255.0 blue:38/255.0 alpha:1]];
    
    // 1.设置状态栏字体颜色
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    // 2. 将Info.plist中添加一项 View controller-based status bar appearance 属性设为NO
    
    rootViewController * rootVC = [[rootViewController alloc] init];
    self.window.rootViewController = rootVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)registerNotificationToServer:(UIApplication *)application
{
    //    1.注册远程推送，如果注册成功，APP推送服务器会给我我们返回一个token一个值
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    }else{
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert) categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
}

//远程推送注册成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //    NSLog(@"%s",__FUNCTION__);
    //    NSLog(@"deviceToken:%@",[NSString stringWithFormat:@"%@",deviceToken]);
    //    <947558b1 10e1ff81 0eb97bea c013f8e6 bd7549f2 1cdcbbdb a257b6d1 09c0ef58>
    
    //    947558b110e1ff810eb97beac013f8e6bd7549f21cdcbbdba257b6d109c0ef58
    
    //    在这个地方拿到token值，需要将上面的字符串处理，去掉<>空格，然后发送给服务器
    
    
}
//注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
}


@end

