//
//  heroSkillTableViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "heroSkillTableViewController.h"
#import "heroSkillTableViewCell.h"
@interface heroSkillTableViewController ()
{
    
}
@end

@implementation heroSkillTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置头刷新功能
    [self addMJRefreshAutoGifHeader];
    // 数据刷新之前，隐藏页面中的表格
    self.tableView.tableFooterView = [[UIView alloc] init];
    // 注册cell
    UINib *nibName = [UINib nibWithNibName:@"heroSkillTableViewCell" bundle:nil];
    [self.tableView registerNib:nibName forCellReuseIdentifier:@"cellID"];
    
    self.automaticallyAdjustsScrollViewInsets = NO; // 解决TableView错位的问题
}

-(NSString *)segmentTitle
{
    return @"英雄技能";
}

-(UIScrollView *)streachScrollView
{
    return self.tableView;
}
#pragma mark --- <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        static NSString * cellID = @"cellid1";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"英雄技能:";
            cell.imageView.image = [UIImage imageNamed:@"hero_blue_icon@2x.png"];
        }
        return cell;
    }
    else
    {
        heroSkillTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        [cell setMyLabelText:self.skillArr andIndexPath:indexPath];
        

        return  cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 20;
    }
    else
    {
        // 调用初始化cell内容方法，计算出当前cell的高度
        // heroSkillTableViewCell * cell = (heroSkillTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        // return cell.frame.size.height;
        return  200;
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
