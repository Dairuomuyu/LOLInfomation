//
//  newDetailPageViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "newDetailPageViewController.h"
#import "RDVTabBarController.h"
@interface newDetailPageViewController ()
/**
 *  存放下载操作的队列
 */
@property (nonatomic, strong) NSOperationQueue *queue;
/**
 *  显示网页信息
 */
@property (nonatomic, strong) UIWebView * webView;

@end

@implementation newDetailPageViewController
#pragma mark --- 懒加载
- (NSOperationQueue *)queue
{
    if (!_queue) {
        self.queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}
- (UIWebView *)webView
{
    if(!_webView)
    {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_HEIGHT - 64 )];
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 添加背景图
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44)];
    backgroundImageView.image = [UIImage imageNamed:@"login_bkg@2x.png"];
    [self.view addSubview:backgroundImageView];
    
    // 异步下载网页信息
    __weak typeof(self) weakSelf = self;
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        NSString *urlString=[NSString stringWithFormat:kNewsDetailUrlString,self.newsID];
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        // 回到主线程刷新webView
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf.webView loadRequest:request];
            _webView.hidden = NO; // 刷新数据，显示webView
        }];
    }];
    // 添加操作到队列中
    [self.queue addOperation:operation];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO; // 显示导航栏
    _webView.hidden = YES; // 隐藏webView
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES]; // 界面显示时隐藏底部tabBAr
}
// 当页面消失时跳转回新闻首页
-(void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
