//
//  heroSkillTableViewCell.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface heroSkillTableViewCell : UITableViewCell
/**
 *  显示英雄技能详细介绍
 */
@property (strong, nonatomic) UILabel * myLabel;
/**
 *  三件图片
 */
@property (strong, nonatomic) UIImageView * pointImage;
/**
 *  技能图片所用的单击手势
 */
@property (strong,nonatomic) UITapGestureRecognizer * tapBtn;
/**
 *  存储英雄每个技能的详细介绍
 */
@property (strong,nonatomic) NSMutableArray * skillArr;
/**
 *  存储英雄每个技能的详细介绍
 */
@property (strong,nonatomic) NSMutableArray * skillImageURLArr;
/**
 *  指向技能的三角图标
 */
@property (strong, nonatomic) IBOutlet UIImageView *pointTo;

//刷新cell内容
// - (void)updateCellWithApplication:(NSDictionary *)modelDic andIndexPath:(NSIndexPath *)indexPath;

// 根据文本内容重新计算cell高度
-(void)setMyLabelText:(NSArray *)skillModelArr andIndexPath:(NSIndexPath *)indexPath;

@end
