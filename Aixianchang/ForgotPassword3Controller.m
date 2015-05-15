//
//  ForgotPasswordController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/2/3.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "ForgotPassword3Controller.h"

@interface ForgotPassword3Controller () <UITextFieldDelegate>
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UITextField *password2;
@end

@implementation ForgotPassword3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置密码";
    self.view.backgroundColor = BackgroundColor;
    
    UIButton *done = [Common navButtonWithTitle:@"完成"];
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:done];
    
    UILabel *label = [UILabel new];
    label.font = FONT11;
    label.text = @"请不要随意将密码告诉他人,以免造成不必要的麻烦";
    label.textColor = UIColorFromRGB(0xbebebe);
    [self.view addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(10);
    }];
    
    
    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.placeholder = @"请输入新密码";
    _textField.font = FONT14;
    _textField.textColor = TextColor;
    _textField.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    _textField.layer.borderWidth = 1.0f;
    _textField.secureTextEntry = YES;
    [self.view addSubview:_textField];
    [_textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.height.equalTo(@40);
        make.top.equalTo(label.mas_bottom).offset(10);
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
        make.top.equalTo(_textField.mas_bottom).offset(5);
        make.height.equalTo(_textField);
    }];
    
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon2"]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:icon];
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_left).offset(25);
        make.centerY.equalTo(_textField);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UIImageView *icon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon2"]];
    icon2.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:icon2];
    [icon2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_left).offset(25);
        make.centerY.equalTo(_password2);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done:(id)sender
{
    if (!_textField.text.length) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"请输入新密码" continueTime:1.0f];
        return;
    }
    if (![Common checkPassword:_textField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码必须同时包含数字和字母,并且长度不少于8位" delegate:self cancelButtonTitle:@"修改" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (![_textField.text isEqualToString:_password2.text]) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"两次输入的密码不一致" continueTime:1.0f];
        return;
    }
    
    NSDictionary *param = @{@"username":_phone,
                            @"varCode":_verifierCode,
                            @"password":_textField.text};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApplicationDelegate.defaultEngine getDataByURL:ChangePass params:param complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:error.description continueTime:1.0f];
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"修改成功!" continueTime:1.0f];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
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
