//
//  newsPageTableViewCell.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsDetailModel;
@interface newsPageTableViewCell : UITableViewCell

// 刷新Cell方法 （需要数据）
- (void)updateCellWithApplication:(NewsDetailModel *)model andIndexPath:(NSIndexPath *)indexPath;

@end
