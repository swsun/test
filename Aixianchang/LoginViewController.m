//
//  LoginViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/29.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "LoginViewController.h"
#import "Register1ViewController.h"
#import "ForgotPassword1Controller.h"
#import "WXUserRegisterViewController.h"
#import "ViewController.h"
#import "XJNavController.h"
#import "NSString+MD5.h"
#import "UserModel.h"

#import "WXApi.h"
#import "WXApiObject.h"

#import "UMSocialWechatHandler.h"
#import "UMSocial.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (strong, nonatomic) UITextField *phoneNumber;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *weixinLoginBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = BackgroundColor;
    
    UIButton *cancel = [Common navBackBtn];
    [cancel addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];
    
//    UIButton *next = [Common navButtonWithTitle:@"注册"];
//    [next addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:next];
    
    _phoneNumber = [[UITextField alloc] init];
    _phoneNumber.keyboardType = UIKeyboardTypePhonePad;
    _phoneNumber.placeholder = @"请输入手机号码";
    _phoneNumber.delegate = self;
    _phoneNumber.backgroundColor = [UIColor whiteColor];
    _phoneNumber.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    _phoneNumber.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumber.textColor = TextColor;
    _phoneNumber.font = FONT14;
    _phoneNumber.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    _phoneNumber.layer.borderWidth = 1.0f;
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
    _password.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.textColor = TextColor;
    _password.font = FONT14;
    _password.clearsOnBeginEditing = YES;
    _password.clearButtonMode = UITextFieldViewModeWhileEditing;
    _password.layer.borderWidth = 1.0f;
    _password.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    [self.view addSubview:_password];
    [_password makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(_phoneNumber.mas_bottom).offset(5);
        make.height.equalTo(_phoneNumber);
    }];
    
    UIView *forgotBack = [UIView new];
    forgotBack.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    forgotBack.layer.borderWidth = 1.0f;
    forgotBack.backgroundColor = [UIColor whiteColor];
    forgotBack.userInteractionEnabled = YES;
    [forgotBack addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPass:)]];
    [self.view addSubview:forgotBack];
    [forgotBack makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.height.equalTo(_phoneNumber);
        make.top.equalTo(_password.mas_bottom).offset(20);
    }];
    
    UIImageView *icon1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 60, 40)];
    icon1.image = [UIImage imageNamed:@"login_icon1"];
    icon1.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *icon2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 60, 40)];
    icon2.image = [UIImage imageNamed:@"login_icon2"];
    icon2.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *icon3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    icon3.image = [UIImage imageNamed:@"login_icon3"];
    icon3.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:icon1];
    [icon1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_left).offset(30);
        make.centerY.equalTo(_phoneNumber.mas_centerY);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [self.view addSubview:icon2];
    [icon2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(icon1);
        make.centerY.equalTo(_password.mas_centerY);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [self.view addSubview:icon3];
    [icon3 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(icon1);
        make.centerY.equalTo(forgotBack.mas_centerY);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *forgot = [UILabel new];
    forgot.text = @"忘记密码";
    forgot.textColor = TextColor;
    forgot.font = FONT14;
    [self.view addSubview:forgot];
    [forgot makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(60);
        make.centerY.equalTo(forgotBack);
    }];
    
    _loginBtn = [[UIButton alloc] init];
    _loginBtn.titleLabel.font = FONT14;
    [_loginBtn setBackgroundImage:[[Common imageWithColor:MainColor cornerRadius:4.0f] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _weixinLoginBtn = [[UIButton alloc] init];
    _weixinLoginBtn.titleLabel.font = FONT14;
    _weixinLoginBtn.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    _weixinLoginBtn.layer.borderWidth = 1.0f;
    _weixinLoginBtn.layer.cornerRadius = 4.0f;
    [_weixinLoginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [_weixinLoginBtn setBackgroundImage:[[Common imageWithColor:[UIColor whiteColor] cornerRadius:4.0f] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [_weixinLoginBtn setTitle:@"微信登录" forState:UIControlStateNormal];
    [_weixinLoginBtn setTitleColor:UIColorFromRGB(0x8bc41d) forState:UIControlStateNormal];
    [_weixinLoginBtn addTarget:self action:@selector(weixinLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weixinLoginBtn];
    
    UIImageView *icon4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon4"]];
    icon4.contentMode = UIViewContentModeScaleAspectFit;
    [_weixinLoginBtn addSubview:icon4];
    [icon4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weixinLoginBtn.mas_left).offset(15);
        make.centerY.equalTo(_weixinLoginBtn);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [_loginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(forgotBack.mas_bottom).offset(20);
        make.right.equalTo(_weixinLoginBtn.mas_left).offset(-30);
        make.width.equalTo(_weixinLoginBtn);
        make.height.equalTo(@40);
    }];
    
    [_weixinLoginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_loginBtn.mas_right).offset(30);
        make.top.equalTo(_loginBtn);
        make.width.equalTo(_loginBtn);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(_loginBtn);
    }];
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

- (void)login:(id)sender
{
    if (_phoneNumber.text.length !=11 ) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"手机号码格式不正确!" continueTime:1.0f];
        return;
    }
    
    [[UIApplication sharedApplication].keyWindow resignFirstResponder];
    
    NSDictionary *param = @{@"username":_phoneNumber.text,@"password":_password.text};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [ApplicationDelegate.defaultEngine postDataByURL:Login params:param complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:error.description continueTime:1.5f];
            return ;
            
        }
        if ([[responseObject objectForKey:@"rspCode"] integerValue] == 1) {
            ApplicationDelegate.token = [responseObject objectForKey:@"Token"];
            
            ViewController *vc = [[ViewController alloc] init];
            XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }else {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:[responseObject objectForKey:@"rspMsq"] continueTime:1.0f];
        }
    }];
}

- (void)weixinLogin:(id)sender
{
//    SendAuthReq *req = [[SendAuthReq alloc] init];
//    req.scope = @"snsapi_userinfo";
//    req.state = @"axc";
//    [WXApi sendReq:req];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(self, [UMSocialControllerService defaultControllerService], YES, ^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
            NSLog(@"%@\n%@\n%@\n%@",snsAccount.userName, snsAccount.usid, snsAccount.accessToken, snsAccount.iconURL);
            
//            WXUserRegisterViewController *vc = [[WXUserRegisterViewController alloc] init];
//            vc.UMSocialAccount = snsAccount;
//            [self.navigationController pushViewController:vc animated:YES];
            [self doRequestWXLogin:snsAccount];
        }
    });
}

- (void)doRequestWXLogin:(UMSocialAccountEntity*)account
{
    NSDictionary *dict = @{@"accesstoken":account.accessToken,@"openId":account.usid};
    [ApplicationDelegate.defaultEngine getDataByURL:WXLogin params:dict complete:^(NSDictionary *responseObject, NSError *error) {
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"" continueTime:1.0f];
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            if (![[responseObject objectForKey:@"registered"] boolValue]) {
                ApplicationDelegate.token = [responseObject objectForKey:@"token"];
                
                ViewController *vc = [[ViewController alloc] init];
                XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
                [self presentViewController:nav animated:YES completion:nil];
            } else {
                WXUserRegisterViewController *vc = [[WXUserRegisterViewController alloc] init];
                vc.UMSocialAccount = account;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
    }];
}

- (void)forgetPass:(id)sender
{
    [self.navigationController pushViewController:[[ForgotPassword1Controller alloc] init] animated:YES];
}
@end
