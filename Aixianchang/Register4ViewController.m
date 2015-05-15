//
//  Register4ViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/29.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "Register4ViewController.h"
#import "NSString+MD5.h"
#import "ViewController.h"
#import "XJNavController.h"
#import "NSString+Encode.h"

@interface Register4ViewController ()
{
    BOOL available;
    NSInteger num;
}
@property (strong, nonatomic) UITextField *verificationCode;
@property (strong, nonatomic) UIButton *resendBtn;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation Register4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证手机(4/4)";
    self.view.backgroundColor = BackgroundColor;
    
//#warning TODO
//    _phone = @"13333333333";
    
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor clearColor];
    UILabel *rightLabel = [UILabel new];
    rightLabel.text = @"完成";
    
    UIButton *done = [Common navButtonWithTitle:@"完成"];
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:done];
    
    UILabel *label = [UILabel new];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"验证码短信已发送到:%@",_phone]];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(att.length - _phone.length, _phone.length)];
    label.font = FONT11;
    label.attributedText = att;
    [self.view addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(20);
    }];
    
    
    _verificationCode = [[UITextField alloc] init];
    _verificationCode.backgroundColor = [UIColor whiteColor];
    _verificationCode.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    _verificationCode.leftViewMode = UITextFieldViewModeAlways;
    _verificationCode.placeholder = @"请输入验证码";
    _verificationCode.font = FONT14;
    _verificationCode.textColor = TextColor;
    _verificationCode.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    _verificationCode.layer.borderWidth = 1.0f;
    [self.view addSubview:_verificationCode];
    [_verificationCode makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.height.equalTo(@40);
        make.top.equalTo(label.mas_bottom).offset(20);
    }];
    
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register4-1"]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:icon];
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_left).offset(25);
        make.centerY.equalTo(_verificationCode);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _resendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _resendBtn.titleLabel.font = FONT14;
    [_resendBtn setTitle:@"再次发送验证码" forState:UIControlStateNormal];
    [_resendBtn setBackgroundImage:[[Common imageWithColor:MainColor cornerRadius:4.0f] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [_resendBtn setBackgroundImage:[[Common imageWithColor:MainColor cornerRadius:4.0f] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [_resendBtn addTarget:self action:@selector(resendCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resendBtn];
    [_resendBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(_verificationCode.mas_bottom).offset(20);
        make.height.equalTo(@40);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setButtonAvailable:YES];
    [self resendCode:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPhone:(NSString *)phone
{
    _phone = phone;
}

- (void)done:(id)sender
{
    [_verificationCode resignFirstResponder];
//    [self uploadAvatar];
//    return;
    if (!self.verificationCode.text.length) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"请输入验证码" continueTime:1.0f];
        return;
    }
    [self uploadAvatar];
}

- (void)uploadAvatar
{
    [ApplicationDelegate.defaultEngine uploadImage:_avatar complete:^(NSDictionary *responseObject, NSError *error) {
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:error.description continueTime:1.5f];
            return ;
        }
        if ([[responseObject objectForKey:@"rspCode"] intValue] == 0) {
            [self doRegist];
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:[responseObject objectForKey:@"rspMsg"] continueTime:1.0f];
    }];
}

- (void)doRegist
{
    NSString *url = @"http://wx.qlogo.cn/mmopen/oYwP0cFmRU2TQvsJW5U0GJ0joABnzWVib1djiabC8rcvJufZGhicyN6nzibWYrXn2P2iaTXup1bue8mFd077wta5CnOyDic3L3ialpa/0";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *birthString = [formatter stringFromDate:self.birth];
    
    NSDictionary *dict = @{@"username":self.phone,
                           @"nickname":self.username,
                           @"password":self.password,
                           @"sex":@(self.sex),
                           @"birthday":birthString,
                           @"phone":self.phone,
                           @"email":@"",
                           @"picture":url,
                           @"signature":self.signature ,
                           @"varCode":_verificationCode.text};
//     NSDictionary*dict = @{@"username":@"哈哈",
//             @"password":[@"123456" DoubleMD5String],
//             @"sex":@"男",
//             @"birthday":@"20/01/2000",
//             @"phone":@"13333333333",
//             @"email":@"",
//             @"picture":@"http://img3.cache.netease.com/photo/0001/2015-01-10/AFJ9EOSL00AO0001.jpg",
//             @"signature":@"好不好"};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApplicationDelegate.defaultEngine postDataByURL:Register params:dict complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:error.description continueTime:1.0f];
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            NSString *token = [responseObject objectForKey:@"token"];
            ApplicationDelegate.token = token;
            ViewController *vc = [[ViewController alloc] init];
            XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }];
}

- (void)resendCode:(id)sender
{
    if (available) {
        num = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDown:) userInfo:nil repeats:YES];
        [self doRequestSendCode];
        [self setButtonAvailable:NO];
    }
}

- (void)setButtonAvailable:(BOOL)avai
{
    available = avai;
    if (available) {
        [_resendBtn setTitle:@"再次发送验证码" forState:UIControlStateNormal];
        [_resendBtn setBackgroundImage:[[Common imageWithColor:MainColor cornerRadius:4.0f] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        [_resendBtn setBackgroundImage:[[Common imageWithColor:MainColor cornerRadius:4.0f] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    }else {
        [_resendBtn setTitle:@"再次发送验证码(60)" forState:UIControlStateNormal];
        [_resendBtn setBackgroundImage:[[Common imageWithColor:UIColorFromRGB(0xb1b1b1) cornerRadius:4.0f] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        [_resendBtn setBackgroundImage:[[Common imageWithColor:UIColorFromRGB(0xb1b1b1) cornerRadius:4.0f] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    }
}

- (void)timerDown:(id)sender
{
    [_resendBtn setTitle:[NSString stringWithFormat:@"再次发送验证码(%ld)",(long)--num] forState:UIControlStateNormal];
    if (num == 0) {
        [self setButtonAvailable:YES];
        [_timer invalidate];
    }
}

- (void)doRequestSendCode
{
    NSDictionary *dict = @{@"username":_phone,
                           @"type":@1};
    [ApplicationDelegate.defaultEngine getDataByURL:SendVerifyCode params:dict complete:^(NSDictionary *responseObject, NSError *error) {
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:error.description continueTime:1.0f];
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
    }];
}

- (void)dealloc
{
    [_timer invalidate];
}

@end
