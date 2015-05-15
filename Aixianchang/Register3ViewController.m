//
//  Register3ViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/29.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "Register3ViewController.h"
#import "Register4ViewController.h"

@interface Register3ViewController () <UITextFieldDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) UITextField *phoneNumber;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *password2;
@end

@implementation Register3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录信息(3/4)";
    self.view.backgroundColor = BackgroundColor;
    
    UIButton *next = [Common navButtonWithTitle:@"下一步"];
    [next addTarget:self action:@selector(checkPassword) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:next];
    
    _phoneNumber = [[UITextField alloc] init];
    _phoneNumber.keyboardType = UIKeyboardTypePhonePad;
    _phoneNumber.placeholder = @"请输入手机号码";
    _phoneNumber.delegate = self;
    _phoneNumber.backgroundColor = [UIColor whiteColor];
    _phoneNumber.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 0)];
    _phoneNumber.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumber.textColor = TextColor;
    _phoneNumber.font = FONT14;
    _phoneNumber.layer.borderWidth = 1.0f;
    _phoneNumber.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    [self.view addSubview:_phoneNumber];
    [_phoneNumber makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(self.view).offset(20);
        make.height.equalTo(@40);
    }];
    
    _password = [[UITextField alloc] init];
    _password.secureTextEntry = YES;
    _password.placeholder = @"请输入密码";
    _password.delegate = self;
    _password.backgroundColor = [UIColor whiteColor];
    _password.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 0)];
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.textColor = TextColor;
    _password.font = FONT14;
    _password.clearsOnBeginEditing = YES;
    _password.clearButtonMode = UITextFieldViewModeWhileEditing;
    _password.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    _password.layer.borderWidth = 1.0f;
    [self.view addSubview:_password];
    [_password makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(_phoneNumber.mas_bottom).offset(5);
        make.height.equalTo(_phoneNumber);
    }];
    
    _password2 = [[UITextField alloc] init];
    _password2.secureTextEntry = YES;
    _password2.placeholder = @"请重复密码";
    _password2.delegate = self;
    _password2.backgroundColor = [UIColor whiteColor];
    _password2.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 0)];
    _password2.leftViewMode = UITextFieldViewModeAlways;
    _password2.textColor = TextColor;
    _password2.font = FONT14;
    _password2.clearsOnBeginEditing = YES;
    _password2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _password2.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    _password2.layer.borderWidth = 1.0f;
    [self.view addSubview:_password2];
    [_password2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(_password.mas_bottom).offset(5);
        make.height.equalTo(_phoneNumber);
    }];
    
    UIImageView *icon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon1"]];
    icon1.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:icon1];
    UIImageView *icon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon2"]];
    icon2.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:icon2];
    UIImageView *icon3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon2"]];
    icon3.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:icon3];
    [icon1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_phoneNumber);
        make.centerX.equalTo(self.view.mas_left).offset(25);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [icon2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_password);
        make.centerX.equalTo(self.view.mas_left).offset(25);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [icon3 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_password2);
        make.centerX.equalTo(self.view.mas_left).offset(25);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *tip = [UILabel new];
    tip.text = @"为保护你的帐号安全,请务设置过于简单的密码\n爱现场不会在任何地方泄露你的手机号码";
    tip.font = FONT11;
    tip.textColor = UIColorFromRGB(0x868686);
    tip.numberOfLines = 0;
    tip.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tip];
    [tip makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(_password2.mas_bottom).offset(10);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextStep
{
    
    Register4ViewController *ctrl = [[Register4ViewController alloc] init];
    ctrl.username = _username;
    ctrl.password = _password.text;
    ctrl.phone = _phoneNumber.text;
    ctrl.birth = _birth;
    ctrl.sex = _sex;
    ctrl.avatar = _avatar;
    ctrl.signature = _signature;
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)checkPassword
{
    if (_phoneNumber.text.length != 11) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"请输入正确的手机号码" continueTime:1.0f];
        return;
    }
    
    if (![Common checkPassword:_password.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码必须同时包含数字和字母,并且长度不少于8位" delegate:self cancelButtonTitle:@"修改" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (![_password.text isEqualToString:_password2.text]) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"两次输入的密码不一致" continueTime:1.0f];
        return;
    }
    [self confirmPassword];
}

- (void)confirmPassword
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认手机号码" message:_phoneNumber.text delegate:self cancelButtonTitle:@"修改" otherButtonTitles:@"确认", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [self nextStep];
    }
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
