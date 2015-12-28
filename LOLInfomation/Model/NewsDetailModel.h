//
//  NewsDetailModel.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailModel : NSObject
/**
 *  详细内容ID
 */
@property (nonatomic,strong) NSString * newsDetail_id;
/**
 *  cell大标题
 */
@property (nonatomic,strong) NSString * title;
/**
 *  位置计数属性
 */
@property (nonatomic,strong) NSString * comment_count;
/**
 *  来源？
 */
@property (nonatomic,strong) NSString * source;
/**
 *  cell图标Url地址
 */
@property (nonatomic,strong) NSString * icon;
/**
 *  新闻内容简介
 */
@property (nonatomic,strong) NSString * newsShortDetail;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;
// 工厂方法
+ (NewsDetailModel *)newsDetailModelWithDict:(NSDictionary *)dic;
@end
