//
//  settingViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "settingViewController.h"
#import "settingPageTableViewCell.h"
#import "aboutViewController.h"
#import "newsSendViewController.h"
#import "suggestViewController.h"
#import "RDVTabBarController.h"
#import "privacySetViewController.h"
#import "saveTrafficViewController.h"
@interface settingViewController ()

@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizesSubviews = NO;
    _tableView.tableFooterView = [[UIView alloc] init]; // 数据刷新之前，隐藏页面中的表格
    _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    // 注册cell
    UINib *nibName = [UINib nibWithNibName:@"settingPageTableViewCell" bundle:nil];
    [self.tableView registerNib:nibName forCellReuseIdentifier:@"cellid"];
}

#pragma mark --- <UITableViewDataSource,UITableViewDelegate>
// 设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
// 设置每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    else
    {
        return 3;
    }
}
// 设置cell内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * titleArr1 = @[@"绑定大区"];
    NSArray * titleArr2 = @[@"消息推送",@"隐私设置",@"省流量"];
    NSArray * titleArr3 = @[@"关于我们",@"意见反馈",@"检查新版本"];
    NSArray * detailArr1 = @[@"比尔吉沃特"];
    NSArray * detailArr2 = @[@"",@"",@"资源图片自动下载设置",@"3.30MB"];
    NSArray * detailArr3 = @[@"V3.3.3",@"",@"",@"官方反馈QQ群:330669703"];
    
    settingPageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    
    if(indexPath.section == 0)
    {
        cell.titleLable.text = titleArr1[indexPath.row];
        cell.ditaiLable.text = detailArr1[indexPath.row];
    }
    else if (indexPath.section == 1)
    {
        cell.titleLable.text = titleArr2[indexPath.row];
        cell.ditaiLable.text = detailArr2[indexPath.row];
    }
    else
    {
        cell.titleLable.text = titleArr3[indexPath.row];
        cell.ditaiLable.text = detailArr3[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return  [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.width/2)];
}
// cell选中后页面跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0) // 绑定大区
        {
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"功能暂未开放" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [a show];
            a = nil;
        }
    }
    else if (indexPath.section == 1) //
    {
        if(indexPath.row == 0) // “消息推送”
        {
            newsSendViewController * newsSendVC = [[newsSendViewController alloc] init];
            [self.navigationController pushViewController:newsSendVC animated:YES];
        }
        else if(indexPath.row == 1) // “隐私设置”
        {
            privacySetViewController * privacySetVC = [[privacySetViewController alloc] init];
            [self.navigationController pushViewController:privacySetVC animated:YES];
        }
        else // “省流量”
        {
            saveTrafficViewController * saveTrafficVC = [[saveTrafficViewController alloc] init];
            [self.navigationController pushViewController:saveTrafficVC animated:YES];
        }
    }
    else if (indexPath.section == 2)
    {
        if(indexPath.row == 0) // “关于我们”
        {
            aboutViewController * aboutVC = [[aboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
        else if (indexPath.row == 1) // “意见建议”
        {
            suggestViewController * suggestVC = [[suggestViewController alloc] init];
            [self.navigationController pushViewController:suggestVC animated:YES];
        }
        else
        {
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前已为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [a show];
            a = nil;
        }
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES]; // 界面显示时显示底部tabBAr
}

@end
