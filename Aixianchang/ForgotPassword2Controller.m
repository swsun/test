//
//  ForgotPasswordController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/2/3.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "ForgotPassword2Controller.h"
#import "ForgotPassword3Controller.h"

@interface ForgotPassword2Controller ()
{
    BOOL available;
    NSInteger num;
}
@property (strong, nonatomic) UITextField *verificationCode;
@property (strong, nonatomic) UIButton *resendBtn;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ForgotPassword2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置密码";
    self.view.backgroundColor = BackgroundColor;

    UIButton *done = [Common navButtonWithTitle:@"下一步"];
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:done];
    
#pragma TODO
    _phone = @"13052223002";
    
    UILabel *label = [UILabel new];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"验证码短信已发送到:%@",_phone]];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(att.length - _phone.length, _phone.length)];
    label.font = FONT11;
    label.attributedText = att;
    label.textColor = UIColorFromRGB(0xbebebe);
    [self.view addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(10);
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
        make.top.equalTo(label.mas_bottom).offset(10);
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPhone:(NSString *)phone
{
    _phone = phone;
    [self setButtonAvailable:YES];
    [self resendCode:nil];
}

- (void)done:(id)sender
{
    if (!_verificationCode.text.length) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"请输入短信验证码" continueTime:1.f];
        return;
    }
    ForgotPassword3Controller *vc = [[ForgotPassword3Controller alloc] init];
    vc.phone = self.phone;
    vc.verifierCode = self.verificationCode.text;
    [self.navigationController pushViewController:vc animated:YES];
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
                           @"type":@2};
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
