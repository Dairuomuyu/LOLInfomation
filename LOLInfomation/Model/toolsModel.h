//
//  toolsModel.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface toolsModel : NSObject
/**
 *  道具ID
 */
@property (nonatomic,strong) NSString * toolsID;
/**
 *  道具图片地址
 */
@property (nonatomic,strong) NSString * icon;
/**
 *  道具名称
 */
@property (nonatomic,strong) NSString * name;


// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;
// 工厂方法
+ (toolsModel *)toolsModelWithDict:(NSDictionary *)dic;

@end
