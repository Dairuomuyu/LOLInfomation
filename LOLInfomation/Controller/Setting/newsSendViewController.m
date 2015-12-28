//
//  newsSendViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "newsSendViewController.h"
#import "RDVTabBarController.h"
#import "setCustomTableViewCell.h"
@interface newsSendViewController ()

@end

@implementation newsSendViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES]; // 界面显示时隐藏底部tabBAr
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息推送设置";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizesSubviews = NO;
    _tableView.tableFooterView = [[UIView alloc] init]; // 数据刷新之前，隐藏页面中的表格
    _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[setCustomTableViewCell class] forCellReuseIdentifier:@"setcell"];
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
        return 2;
    }
    else
    {
        return 1;
    }
}
// 设置cell内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * titleArr1 = @[@"接收新消息通知"];
    NSArray * titleArr2 = @[@"掌盟好友提醒"];
    NSArray * titleArr3 = @[@"声音",@"震动"];
    
    // 创建系统默认格式cell
    static NSString * cellID = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    // 创建自定义cell
    setCustomTableViewCell * swithCell = [tableView dequeueReusableCellWithIdentifier:@"setcell"];
    swithCell.selectionStyle = UITableViewCellSelectionStyleNone;
    swithCell.textLabel.font = [UIFont systemFontOfSize:15];
    if(indexPath.section == 0)
    {
        cell.textLabel.text = titleArr1[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 1)
    {
        swithCell.textLabel.text = titleArr2[indexPath.row];
    }
    else
    {
        swithCell.textLabel.text = titleArr3[indexPath.row];
    }
    return swithCell;
    
}
// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
// 设置尾部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
// 设置每个分组的尾部视图内容
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel * label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    
    if(section == 0)
    {
        label.text = @"   请在你设备的“设置”-“通知”中进行修改";
    }
    else if (section == 1)
    {
        label.text = @"   开启掌盟好友提醒，在您登陆英雄联盟游戏时，会向您推荐您\n   的掌盟好友";
    }
    return label;
}
// cell选中后页面跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
