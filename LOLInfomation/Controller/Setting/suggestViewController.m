//
//  suggestViewController.m
//  LOLInfomation
//
//  Created by 李沛池 on 15/9/15.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "suggestViewController.h"
#import "RDVTabBarController.h"
@interface suggestViewController ()<UIAlertViewDelegate>
@property (strong,nonatomic) UITextField * textF;
@end

@implementation suggestViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES]; // 界面显示时隐藏底部tabBAr
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"意见反馈";
    _textF = [[UITextField alloc] initWithFrame:CGRectMake(5, 64 + 20, SCREEN_WIDTH - 5*2, SCREEN_HEIGHT/3)];
    _textF.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:0.5];
    [_textF becomeFirstResponder];
    [self.view addSubview:_textF];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barBtn;
    
}
- (void)pressBtn:(id)sender
{
    NSString * showMessage = nil;
    if(_textF.text.length == 0)
    {
        showMessage = @"您不能提交空意见";
    }
    else
    {
        showMessage = @"感谢您的宝贵意见";
    }
    UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"提示" message:showMessage delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    a.delegate = self;
    [a show];
    a = nil;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textF resignFirstResponder];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(_textF.text.length != 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
