//
//  newsPageTableViewCell.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "newsPageTableViewCell.h"
@interface newsPageTableViewCell()
@property (strong, nonatomic)  UIImageView *imageV;
@property (strong, nonatomic)  UILabel *titleLable;
@property (strong, nonatomic)  UILabel *detailLable;
@end
@implementation newsPageTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone; // 消除选中效果
    
    // 为cell内容添加约束
    CGFloat cellHeight = 80; // 约定好的cell高度
    CGFloat cellWidth = SCREEN_WIDTH; // 和屏幕等宽
    // imageV
    _imageV = [[UIImageView alloc] init];
    _imageV.frame = CGRectMake(10, 5, (cellHeight - 5*2)*1.2, cellHeight - 5*2);
    [self.contentView addSubview:_imageV];
    
    // titleLable
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10 + _imageV.frame.size.width + 10, 6, cellWidth - (10 + _imageV.frame.size.width + 10) -5, 35)];
    _titleLable.numberOfLines = 0;
    _titleLable.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_titleLable];
    
    //detailLable
    _detailLable = [[UILabel alloc] initWithFrame:CGRectMake(10 + _imageV.frame.size.width + 10,5+_titleLable.frame.size.height + 5, cellWidth - (10 + _imageV.frame.size.width + 10) -5, 20)];
    _detailLable.font = [UIFont systemFontOfSize:11];
    _detailLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [self.contentView addSubview:_detailLable];
    
    
}

// 刷新Cell方法 （需要数据）
- (void)updateCellWithApplication:(NewsDetailModel *)model andIndexPath:(NSIndexPath *)indexPath
{
    [self.imageV setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"default_hero_head@2x.png"]];
    self.titleLable.text = model.title;
    self.detailLable.text = model.newsShortDetail;
}


@end
