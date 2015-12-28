//
//  toolsCollectionViewCell.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "toolsCollectionViewCell.h"
#import "toolsModel.h"
@interface toolsCollectionViewCell ()

@property (nonatomic,strong) UIImageView * defaultImage;

@end

@implementation toolsCollectionViewCell
// 刷新Cell方法 （需要数据）
- (void)updateCellWithApplication:(toolsModel *)model andIndexPath:(NSIndexPath *)indexPath
{
    self.toolName.numberOfLines = 0;
    [self.imageV setImageWithURL:[NSURL URLWithString:model.icon]];
    self.toolName.text = model.name;
}
-(void)awakeFromNib
{
    self.imageV.image = [UIImage imageNamed:@"default_hero_head@2x.png"];
}

//// 代码适配（有问题以后写）
//- (void)awakeFromNib
//{
//    _defaultImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_hero_head@2x.png"]];
//    
//    // 图片适配
//    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(0);
//        make.top.equalTo(self.contentView.mas_top).offset(0);
//        make.width.equalTo(_defaultImage.mas_width);
//        make.height.equalTo(_defaultImage.mas_height);
//    }];
//    // 标题适配
//    [_toolName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(0);
//        make.top.equalTo(self.contentView.mas_top).offset(0);
//        make.width.equalTo(_defaultImage.mas_width);
//        make.height.equalTo(_defaultImage.mas_height).multipliedBy(1.0/4.0);
//    }];
//}

@end
