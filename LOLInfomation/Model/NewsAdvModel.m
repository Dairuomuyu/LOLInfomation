//
//  NewsAdvModel.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "NewsAdvModel.h"

@implementation NewsAdvModel
// 为与关键字重复的成员变量赋值
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

// 防止外界访问不存在的属性时崩溃
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil; // 属性不存在时返回nil
}

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


// 工厂方法
+ (NewsAdvModel *)newsAdvModelWithDict:(NSDictionary *)dic
{
    NewsAdvModel * model = [[self alloc] initWithDic:dic];
    return  model;
}
@end
