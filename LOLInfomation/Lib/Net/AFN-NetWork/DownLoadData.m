//
//  DownLoadData.m
//
//  Created by 李沛池 on 15/5/18.
//  Copyright (c) 2015年 李沛池. All rights reserved.
//

#import "DownLoadData.h"
#import "AFAppDotNetAPIClient.h"
#import "NewsAdvModel.h"
#import "NewsDetailModel.h"
#import "HerosModel.h"
#import "toolsModel.h"
#import "HeroDetailModel.h"

@implementation DownLoadData

/**
 *  获取“最新”页数据
 */
+ (NSURLSessionDataTask *) getRequestType:(RequestType)type withData:(void (^) (id obj, NSError * err))block withPage:(int)page
{
    NSString * url = nil;
    // @[newestVC, S5VC, gameVC, videoVC, funVC,officialVC,girlVC,strategyVC];
    switch (type) {
        case Enum_NewsPage:
            url = [NSString stringWithFormat:kLatestNewsUrlString,page];
            break;
        case Enum_S5Page:
            url = [NSString stringWithFormat:kS4UrlString,page];
            break;
        case Enum_GamePage:
            url = [NSString stringWithFormat:kMatchUrlStirng,page];
            break;
        case Enum_VideoPage:
            url =[NSString stringWithFormat:kLatestNewsUrlString,page];
            break;
        case Enum_FunPage:
            url = [NSString stringWithFormat:kGreatUrlString,page];
            break;
        case Enum_OfficalPage:
            url = [NSString stringWithFormat:kOfficialUrlString,page];
            break;
        case Enum_GirlPage:
            url = [NSString stringWithFormat:kBeautifulGirlUrlString,page];
            break;
        case Enum_StrategyPage:
            url = [NSString stringWithFormat:kStrategyUrlString,page];
            break;
        default:
            break;
    }
    
    return [[AFAppDotNetAPIClient sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        
        // 处理“广告”页面数据
        NSArray * recomm_ModelArr = responseObject[@"recomm"]; // 获取新闻业广告信息
        NSMutableArray * newsAdv_ModelArr = [NSMutableArray array]; // 创建可变数组，储存数据模型
        // 字典转模型
        [recomm_ModelArr enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL *stop) {
            NewsAdvModel * model = [NewsAdvModel newsAdvModelWithDict:dic]; // 创建数据模型
            [newsAdv_ModelArr addObject:model]; // 将数据模型添加到数组中
        }];
        
        
        // 处理“详细”页面数据
        NSArray * result_ModelArr = responseObject[@"result"]; // 获取新闻页详细信息
        NSMutableArray * newsDetail_ModelArr = [NSMutableArray array]; // 创建可变数组，储存数据模型
        // 字典转模型
        [result_ModelArr enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL *stop) {
            NewsDetailModel * model = [NewsDetailModel newsDetailModelWithDict:dic]; // 创建数据模型
            [newsDetail_ModelArr addObject:model]; // 将数据模型添加到数组中
        }];
        
        NSArray * resultArr = @[newsAdv_ModelArr,newsDetail_ModelArr];
        
        if(block)
        {
            block(resultArr,nil); // 回传“广告”和“详细”数据
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"NewPage---数据下载失败");
        if(block)
        {
            block(nil,error);
        }
    }];
}

/**
 *  获取“英雄”页数据
 */
+ (NSURLSessionDataTask *) getHerosPageRequestType:(RequestType)type withData:(void (^) (id obj,id firstNameArr, NSError * err))block
{
    NSString * url = nil;
    switch (type) {
        case Enum_FreeHerosPage:
            url = [NSString stringWithFormat:kFreeHeroUrlString];
            break;
        case Enum_AllHerosPage:
            url = [NSString stringWithFormat:kAllHeroUrlString];
            break;
        default:
            break;
    }
    return [[AFAppDotNetAPIClient sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        // 处理“英雄”页面数据
        // 获取英雄信息
        NSArray * result_ModelArr = responseObject[@"result"];
        // 创建一个包含26个数组的容器，储存分类后的数据模型
        NSMutableArray * heros_ModelArr = [NSMutableArray array];
        for (int i = 'A'; i <= 'Z'; i++)
        {
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            [heros_ModelArr addObject:arr];
        }
        
        // 字典转模型

        [result_ModelArr enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL *stop) {
            
            // 创建数据模型
            HerosModel * model = [HerosModel herosModelWithDict:dic];
            // 算出英雄名字的第一个字母
            char heroNameFirstLetter = [[PinYinForObjc chineseConvertToPinYin:model.title] characterAtIndex:0];
            // 算出对应首字母应该存放在哪个数组
            int arrNum = heroNameFirstLetter - 'a';
            // 将模型添加到对应数组中
            [[heros_ModelArr objectAtIndex:arrNum] addObject:model];
            
        }];
        
        // 将空数组移除，同时将有数据的数组数列存放起来
        // 创建存储分组首字母数组
        NSMutableArray * heroNameFirstLetterArr = [[NSMutableArray alloc] init];
        for(int i = 0; i < heros_ModelArr.count; i++)
        {
            [heros_ModelArr removeObject:[NSArray array]];
            HerosModel * model = heros_ModelArr[i][0];
            [heroNameFirstLetterArr addObject:[NSString stringWithFormat:@"%c",[[PinYinForObjc chineseConvertToPinYin:model.title] characterAtIndex:0]]];
        }
        // 将数据回传“英雄页”
        if(block)
        {
            block(heros_ModelArr,heroNameFirstLetterArr,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"HerosPage---数据下载失败");
        if(block)
        {
            block(nil,nil,error);
        }
    }];
}

/**
 *  获取“道具”页数据
 */
+ (NSURLSessionDataTask *) getToolsPageRequestType:(RequestType)type withData:(void (^) (id obj, NSError * err))block
{
    NSString * url = nil;
    switch (type) {
        case Enum_ToolsPage:
            url = [NSString stringWithFormat:kEquipmentUrlString];
            break;
        default:
            break;
    }
    return [[AFAppDotNetAPIClient sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        // 处理“道具”页面数据
         NSMutableArray * tools_ModelArr = [NSMutableArray array]; // 创建可变数组，储存数据模型
        // 获取道具信息
        NSArray * result_ModelArr = responseObject[@"result"];
        // 字典转模型
        [result_ModelArr enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL *stop) {
            
            // 创建数据模型
            toolsModel * model = [toolsModel toolsModelWithDict:dic];
            // 将模型添加到对应数组中
            [tools_ModelArr addObject:model];
        }];

        // 将数据回传“英雄页”
        if(block)
        {
            block(tools_ModelArr,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"ToolsPage---数据下载失败");
        if(block)
        {
            block(nil,error);
        }
    }];
}

/**
 *  获取“英雄详细”页数据
 */
+ (NSURLSessionDataTask *) getHeroDetailPageRequestType:(RequestType)type withData:(void (^) (id obj, NSError * err))block withHeroID:(NSString *)heroID
{
    NSString * url = nil;
    switch (type) {
        case Enum_HeroDetailPage:
            url = [NSString stringWithFormat:kHeroDetailInfoUrlString,heroID];
            break;
        default:
            break;
    }
    return [[AFAppDotNetAPIClient sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
//        // 处理“英雄详细”页面数据
//        NSMutableArray * heroDetail_ModelArr = [NSMutableArray array]; // 创建可变数组，储存数据模型
//        // 获取道具信息
//        NSArray * result_ModelArr = responseObject[@"result"];
//        // 字典转模型
//        [result_ModelArr enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL *stop) {
//            
//            // 创建数据模型
//            HeroDetailModel * model = [HeroDetailModel heroDetailModelWithDict:dic];
//            // 将模型添加到对应数组中
//            [heroDetail_ModelArr addObject:model];
//        }];
        
        // 创建数据模型
        HeroDetailModel * model = [HeroDetailModel heroDetailModelWithDict:responseObject[@"result"]];
        
        // 将数据回传“英雄页”
        if(block)
        {
            block(model,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"DownLoadData---数据下载失败");
        if(block)
        {
            block(nil,error);
        }
    }];
}

@end























