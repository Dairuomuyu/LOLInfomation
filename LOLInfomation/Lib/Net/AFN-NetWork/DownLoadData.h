//
//  DownLoadData.h
//
//  Created by 李沛池 on 15/5/18.
//  Copyright (c) 2015年 李沛池. All rights reserved.
//



#import <Foundation/Foundation.h>

#define Request_Type @"RequestType"
#define SUCCESS @"SUCCESS"
#define OBJECT @"OBJECT"

// 添加一个枚举，用来记录不同界面的名称
typedef enum : NSUInteger{
    Enum_NewsPage = 1000,
    Enum_S5Page,
    Enum_GamePage,
    Enum_TalkPage,
    Enum_GirlPage,
    Enum_StrategyPage,
    Enum_OfficalPage,
    Enum_VideoPage,
    Enum_FunPage,
    Enum_AllHerosPage,
    Enum_FreeHerosPage,
    Enum_ToolsPage,
    Enum_HeroDetailPage,
}RequestType;

@interface DownLoadData : NSObject

/**
 *  获取“新闻页”数据
 */
+ (NSURLSessionDataTask *) getRequestType:(RequestType)type withData:(void (^) (id obj, NSError * err))block withPage:(int)page;
/**
 *  获取“英雄页”数据
 */
+ (NSURLSessionDataTask *) getHerosPageRequestType:(RequestType)type withData:(void (^) (id obj,id firstNameArr, NSError * err))block;
/**
 *  获取“道具”数据
 */
+ (NSURLSessionDataTask *) getToolsPageRequestType:(RequestType)type withData:(void (^) (id obj,NSError * err))block;
/**
 *  获取“英雄详细”页数据
 */
+ (NSURLSessionDataTask *) getHeroDetailPageRequestType:(RequestType)type withData:(void (^) (id obj, NSError * err))block withHeroID:(NSString *)heroID;
@end















