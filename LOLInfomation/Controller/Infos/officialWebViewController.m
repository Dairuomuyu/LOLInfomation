//
//  officialWebViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "officialWebViewController.h"
#import "RDVTabBarController.h"
@interface officialWebViewController ()
/**
 *  存放下载操作的队列
 */
@property (nonatomic, strong) NSOperationQueue *queue;
/**
 *  显示网页信息
 */
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end
@interface officialWebViewController ()

@end

@implementation officialWebViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES]; // 界面显示时隐藏底部tabBAr
}
#pragma mark --- 懒加载
- (NSOperationQueue *)queue
{
    if (!_queue) {
        self.queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"官方战网";
    // 异步下载网页信息
    __weak typeof(self) weakSelf = self;
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        NSString *urlString=[NSString stringWithFormat:@"http://lol.qq.com"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
