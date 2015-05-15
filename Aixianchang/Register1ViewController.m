//
//  Register1ViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/29.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "Register1ViewController.h"
#import "Register2ViewController.h"

@interface Register1ViewController ()
@property (strong, nonatomic) UITextField *username;
@end

@implementation Register1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"输入名称(1/4)";
    self.view.backgroundColor = BackgroundColor;
    
    
    UIButton *cancel = [Common navBackBtn];
    [cancel addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];
    
    UIButton *next = [Common navButtonWithTitle:@"下一步"];
    [next addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:next];
    
    _username = [[UITextField alloc] init];
    _username.placeholder = @"请输入名称";
    _username.backgroundColor = [UIColor whiteColor];
    _username.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 0)];
    _username.leftViewMode = UITextFieldViewModeAlways;
    _username.font = FONT14;
    _username.textColor = TextColor;
    _username.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    _username.layer.borderWidth = 1.0f;
    [self.view addSubview:_username];
    [_username makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(self.view).offset(30);
        make.height.equalTo(@40);
    }];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register1-1"]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:icon];
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.centerY.equalTo(_username);
        make.centerX.equalTo(_username.mas_left).offset(25);
    }];
    
    /**
    NSString *xieyi = @"注册即表示同意<爱现场用户协议>";
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:xieyi];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(7, xieyi.length - 7)];
    UILabel *xx = [[UILabel alloc] init];
    xx.font = FONT11;
    xx.attributedText = att;
    xx.textColor = UIColorFromRGB(0xbebebe);
    [self.view addSubview:xx];
    [xx makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(_username.mas_bottom).offset(10);
    }];
     **/
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)nextStep:(id)sender
{
    if (_username.text.length == 0) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"昵称不能为空" continueTime:1.0f];
        return;
    }
    if (_username.text.length > 15) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"昵称不能超过15个字符" continueTime:1.0f];
        return;
    }
    
    Register2ViewController *step2 = [[Register2ViewController alloc] init];
    step2.username = _username.text;
    [self.navigationController pushViewController:step2 animated:YES];
}


@end
