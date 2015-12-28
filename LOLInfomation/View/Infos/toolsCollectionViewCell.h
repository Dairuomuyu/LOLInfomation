//
//  toolsCollectionViewCell.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class toolsModel;
@interface toolsCollectionViewCell : UICollectionViewCell
/**
 *  道具图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
/**
 *  道具名字
 */
@property (strong, nonatomic) IBOutlet UILabel *toolName;

// 刷新cell数据
- (void)updateCellWithApplication:(toolsModel *)model andIndexPath:(NSIndexPath *)indexPath;
@end
