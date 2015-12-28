//
//  herosTableViewCell.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "herosTableViewCell.h"
#import "HerosModel.h"

@interface herosTableViewCell ()

@property (strong, nonatomic)  UIImageView *imageV; // 英雄头像
@property (strong, nonatomic)  UILabel *bigName; // 别名
@property (strong, nonatomic)  UILabel *name; // 真名
@property (strong, nonatomic)  UILabel *heroStyle; // 英雄类型

@end
@implementation herosTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone; // 消除选中效果
    
    // 为cell内容添加约束
    CGFloat cellHeight = 70; // 约定好的cell高度
    CGFloat cellWidth = SCREEN_WIDTH; // 和屏幕等宽
    
    // imageV
    _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_hero_head@2x.png"]];
    _imageV.frame = CGRectMake(10, 8, cellHeight - 8*2, cellHeight - 8*2);
    _imageV.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_imageV];
    
    // bigName
    _bigName = [[UILabel alloc] initWithFrame:CGRectMake(10 + _imageV.frame.size.width + 10, 10, (cellWidth - (10 + _imageV.frame.size.width + 10))/3, 20)];
    _bigName.numberOfLines = 0;
    _bigName.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_bigName];
    
    // name
    _name = [[UILabel alloc] initWithFrame:CGRectMake(10 + _imageV.frame.size.width + _bigName.frame.size.width + 10, 10, (cellWidth - (10 + _imageV.frame.size.width + 10))/3, 20)];
    _name.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    _name.numberOfLines = 0;
    _name.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_name];
    
    //heroStyle
    _heroStyle = [[UILabel alloc] initWithFrame:CGRectMake(10 + _imageV.frame.size.width + 10,5+_bigName.frame.size.height + 5, cellWidth - (10 + _imageV.frame.size.width + 10) -5, 20)];
    _heroStyle.font = [UIFont systemFontOfSize:13];
    _heroStyle.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [self.contentView addSubview:_heroStyle];
    
}

// 刷新Cell方法 （需要数据）
- (void)updateCellWithApplication:(HerosModel *)model andIndexPath:(NSIndexPath *)indexPath;
{
    [self.imageV setImageWithURL:[NSURL URLWithString:model.img]];
    self.bigName.text = model.title;
    self.name.text = model.name_c;
    self.heroStyle.text = model.tags;
}

@end
