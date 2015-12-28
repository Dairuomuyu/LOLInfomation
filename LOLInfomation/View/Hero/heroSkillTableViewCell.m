//
//  heroSkillTableViewCell.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "heroSkillTableViewCell.h"

@implementation heroSkillTableViewCell
// xib初始化方法
- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone; // 消除cell选中效果
    
    // 初始化技能图片
    for(int i = 0; i < 5; i ++){
        // 为每个图片添加单击手势
        UITapGestureRecognizer * imagTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        UIImageView * imageBtn = [[UIImageView alloc] initWithFrame:CGRectMake(25*i + 30*i + 10, 5, 35, 35)];
        // 设置选中图片边框
        imageBtn.layer.masksToBounds = YES;
        imageBtn.layer.borderColor = [[UIColor colorWithRed:61/255.0 green:170/255.0 blue:250/255.0 alpha:1] CGColor];
        if(i == 0){
            imageBtn.layer.borderWidth = 3;
        }
        imageBtn.tag = i + 10;
        // 开启交互权限
        imageBtn.userInteractionEnabled = YES;
        // 图片添加手势
        [imageBtn addGestureRecognizer:imagTap];
        // 添加到父视图
        [self.contentView addSubview:imageBtn];
    }
    
    // 获取第一个技能图标
    UIImageView * firstImage = (UIImageView *)[self.contentView viewWithTag:10];
    CGPoint imageCenter= firstImage.center;
    
    // 初始化三角图片
    _pointImage = [[UIImageView alloc] initWithFrame:CGRectMake(imageCenter.x - 25/2,imageCenter.y + 20, 25, 10)];
    _pointImage.image = [UIImage imageNamed:@"skill_fold_icon@2x.png"];
    [self.contentView addSubview:_pointImage];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

# pragma mark --- 懒加载
-(void) skillArrWithArr:(NSArray *)arr
{
    _skillArr = [NSMutableArray array];
    _skillImageURLArr = [NSMutableArray array];
    
    for (NSDictionary * dic in arr)
    {
        NSString * skillStr = [NSString stringWithFormat:
                               @"%@ (%@)\n\n%@\n\n冷却时间:%@\n\n消耗:%@",dic[@"name"],dic[@"key"],dic[@"desc"],dic[@"cd"],dic[@"cost"]];
        [_skillArr addObject:skillStr]; // 将拼接好的字符串储存到数组中
    }
}
// 点击手势响应动作
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    // 获取第一个技能图标
    UIImageView * currentTapImage = (UIImageView *)tap.view;
    CGPoint imageCenter= currentTapImage.center;

    for(int i = 0; i < 5; i ++){
        UIImageView * image = (UIImageView *)[self.contentView viewWithTag:i+10];
        if([image isEqual:currentTapImage])
        {
            // 根据电机图片设置三角图片位置
            _pointImage.frame = CGRectMake(imageCenter.x - 25/2,imageCenter.y + 20, 25, 10);
            image.layer.masksToBounds = YES;
            image.layer.borderWidth = 3;
            image.layer.borderColor = [[UIColor colorWithRed:61/255.0 green:170/255.0 blue:250/255.0 alpha:1] CGColor];
            
            // 更换label里面的内容,重新计算高度
            self.myLabel.text = self.skillArr[image.tag - 10];
            
            // 获得绘制的画布大小
            CGRect cellNewSize = [self getStrCGSizeWithStr:self.myLabel.text];
            
            // 重新设置label的高度
            self.myLabel.frame = CGRectMake(0,self.pointImage.center.y + 5,SCREEN_WIDTH, cellNewSize.size.height);
        }else{
            image.layer.borderWidth = 0;
        }
    }
}
// 刷新cell内容
-(void)setMyLabelText:(NSArray *)skillModelArr andIndexPath:(NSIndexPath *)indexPath
{
    // 设置技能图片
    for(int i = 0; i < 5; i ++){
        UIImageView * imageBtn = (UIImageView *)[self.contentView viewWithTag:i + 10];
        NSURL * imagURL = [NSURL URLWithString:[skillModelArr[i] objectForKey:@"img"]];
        [imageBtn setImageWithURL:imagURL placeholderImage:[UIImage imageNamed:@"subscribe_match_team_select@2x.png"]];
    }
    // 创建Label
    _myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.pointImage.center.y + 5, SCREEN_WIDTH, 200)];
    _myLabel.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:0.5];
    [self.contentView addSubview:_myLabel];
    
    // 设置Label显示最大行数
    _myLabel.numberOfLines = 100;
    _myLabel.font = [UIFont systemFontOfSize:13];
    
    // 取出模型中每个技能的详细介绍，并拼接为一个字符串
    [self skillArrWithArr:skillModelArr];
    
    // 默认显示第一个技能的文字
    if(_skillArr.count > 1)
    {
        _myLabel.text = self.skillArr[0];
    }
    
    // 获得绘制的画布大小
    CGRect cellNewSize = [self getStrCGSizeWithStr:self.myLabel.text];
    
    // 重新设置label的高度
     self.myLabel.frame = CGRectMake(0,self.pointImage.center.y + 5,SCREEN_WIDTH, cellNewSize.size.height);
    
    // 算出cell的新高度
    cellNewSize.size.height = self.myLabel.center.y + self.myLabel.frame.size.height/2;
    
    self.frame = cellNewSize;
}
// 得到需要绘制文字的画布大小
- (CGRect )getStrCGSizeWithStr:(NSString *)str
{
    // 设置画布大小
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000);
    
    // 根据信息进行绘图
    CGRect cellNewSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil];
    return cellNewSize;
}



@end
