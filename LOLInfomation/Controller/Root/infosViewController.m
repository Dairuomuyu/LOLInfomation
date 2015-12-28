//
//  infosViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "infosViewController.h"
#import "infosTableViewCell.h"
#import "toolsViewController.h"
#import "RDVTabBarController.h"
#import "twoCodeViewController.h"
#import "combatAssistantViewController.h"
#import "officialWebViewController.h"
@interface infosViewController ()

@end

@implementation infosViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES]; // 界面显示时显示底部tabBAr
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.title = @"资料";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizesSubviews = NO;
    _tableView.tableFooterView = [[UIView alloc] init]; // 数据刷新之前，隐藏页面中的表格
    _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    // 注册cell
    UINib *nibName = [UINib nibWithNibName:@"infosTableViewCell" bundle:nil];
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
    if(section == 2)
    {
        return 3;
    }
    else
    {
        return 2;
    }
}
// 设置cell内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * titleArr1 = @[@"物品资料",@"对战助手"];
    NSArray * titleArr2 = @[@"官方网站",@"兴趣部落"];
    NSArray * titleArr3 = @[@"掌盟二维码",@"知识学院",@"英雄时刻"];
    
    
    NSArray * imageArr1 = @[@"more_icon_query@2x.png",@"first_win_calendar_win@2x.png"];
    NSArray * imageArr2 = @[@"more_icon_forum@2x.png",@"icon_push_big@2x.png"];
    NSArray * imageArr3 = @[@"chat_mobile_online@2x.png",@"more_icon_guess@2x.png",@"ability_lol_hero_time@2x.png"];
    
    NSArray * subImage = @[@"list_news_item_new_mark@2x.png",@"list_news_item_hot_mark@2x.png"];
    
    infosTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    
    if(indexPath.section == 0)
    {
        cell.imageV.image = [UIImage imageNamed:imageArr1[indexPath.row]];
        cell.titleLabel.text = titleArr1[indexPath.row];
        cell.subImageV.image = [UIImage imageNamed:subImage[0]];
    }
    else if (indexPath.section == 1)
    {
        cell.imageV.image = [UIImage imageNamed:imageArr2[indexPath.row]];
        cell.titleLabel.text = titleArr2[indexPath.row];
    }
    else
    {
        cell.imageV.image = [UIImage imageNamed:imageArr3[indexPath.row]];
        cell.titleLabel.text = titleArr3[indexPath.row];
        if(indexPath.row == 2)
        {
            cell.subImageV.image = [UIImage imageNamed:subImage[1]];
        }
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
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"功能暂未开放" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0) // 跳转“装备”信息界面
        {
            toolsViewController * toolsVC = [[toolsViewController alloc] init];
            [self.navigationController pushViewController:toolsVC animated:YES];
        }
        else
        {
            combatAssistantViewController * combatAsVC = [[combatAssistantViewController alloc] init];
            [self.navigationController pushViewController:combatAsVC animated:YES];
        }
    }
    else if (indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            officialWebViewController * officWeb = [[officialWebViewController alloc] init];
            [self.navigationController pushViewController:officWeb animated:YES];
        }
        else
        {
            [a show];
            a = nil;
        }
    }
    else if (indexPath.section == 2)
    {
        if(indexPath.row == 0) // 跳转二维码页面
        {
            twoCodeViewController * twoCodeVC = [[twoCodeViewController alloc] init];
            [self.navigationController pushViewController:twoCodeVC animated:YES];
        }
        else
        {
            [a show];
            a = nil;
        }
    }
    
    
}








@end
