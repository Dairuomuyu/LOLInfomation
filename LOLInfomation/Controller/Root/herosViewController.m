//
//  herosViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "herosViewController.h"
#import "herosTableViewCell.h"
#import "ARSegmentPageController.h" // 第三方插件
#import "heroDetailARSegmentPageController.h"
#import "HerosModel.h"
#import "RDVTabBarController.h"
@interface herosViewController ()

@end

@implementation herosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"英雄";
    
    // 创建“分段控件”
    _segmentHero = [[UISegmentedControl alloc] initWithItems:@[@"本周限免",@"全部英雄"]];
    _segmentHero.frame = CGRectMake(0, 0, 150, 30);
    _segmentHero.selectedSegmentIndex = 0;
    [_segmentHero addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
    
    // 去掉分段控件外边框，并设置选中/未选中文字效果
    _segmentHero.tintColor = [UIColor clearColor];//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                             NSForegroundColorAttributeName: [UIColor whiteColor]};
    [_segmentHero setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],
                                               NSForegroundColorAttributeName: [UIColor lightTextColor]};
    [_segmentHero setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    self.navigationItem.titleView = _segmentHero;
    
    // 创建“全部英雄列表”
    _tableAllHeros = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 20 - 44) style:UITableViewStyleGrouped];
    _tableAllHeros.delegate = self;
    _tableAllHeros.dataSource = self;
    _tableAllHeros.autoresizesSubviews = NO;
    _tableAllHeros.tableFooterView = [[UIView alloc] init]; // 数据刷新之前，隐藏页面中的表格
        [self.view addSubview:_tableAllHeros];
    
    // 创建“限免英雄列表”
    _tableFreeHeros = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 20 - 44) style:UITableViewStyleGrouped];
    _tableFreeHeros.delegate = self;
    _tableFreeHeros.dataSource = self;
    _tableFreeHeros.autoresizesSubviews = NO;
    _tableFreeHeros.tableFooterView = [[UIView alloc] init]; // 数据刷新之前，隐藏页面中的表格
    [self.view addSubview:_tableFreeHeros];
    
    self.automaticallyAdjustsScrollViewInsets = NO; // 解决两个TableView错位的问题
    
    // 注册cell
    UINib *nibName = [UINib nibWithNibName:@"herosTableViewCell" bundle:nil];
    [self.tableFreeHeros registerNib:nibName forCellReuseIdentifier:@"cellID"];
    [self.tableAllHeros registerNib:nibName forCellReuseIdentifier:@"cellID"];

    // 请求数据
    [DownLoadData getHerosPageRequestType:Enum_FreeHerosPage withData:^(NSMutableArray * obj, NSMutableArray * firstNameArr, NSError *err) {
         _freeHerosDataArr = obj;
        _freeFirstNameArr = firstNameArr;
        [self.tableFreeHeros reloadData];
    }];
    
    [DownLoadData getHerosPageRequestType:Enum_AllHerosPage withData:^(NSMutableArray * obj, NSMutableArray * firstNameArr, NSError *err) {
        _allHerosDataArr = obj;
        _allFirstNameArr = firstNameArr;
        [self.tableAllHeros reloadData];
    }];
    
    // 添加返回顶部按钮
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIImage * toTopImage = [UIImage imageNamed:@"arrow@2x.png"];
    [btn setImage:toTopImage forState:UIControlStateNormal];
    btn.frame = CGRectMake(SCREEN_WIDTH - toTopImage.size.width* 1.5 -10 , SCREEN_HEIGHT - NAV_TAB_BAR_HEIGHT - toTopImage.size.height* 1.5, toTopImage.size.height * 1.5, toTopImage.size.width*1.5);
    [self.view addSubview:btn];
}
// 实现返回按钮方法
- (void)pressBtn:(id)sender
{
    if(self.segmentHero.selectedSegmentIndex == 0)
    {
        [self.tableFreeHeros setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else
    {
        [self.tableAllHeros setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
#pragma mark --- <UITableViewDelegate>
// 设置section数量
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual:_tableFreeHeros])
    {
        return  _freeHerosDataArr.count;
    }
    else
    {
        return  _allHerosDataArr.count;
    }
}
// 设置cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_tableFreeHeros])
    {
        if(!_freeHerosDataArr)
        {
            return 0;
        }
        return [_freeHerosDataArr[section] count];
    }
    else
    {
        if(!_allHerosDataArr)
        {
            return 0;
        }
        return [_allHerosDataArr[section] count];
    }
}
// 设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual: _tableFreeHeros]) // 判断是哪个TableView
    {
        herosTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        [cell updateCellWithApplication:_freeHerosDataArr[indexPath.section][indexPath.row] andIndexPath:indexPath];
        return cell;
    }
    else
    {
        herosTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        [cell updateCellWithApplication:_allHerosDataArr[indexPath.section][indexPath.row] andIndexPath:indexPath];
        return cell;
    }
}
// 通过segment实现table切换
- (void)segmentValueChange:(id)sender
{
    UISegmentedControl * segment = (UISegmentedControl *)sender;
    
    if(segment.selectedSegmentIndex == 0)
    {
        _tableFreeHeros.hidden = NO;
        _tableAllHeros.hidden = YES;
    }
    else
    {
        _tableFreeHeros.hidden = YES;
        _tableAllHeros.hidden = NO;
    }
}
// 页面出现时显示免费页，隐藏全部页
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _tableFreeHeros.hidden = NO;
    _tableAllHeros.hidden = YES;
    // 将导航栏设置为透明
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    // 设置背景视图颜色
    self.view.backgroundColor = [UIColor colorWithRed:42/255.0 green:44/255.0  blue:53/255.0  alpha:1];
    // 当从别的页面返回时，将segment的selectedSegmentIndex属性设置为“0”
    _segmentHero.selectedSegmentIndex = 0;
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES]; // 界面显示时显示底部tabBAr
}
// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
// 设置头标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
// 设置头标题内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:_tableFreeHeros])
    {
        return [NSString stringWithFormat:@"%@",_freeFirstNameArr[section]];
    }
    else
    {
        return [NSString stringWithFormat:@"%@",_allFirstNameArr[section]];
    }
}
#warning 下面方法未完全实现，需要将右侧边索引与筛选后的首字母数组对应起来
// 表格自带的搜索方法
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    // 修改索引视图背景颜色
//    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//    
//    if([tableView isEqual:_tableAllHeros])
//    {
//        // 数组中存放分区的区标题的名称
//        NSMutableArray * arr = [[NSMutableArray alloc] init];
//        for(int i = 'A'; i < 'Z'; i++)
//        {
//            [arr addObject:[NSString stringWithFormat:@"%c",i]];
//        }
//        return arr;
//    }
//    else
//    {
//        // 数组中存放分区的区标题的名称
//        NSMutableArray * arr = [[NSMutableArray alloc] init];
//        for(int i = 'A'; i < 'Z'; i++)
//        {
//            [arr addObject:[NSString stringWithFormat:@"%c",i]];
//        }
//        return arr;
//    }
//}

#pragma mark --- 选中cell后实现新闻详细页面跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HerosModel * model = [[HerosModel alloc] init];
    if([tableView isEqual:self.tableFreeHeros])
    {
        // 获取当前选中的cell对应的数据模型
        model = _freeHerosDataArr[indexPath.section][indexPath.row];
    }
    else
    {
        // 获取当前选中的cell对应的数据模型
        model = _allHerosDataArr[indexPath.section][indexPath.row];
    }

    // 创建新闻详细页面
    heroDetailARSegmentPageController * heroDetailPage = [[heroDetailARSegmentPageController alloc] init];
    // 将新闻ID向详细页面传递
    heroDetailPage.heroID = model.heroId;
    [self.navigationController pushViewController:heroDetailPage animated:YES];
}









@end
