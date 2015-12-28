//
//  NewsAdvModel.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsAdvModel : NSObject
/**
 *  广告ID
 */
@property (nonatomic,strong) NSString * article_id;
/**
 *  未知计数属性
 */
@property (nonatomic,strong) NSString * comment_count;
/**
 *  广告图片Url
 */
@property (nonatomic,strong) NSString * ban_img;
/**
 *  广告标题
 */
@property (nonatomic,strong) NSString * name;


// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;
// 工厂方法
+ (NewsAdvModel *)newsAdvModelWithDict:(NSDictionary *)dic;
@end
