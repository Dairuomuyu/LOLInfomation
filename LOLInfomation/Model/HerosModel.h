//
//  HerosModel.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HerosModel : NSObject
/**
 *  英雄ID
 */
@property (nonatomic,strong) NSString * heroId;
/**
 *  英雄名字
 */
@property (nonatomic,strong) NSString * name_c;
/**
 *  英雄别名
 */
@property (nonatomic,strong) NSString * title;
/**
 *  英雄图片url
 */
@property (nonatomic,strong) NSString * img;
/**
 *  战斗类型
 */
@property (nonatomic,strong) NSString * tags;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;
// 工厂方法
+ (HerosModel *)herosModelWithDict:(NSDictionary *)dic;
@end
