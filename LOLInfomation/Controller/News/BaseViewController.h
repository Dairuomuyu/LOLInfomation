//
//  BaseViewController.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    NSMutableArray * _adArr; // 存放广告页数据
    NSMutableArray * _dataArr; // 存放详细页数据
    RequestType _requestType; // 用于区别不同页面的请求
    MBProgressHUD * HUD; // 指示器
}

@property (nonatomic,strong) UITableView * tableView;
/**
 *  加载更多动画
 */
@property (nonatomic,strong) NSMutableArray * refreshingImages;
/**
 *  加载更多数据
 */
- (void)loadMoreData;
/**
 *  刷新本页数据
 */
- (void)loadNewestData;
@end
