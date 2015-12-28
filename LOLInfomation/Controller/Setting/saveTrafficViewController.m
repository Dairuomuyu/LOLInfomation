//
//  saveTrafficViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "saveTrafficViewController.h"
#import "RDVTabBarController.h"
#import "saveTrafficTableViewCell.h"

static NSInteger num = 0; // 保留选中的cell行数

@interface saveTrafficViewController ()

@end

@implementation saveTrafficViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES]; // 界面显示时隐藏底部tabBAr
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资源图片自动下载设置";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizesSubviews = NO;
    _tableView.tableFooterView = [[UIView alloc] init]; // 数据刷新之前，隐藏页面中的表格
    _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[saveTrafficTableViewCell class] forCellReuseIdentifier:@"savecell"];
}

#pragma mark --- <UITableViewDataSource,UITableViewDelegate>

// 设置每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
// 设置cell内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * titleArr1 = @[@"所有网络",@"仅wifi",@"关闭图片自动下载"];

    // 创建自定义cell
    saveTrafficTableViewCell * saveCell = [tableView dequeueReusableCellWithIdentifier:@"savecell"];
    saveCell.selectionStyle = UITableViewCellSelectionStyleNone;
    saveCell.textLabel.font = [UIFont systemFontOfSize:15];
    saveCell.textLabel.text = titleArr1[indexPath.row];
    
    // 设置cell图片
    if(indexPath.row == num)
    {
        saveCell.myImage.image = [UIImage imageNamed:@"advanced_select_share_view_selected@2x.png"];
    }
    else
    {
        saveCell.myImage.image = [UIImage imageNamed:@"advanced_select_share_view_unselected@2x.png"];
    }
    return saveCell;
}
// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

// 选中后改变cell图片内容
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 保留选中的cell行数
    num = indexPath.row;
    
    // 遍历所有cell 重新设置里面的图片
    for(int i = 0; i <= indexPath.length; i ++)
    {
        saveTrafficTableViewCell * cell = (saveTrafficTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
        if(indexPath.row == i)
        {
            cell.myImage.image = [UIImage imageNamed:@"advanced_select_share_view_selected@2x.png"];
        }
        else
        {
            cell.myImage.image = [UIImage imageNamed:@"advanced_select_share_view_unselected@2x.png"];
        }
    } 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
