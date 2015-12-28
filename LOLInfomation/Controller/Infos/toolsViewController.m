//
//  toolsViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "toolsViewController.h"
#import "toolsCollectionViewCell.h"
#import "RDVTabBarController.h"
@interface toolsViewController ()
{
    UICollectionView * collectionView;
}
@end

@implementation toolsViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES]; // 界面显示时隐藏底部tabBAr
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData]; // 页面第一次显示出来时请求数据
}
// 请求数据
- (void)loadData
{
    [DownLoadData getToolsPageRequestType:Enum_ToolsPage withData:^(NSMutableArray * obj,NSError *err) {
        if(obj)
        {
            _toolDataArr = obj;
            [collectionView reloadData];
        }
        else
        {
            UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据下载失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //[a show];
            a = nil;
        }
    }];
}
// 重写初始化方法
- (instancetype)init
{
    if(self == [super init])
    {
        self.view.backgroundColor = [UIColor whiteColor]; // 在初始化方法中为背景添加颜色，否则跳转时卡顿
        // 计算cell尺寸
        CGFloat cellWidth = 59.0;//(self.view.frame.size.width - 20)/6.0;
        CGFloat cellHeight = 59.0 + 20.0;//cellWidth * 1.2;
        // 设置cell的布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake(cellWidth, cellHeight)]; // 设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; // 设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10); // 设置其边界
        
        collectionView = [[UICollectionView alloc]initWithFrame:
                          CGRectMake(0,
                                     STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height - 64)
                                           collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.autoresizesSubviews = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self.view addSubview:collectionView];
        [collectionView registerNib:[UINib nibWithNibName:@"toolsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    }
    return self;
}
#pragma mark --- <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _toolDataArr.count; // 数据中武器的个数
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// 设置cell内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    toolsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    [cell updateCellWithApplication:_toolDataArr[indexPath.row] andIndexPath:indexPath];
    return cell;
}
// 实现选中cell时的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s---点击的是第%ld个元素",__FUNCTION__,indexPath.row+1);
}



@end
