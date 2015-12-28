//
//  combatSkillTableViewController.h
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface combatSkillTableViewController : UITableViewController

@property (nonatomic,assign) id <HeroRefreshDataProtocol> delegate;

/**
 *  使用技巧(里面包含三条内容)
 */
@property (nonatomic,strong) NSArray * use_gist;
/**
 *  对抗技巧(里面包含三条内容)
 */
@property (nonatomic,strong) NSArray * against_gist;

@end
