//
//  heroSkillTableViewController.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "heroDetailARSegmentPageController.h"
@interface heroSkillTableViewController : UITableViewController

@property (nonatomic,assign) id <HeroRefreshDataProtocol> delegate;
/**
 *  英雄技能（里面包含五个字典，需要模型再次解析）
 */
@property (nonatomic,strong) NSArray * skillArr;

@end

