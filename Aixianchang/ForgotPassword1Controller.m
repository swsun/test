//
//  ForgotPassword1Controller.m
//  Aixianchang
//
//  Created by zhangliugang on 15/2/3.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "ForgotPassword1Controller.h"
#import "ForgotPassword2Controller.h"

@interface ForgotPassword1Controller ()
@property (strong, nonatomic) UITextField *textField;
@end

@implementation ForgotPassword1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置密码";
    self.view.backgroundColor = BackgroundColor;
    
    UIButton *done = [Common navButtonWithTitle:@"下一步"];
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:done];
    
    UILabel *label = [UILabel new];
    label.font = FONT11;
    label.text = @"重置密码需要验证手机";
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
    _textField.placeholder = @"请输入手机号码";
    _textField.font = FONT14;
    _textField.textColor = TextColor;
    _textField.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    _textField.layer.borderWidth = 1.0f;
    [self.view addSubview:_textField];
    [_textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.height.equalTo(@40);
        make.top.equalTo(label.mas_bottom).offset(10);
    }];

    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon1"]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:icon];
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_left).offset(25);
        make.centerY.equalTo(_textField);
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
    if (self.textField.text.length != 11) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"请输入正确的手机号码" continueTime:1.0f];
        return;
    }
    ForgotPassword2Controller *vc = [[ForgotPassword2Controller alloc] init];
    vc.phone = self.textField.text;
    [self.navigationController pushViewController:vc animated:YES];
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
