//
//  ScrollTableViewCell.m
//  第一工程机械
//
//  Created by 李沛池 on 15-9-15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "ScrollTableViewCell.h"
#import "NewsAdvModel.h"
@interface ScrollTableViewCell ()

@property(nonatomic,strong) UIScrollView * scroll;
@property(nonatomic,strong) UIView * view;
@property(nonatomic,strong) UILabel * label;
@property(nonatomic,strong) UIPageControl * page;
@property(nonatomic,strong) NSMutableArray * titleArr;

@end

@implementation ScrollTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    static NSInteger imageNum = 4;
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone; // 消除选中效果
        
        // 父视图
        UIView * superView = self.contentView;
        
        // scroll 适配
        _scroll = [[UIScrollView alloc]init];
        [self.contentView addSubview:_scroll];
//        _scroll.backgroundColor = [UIColor blueColor];
        [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(0);
            make.top.equalTo(superView.mas_top).offset(0);
            make.width.equalTo(superView);
            make.height.equalTo(superView);
        }];
        
        _scroll.bounces = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.contentSize = CGSizeMake(superView.frame.size.width * imageNum, superView.frame.size.height);
        _scroll.contentOffset = CGPointMake(0, 0);
        _scroll.delegate = self;
        _scroll.pagingEnabled = YES;
        _scroll.tag = 100;
        [superView addSubview:_scroll];
        
        // 半透明条适配
        _view = [[UIView alloc] init];
        [superView addSubview:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(0);
            make.bottom.equalTo(_scroll.mas_bottom).offset(0);
            make.width.equalTo(superView);
            make.height.equalTo(@20);
        }];
        _view.backgroundColor = [UIColor whiteColor];
        _view.alpha = 0.5;
        
        // 小标题适配
        _label = [[UILabel alloc]init];
        _label.font = [UIFont systemFontOfSize:13];
        [_view addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_view.mas_left).offset(5);
            make.bottom.equalTo(_view.mas_bottom).offset(0);
            make.width.equalTo(superView).multipliedBy(1.0/2.0);
            make.height.equalTo(@20);
        }];
        
        _label.textColor = [UIColor blackColor];
        //        _label.backgroundColor = [UIColor orangeColor];
        _label.tag = 200;
        _label.text = @"内容介绍";
        _label.textAlignment = NSTextAlignmentLeft;
        
//        // 分页控件适配
//        _page = [[UIPageControl alloc]init];
//        [_view addSubview:_page];
//        [_page mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(_view.mas_right).offset(0);
//            make.top.equalTo(_view.mas_top).offset(0);
//            make.width.equalTo(superView).multipliedBy(1.0/2.0);
//            make.height.equalTo(@20);
//        }];
//        _page.pageIndicatorTintColor = [UIColor blackColor];
//        _page.currentPageIndicatorTintColor = [UIColor whiteColor];
//        _page.numberOfPages = imageNum;
//        _page.currentPage = 0;
//        [_page addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
//        _page.tag = 300;
        
    }
    return self;
}

// 刷新Cell方法 （需要数据）
- (void)updateCellWithApplication:(NSArray *)modelArr
{
    // 设置滚动视图大小 SCREEN_WIDTH SCREEN_HEIGHT
    self.scroll.contentSize = CGSizeMake(modelArr.count * SCREEN_WIDTH, self.contentView.frame.size.height);
    // 设置分页控件数量
    self.page.numberOfPages = modelArr.count;
    
    UIImageView * lastV;
    if(modelArr)
    {
        // 创建小标题数组
        _titleArr = [[NSMutableArray alloc] init];
        
        for(int i = 0;i < modelArr.count; i++)
        {
            // 取出模型
            NewsAdvModel * ad = modelArr[i];

            // 初始化小标题数组
            [_titleArr addObject:ad.name];
            
            // 设置滚动视图图片
            UIImageView * imageView = [[UIImageView alloc]init];
            [_scroll addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastV ? lastV.mas_right : @0);
                make.top.equalTo(self.scroll.mas_top);
                make.width.equalTo(self.scroll);
                make.height.equalTo(self.scroll);
            }];
            lastV = imageView;
            
            // 设置图片
            NSURL * url = [NSURL URLWithString: [ad.ban_img URLDecodedString]];
            [imageView setImageWithURL:url];
        }
        // 设置小标题
        self.label.text = self.titleArr[0];
    }
}

// page控件变化动作
//-(void)pageChanged:(id)sender
//{
//    UIPageControl * pageC = (UIPageControl *)sender;
//    // 更改小标题
//    self.label.text = self.titleArr[pageC.currentPage];
//}
// scrollView换页时动作
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / self.contentView.frame.size.width;
    self.label.text = self.titleArr[page];
    self.page.currentPage = page;
}



@end
