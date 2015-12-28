//
//  combatSkillTableViewCell.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "combatSkillTableViewCell.h"

@implementation combatSkillTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone; // 消除选中效果
}

// 刷新Cell方法 （需要数据）
- (void)updateCellWithApplication:(NSArray *)useGist andAgainstGist:(NSArray *)againstGist andIndexPath:(NSIndexPath *)indexPath
{
    
}
// 根据文本内容重新计算cell高度
-(void)setGistArr:(NSArray *)gistArr
{
    // 将数组中元素拼接为一个字符串
    self.myLabel.text = [gistArr componentsJoinedByString:@"\n"];
    
    // 设置显示最大行数 和 字体
    self.myLabel.numberOfLines = 100;
    self.myLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置画布大小
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000);
    
    // 根据信息进行绘图
    CGRect cellNewSize = [self.myLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    
    // 重新设置label的高度 self.myLabel.frame.origin.x, self.myLabel.frame.origin.y,
    self.myLabel.frame = CGRectMake(10, 10, cellNewSize.size.width, cellNewSize.size.height);
    
    // 算出cell的新高度
     cellNewSize.size.height = cellNewSize.size.height + 30;
    
    // 设置cell的frame
    self.frame = cellNewSize;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
