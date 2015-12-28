//
//  aboutViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "aboutViewController.h"
#import "RDVTabBarController.h"
@interface aboutViewController ()

@end

@implementation aboutViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES]; // 界面显示时隐藏底部tabBAr
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
