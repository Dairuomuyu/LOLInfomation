//
//  saveTrafficTableViewCell.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "saveTrafficTableViewCell.h"

@implementation saveTrafficTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _myImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 70,12, 44 - 12*2,  44 - 12*2)];
        [self.contentView addSubview:_myImage];
    }
    return self;
}
@end
