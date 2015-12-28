//
//  BaseViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "BaseViewController.h"
#import "newsPageTableViewCell.h"
#import "ScrollTableViewCell.h"
#import "newDetailPageViewController.h"
#import "RDVTabBarController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES; // 界面显示时隐藏导航栏控制器
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES]; // 界面显示时显示底部tabBAr
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 20 - 44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizesSubviews = NO;
    _tableView.tableFooterView = [[UIView alloc] init]; // 数据刷新之前，隐藏页面中的表格
    [self.view addSubview:_tableView];
    
    // 注册cell
    UINib *nibName = [UINib nibWithNibName:@"newsPageTableViewCell" bundle:nil];
    [self.tableView registerNib:nibName forCellReuseIdentifier:@"cellID"];
    
    // 设置头尾刷新功能
    [self addMJRefreshAutoGifHeader];
    [self addMJRefreshAutoGifFooter];
    
}
#pragma mark --- 实现<UITableViewDataSource,UITableViewDelegate>协议中方法
// 设置cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!_dataArr)
    {
        return 0;
    }
    return _dataArr.count + 1;
}
// 设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        static NSString * cellID1 = @"cellID1";
        ScrollTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if(!cell)
        {
            cell = [[ScrollTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        }
        [cell updateCellWithApplication:_adArr];
        return cell;
    }
    else
    {
        newsPageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        [cell updateCellWithApplication:_dataArr[indexPath.row-1] andIndexPath:indexPath];
        return  cell;
    }
}
// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 160;
    }
    else
    {
        return 80;
    }
}
#pragma mark --- 上、下拉动刷新
// 懒加载   初始化动画图片数组
- (NSMutableArray *)refreshingImages
{
    // 设置刷新图片
    _refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"common_loading_anne_%ld", i]];
        [_refreshingImages addObject:image];
    }
    return _refreshingImages;
}
// 下拉刷新
- (void)addMJRefreshAutoGifHeader
{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewestData)];
     self.tableView.header = header;
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"努力加载中 ..." forState:MJRefreshStateRefreshing];
}
// 上拉刷新
- (void)addMJRefreshAutoGifFooter
{
    // 创建刷新控件
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置刷新时动画
    [footer setImages:self.refreshingImages forState:MJRefreshStateRefreshing];
    // 添加到尾部
    self.tableView.footer = footer;
}
// 下拉刷新本页数据
- (void)loadNewestData
{
    // 各页面控制器进行实现
}
// 加载更多数据
- (void)loadMoreData
{
    // 各页面控制器进行实现
}
#pragma mark --- 选中cell后实现新闻详细页面跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取当前选中的cell对应的数据模型
    NewsDetailModel * model = _dataArr[indexPath.row-1];
    // 创建新闻详细页面
    newDetailPageViewController * newsDetaiPage = [[newDetailPageViewController alloc] init];
    // 将新闻ID向详细页面传递
    newsDetaiPage.newsID = model.newsDetail_id;
    [self.navigationController pushViewController:newsDetaiPage animated:YES];
}














@end
