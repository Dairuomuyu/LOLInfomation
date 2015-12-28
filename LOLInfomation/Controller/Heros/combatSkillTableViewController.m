//
//  combatSkillTableViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "combatSkillTableViewController.h"
#import "combatSkillTableViewCell.h"

@interface combatSkillTableViewController ()

@end

@implementation combatSkillTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置头刷新功能
    [self addMJRefreshAutoGifHeader];
    // 数据刷新之前，隐藏页面中的表格
    self.tableView.tableFooterView = [[UIView alloc] init];
    // 注册cell
    UINib *nibName = [UINib nibWithNibName:@"combatSkillTableViewCell" bundle:nil];
    [self.tableView registerNib:nibName forCellReuseIdentifier:@"cellID"];
    
    self.automaticallyAdjustsScrollViewInsets = NO; // 解决TableView错位的问题
}

-(NSString *)segmentTitle
{
    return @"战斗技巧";
}
-(UIScrollView *)streachScrollView
{
    return self.tableView;
}
#pragma mark --- <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0) // 设置 1、3 行
    {
        static NSString * cellID = @"cellid1";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.imageView.image = [UIImage imageNamed:@"hero_blue_icon@2x.png"];
            if(indexPath.row == 0)
            {
                cell.textLabel.text = [NSString stringWithFormat:@"使用技巧:"];
            }
            else
            {
                cell.textLabel.text = [NSString stringWithFormat:@"对线技巧:"];
            }
        }
        return cell;
    }
    else
    {
        combatSkillTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        // [cell updateCellWithApplication:self.heroBackground andIndexPath:indexPath];
        if(indexPath.row == 1)
        {
            [cell setGistArr:self.use_gist];
        }
        else
        {
            [cell setGistArr:self.against_gist];
        }
        return  cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0) // 设置 1、3 行
    {
        return 20;
    }
    else
    {
        // 调用初始化cell内容方法，计算出当前cell的高度
        combatSkillTableViewCell * cell = (combatSkillTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
}
// 下拉刷新
- (void)addMJRefreshAutoGifHeader
{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(delegateRefreshData)];
    self.tableView.header = header;
}
- (void)delegateRefreshData
{
    if([self.delegate respondsToSelector:@selector(loadData)])
    {
        [self.delegate loadData];
        [self.tableView.header endRefreshing];
    }
}
@end
