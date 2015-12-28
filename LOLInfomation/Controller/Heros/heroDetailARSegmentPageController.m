//
//  heroDetailARSegmentPageController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "heroDetailARSegmentPageController.h"
#import "UIImage+ImageEffects.h"
#import "heroSkillTableViewController.h"
#import "heroStoryTableViewController.h"
#import "combatSkillTableViewController.h"
#import "HeroDetailModel.h"
#import "ARSegmentView.h"
#import "RDVTabBarController.h"
// 添加一个枚举，用来给不同界面其别传值
typedef enum : NSUInteger{
    Enum_HeroSkillPage = 1000,
    Enum_HeroStoryPage,
    Enum_CombatSkillPage,
}HeroPageType;

@interface heroDetailARSegmentPageController ()
{
    heroSkillTableViewController * heroSkillVC;
    heroStoryTableViewController * heroStoryVC;
    combatSkillTableViewController * combatSkillVC;
}
@property (nonatomic, strong) UIImage *defaultImage; // 顶部常态下图片
@property (nonatomic, strong) UIImage *blurImage; // 上推了模糊图片

@end

@implementation heroDetailARSegmentPageController
- (void)viewWillAppear:(BOOL)animated
{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES]; // 界面显示时显示底部tabBAr
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO; // 解决TableView错位的问题
    [self setNavigationController]; // 设置导航控制器为透明效果
    [self loadData]; // 页面第一次显示出来时请求数据
    
    // 下面方法可以拿到 分段控制器
//    NSArray * sub = [self.view subviews];
//    ARSegmentView * segmentV = [sub lastObject];
//    segmentV.segmentControl.selectedSegmentIndex = 2;
}
// 请求数据
- (void)loadData
{
    if(!_heroDetailModel)
    {
        // 设置默认头部图片
        self.headerView.imageView.image = [UIImage imageNamed:@"default_personal_bg@2x.png"];
        // 请求数据
        [DownLoadData getHeroDetailPageRequestType:Enum_HeroDetailPage withData:^(HeroDetailModel * model, NSError *err) {
            if(model)
            {
                // 接受请求返回数据
                _heroDetailModel = model;
                
                // 给顶部图片赋值
                [self.headerView.imageView setImageWithURL:[NSURL URLWithString:model.img_top]];
                // 给导航栏标题赋值
                self.navigationItem.title = model.title;
                
                // 给英雄技能界面赋值
                heroSkillVC.skillArr = model.skill;
                [heroSkillVC.tableView reloadData];
                
                // 给背景故事界面赋值
                heroStoryVC.heroBackground = model.background;
                [heroSkillVC.tableView reloadData];
                
                // 给对抗技巧界面赋值
                combatSkillVC.use_gist = model.use_gist;
                combatSkillVC.against_gist = model.against_gist;
                [combatSkillVC.tableView reloadData];
            }
            else
            {
                UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据下载失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //[a show];
                a = nil;
                NSLog(@"英雄详细页---数据下载失败");
                
            }
        } withHeroID:self.heroID];
    }
    else
    {
        NSLog(@"数据已经成功下载！");
    }
}

// 重写init方法
- (instancetype)init
{
    if(self = [super init])
    {
        heroSkillVC = [[heroSkillTableViewController alloc] init];
        heroStoryVC = [[heroStoryTableViewController alloc] init];
        combatSkillVC = [[combatSkillTableViewController alloc] init];
        
        // 设置代理用做总刷新
        heroSkillVC.delegate = self;
        heroStoryVC.delegate = self;
        combatSkillVC.delegate = self;
        
        // 消除cell间隔线
        heroSkillVC.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        heroStoryVC.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        combatSkillVC.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 解决两个TableView错位的问题
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        // 将三个子视图添加到ARSegement控件中
        [self setViewControllers:@[heroSkillVC,heroStoryVC,combatSkillVC]];
        
        self.freezenHeaderWhenReachMaxHeaderHeight = YES;
        self.segmentMiniTopInset = 64; // 设置顶部是图片视图最小高度
        // 创建观察者
        [self addObserver:self forKeyPath:@"segmentToInset" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}
// 设置导航控制器相关设置
- (void)setNavigationController
{
//    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                               [UIColor whiteColor],NSForegroundColorAttributeName,
//                                               [UIFont systemFontOfSize:28],
//                                               NSFontAttributeName, nil];
//    
//    [self.navigationController.navigationBar  setTitleTextAttributes:navbarTitleTextAttributes];
    [self.navigationController.navigationBar  setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar  setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    [self.navigationController.navigationBar  setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar  setTranslucent:YES];
}
-(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
// 注销观察者（不写会崩溃）
-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"segmentToInset"];
}
//
-(NSString *)segmentTitle
{
    return @"common";
}

@end
