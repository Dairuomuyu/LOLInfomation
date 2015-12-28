//
//  heroBackgroundTableViewCell.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface heroBackgroundTableViewCell : UITableViewCell
/**
 *  显示英雄背景故事
 */
@property (strong, nonatomic) IBOutlet UILabel *myLabel;

//刷新cell内容
- (void)updateCellWithApplication:(NSString *)heroBackgroung andIndexPath:(NSIndexPath *)indexPath;

// 根据文本内容重新计算cell高度
-(void)setMyLabelText:(NSString *)text;

@end
