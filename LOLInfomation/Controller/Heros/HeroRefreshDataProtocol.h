//
//  HeroRefreshDataProtocol.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HeroRefreshDataProtocol <NSObject>
/**
 *  实现英雄详细界面下拉刷新
 */
- (void)loadData;

@end
