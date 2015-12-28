//
//  setCustomTableViewCell.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "setCustomTableViewCell.h"

@implementation setCustomTableViewCell

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 70,5, 0, 0)];
        [self.contentView addSubview:_mySwitch];
    }
    return self;
}

@end
