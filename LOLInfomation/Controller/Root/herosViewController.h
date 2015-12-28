//
//  herosViewController.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface herosViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _freeHerosDataArr; // 存放免费英雄页数据
    NSMutableArray * _allHerosDataArr; // 存放所有英雄数据
    NSMutableArray * _freeFirstNameArr;
    NSMutableArray * _allFirstNameArr;
}
@property (nonatomic,strong) UITableView * tableFreeHeros;
@property (nonatomic,strong) UITableView * tableAllHeros;
@property (nonatomic,strong) UISegmentedControl * segmentHero;
@end
