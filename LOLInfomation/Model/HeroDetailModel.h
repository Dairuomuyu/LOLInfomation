//
//  HeroDetailModel.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroDetailModel : NSObject
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
 *  英雄头像图片url
 */
@property (nonatomic,strong) NSString * img;
/**
 *  英雄顶部大图url
 */
@property (nonatomic,strong) NSString * img_top;
/**
 *  战斗类型
 */
@property (nonatomic,strong) NSString * tags;
/**
 *  购买所需金币
 */
@property (nonatomic,strong) NSString * price_score;
/**
 *  购买所需点卷
 */
@property (nonatomic,strong) NSString * price_rmb;
/**
 *  物理攻击强度
 */
@property (nonatomic,strong) NSString * physical_p;
/**
 *  法术攻击强度
 */
@property (nonatomic,strong) NSString * skill_attack_p;
/**
 *  防御强度
 */
@property (nonatomic,strong) NSString * life_p;
/**
 *  操作难度
 */
@property (nonatomic,strong) NSString * operate_p;
/**
 *  英雄背景故事
 */
@property (nonatomic,strong) NSString * background;
/**
 *  使用技巧(里面包含三条内容)
 */
@property (nonatomic,strong) NSArray * use_gist;
/**
 *  对抗技巧(里面包含三条内容)
 */
@property (nonatomic,strong) NSArray * against_gist;
/**
 *  英雄技能（里面包含四个字典，需要模型再次解析）
 */
@property (nonatomic,strong) NSArray * skill;


// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;
// 工厂方法
+ (HeroDetailModel *)heroDetailModelWithDict:(NSDictionary *)dic;
@end
