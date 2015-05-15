//
//  ChangePasswordController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/9.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "ChangePasswordController.h"
#import "MainViewController.h"

@interface ChangePasswordController () <UITextFieldDelegate>
@property (strong, nonatomic) UITextField *passwordOld;
@property (strong, nonatomic) UITextField *passwordNew1;
@property (strong, nonatomic) UITextField *passwordNew2;
@property (strong, nonatomic) UIButton *confirm;
@end

@implementation ChangePasswordController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackgroundColor;
    self.title = @"修改密码";
    
    _passwordOld = [[UITextField alloc] init];
    _passwordOld.secureTextEntry = YES;
    _passwordOld.placeholder = @"请输入当前密码";
    _passwordOld.delegate = self;
    _passwordOld.backgroundColor = [UIColor whiteColor];
    _passwordOld.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    _passwordOld.leftViewMode = UITextFieldViewModeAlways;
    _passwordOld.textColor = TextColor;
    _passwordOld.font = FONT14;
    _passwordOld.clearsOnBeginEditing = YES;
    _passwordOld.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordOld.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    _passwordOld.layer.borderWidth = 1.0f;
    [self.view addSubview:_passwordOld];
    [_passwordOld makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(self.view).offset(20);
        make.height.equalTo(@40);
    }];
    
    UIView *bbb = [UIView new];
    bbb.backgroundColor = [UIColor clearColor];
    bbb.layer.borderWidth = 1.0f;
    bbb.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    [self.view addSubview:bbb];
    [bbb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(_passwordOld.mas_bottom).offset(10);
        make.height.equalTo(@82);
    }];
    
    _passwordNew1 = [[UITextField alloc] init];
    _passwordNew1.secureTextEntry = YES;
    _passwordNew1.placeholder = @"输入新密码";
    _passwordNew1.delegate = self;
    _passwordNew1.backgroundColor = [UIColor whiteColor];
    _passwordNew1.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    _passwordNew1.leftViewMode = UITextFieldViewModeAlways;
    _passwordNew1.textColor = TextColor;
    _passwordNew1.font = FONT14;
    _passwordNew1.clearsOnBeginEditing = YES;
    _passwordNew1.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _passwordNew1.layer.borderWidth = 1.0f;
//    _passwordNew1.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    [self.view addSubview:_passwordNew1];
    [_passwordNew1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(bbb).offset(1);
        make.height.equalTo(@40);
    }];
    
    _passwordNew2 = [[UITextField alloc] init];
    _passwordNew2.secureTextEntry = YES;
    _passwordNew2.placeholder = @"确认新密码";
    _passwordNew2.delegate = self;
    _passwordNew2.backgroundColor = [UIColor whiteColor];
    _passwordNew2.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    _passwordNew2.leftViewMode = UITextFieldViewModeAlways;
    _passwordNew2.textColor = TextColor;
    _passwordNew2.font = FONT14;
    _passwordNew2.clearsOnBeginEditing = YES;
    _passwordNew2.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _passwordNew2.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
//    _passwordNew2.layer.borderWidth = 1.0f;
    [self.view addSubview:_passwordNew2];
    [_passwordNew2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_passwordNew1.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0xbebebe);
    [self.view addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.centerY.equalTo(bbb);
        make.height.equalTo(@1);
    }];
    
    _confirm = [[UIButton alloc] init];
    _confirm.titleLabel.font = FONT15;
    [_confirm setBackgroundImage:[[Common imageWithColor:MainColor cornerRadius:4.0f] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [_confirm setTitle:@"确认修改" forState:UIControlStateNormal];
    [_confirm addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirm];
    
    [_confirm makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(_passwordNew2.mas_bottom).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@40);
    }];
    
    UIImageView *icon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s-eye"]];
    icon1.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:icon1];
    UIImageView *icon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s-eye"]];
    icon2.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:icon2];
    UIImageView *icon3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s-eye"]];
    icon3.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:icon3];
    [icon1 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.centerY.equalTo(_passwordOld);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [icon2 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.centerY.equalTo(_passwordNew1);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [icon3 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.centerY.equalTo(_passwordNew2);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)change:(id)sender
{
    if (!_passwordOld.text.length || !_passwordNew1.text.length || !_passwordNew2.text.length) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"密码不能为空" continueTime:1.0];
        return;
    }
    if (![Common checkPassword:_passwordNew1.text] || ![Common checkPassword:_passwordNew2.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码必须同时包含数字和字母,并且长度不少于8位" delegate:self cancelButtonTitle:@"修改" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (![_passwordNew2.text isEqualToString:_passwordNew1.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次输入的新密码应该相同" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSDictionary *param = @{@"oldPassword":_passwordOld.text,
                            @"password":_passwordNew1.text,
                            @"token":ApplicationDelegate.token,
                            @"username":ApplicationDelegate.loginUser.phone};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApplicationDelegate.defaultEngine postDataByURL:ChangePass params:param complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:error.description continueTime:1.0f];
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"修改成功,现在转到登录页面" continueTime:1.0f];
            ApplicationDelegate.token = nil;
            ApplicationDelegate.loginUser = nil;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                MainViewController *vc = [[MainViewController alloc] init];
                ApplicationDelegate.window.rootViewController = vc;
            });
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0];
    }];
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
