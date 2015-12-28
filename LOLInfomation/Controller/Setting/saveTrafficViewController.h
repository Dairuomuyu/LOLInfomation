//
//  saveTrafficViewController.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface saveTrafficViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataArr; // 数据源
}
@property (nonatomic,strong) UITableView * tableView;

@end
