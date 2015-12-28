//
//  heroDetailARSegmentPageController.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "ARSegmentPageController.h"
#import "HeroRefreshDataProtocol.h"
@class HeroDetailModel;
@interface heroDetailARSegmentPageController : ARSegmentPageController<HeroRefreshDataProtocol>
{
    HeroDetailModel * _heroDetailModel; // 存放英雄所有数据
    MBProgressHUD * HUD; // 指示器
}
/**
 *  接受“英雄”页面传递过来的英雄ID
 */
@property(nonatomic,strong) NSString * heroID;
/**
 *  实现<HeroRefreshDataProtocol>中的方法
 */
- (void)loadData;

@end
