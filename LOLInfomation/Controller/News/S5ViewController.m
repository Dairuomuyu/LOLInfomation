//
//  S5ViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "S5ViewController.h"
static int pageNum = 1;
@interface S5ViewController ()

@end

@implementation S5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewestData]; // 页面第一次显示出来时请求数据
}
// 加载更多数据
- (void)loadMoreData
{
    [DownLoadData getRequestType:Enum_S5Page withData:^(NSArray * obj, NSError *err) {
        if(obj)
        {
            [_dataArr addObjectsFromArray:[obj lastObject]];
            [self.tableView reloadData];
            [self.tableView.footer endRefreshing];
        }
        else
        {
            UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据下载失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //[a show];
            NSLog(@"活动页---数据下载失败");
            a = nil;
        }
    } withPage:++pageNum];
}
// 下拉刷新本页数据
- (void)loadNewestData
{
    [DownLoadData getRequestType:Enum_S5Page withData:^(NSArray * obj, NSError *err) {
        if(obj)
        {
            _adArr = [obj firstObject];
            _dataArr = [obj lastObject];
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
            pageNum = 1;
        }
        else
        {
            UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据下载失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //  [a show];
            NSLog(@"活动页---数据下载失败");
            a = nil;
        }
    } withPage:1];
}
@end
