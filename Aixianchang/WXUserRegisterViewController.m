//
//  WXUserRegisterViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/31.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "WXUserRegisterViewController.h"
#import "UMSocial.h"
#import "ViewController.h"
#import "XJNavController.h"

@interface WXUserRegisterViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, UITextFieldDelegate>
{
    UIImage *img;
    NSDate *date;
    NSString *sx;
}

@property (strong, nonatomic) UITextField *nickName;
@property (strong, nonatomic) UIImageView *avtar;
@property (strong, nonatomic) UILabel *birth;
@property (strong, nonatomic) UILabel *sex;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIImageView *sexIcon;

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIPickerView *sexPicker;
@end

@implementation WXUserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写资料";
    self.view.backgroundColor = BackgroundColor;
    
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UIButton *next = [Common navButtonWithTitle:@"完成"];
    [next addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:next];
    
    _avtar = [[UIImageView alloc] init];
    _avtar.contentMode = UIViewContentModeScaleAspectFit;
    _avtar.image = [UIImage imageNamed:@"register2-1"];
    _avtar.userInteractionEnabled = YES;
    _avtar.layer.masksToBounds = YES;
    
    [_avtar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)]];
    [self.view addSubview:_avtar];
    [_avtar makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(35);
        make.width.equalTo(@90);
        make.height.equalTo(@90);
    }];
    
    UIView *b0 = [UIView new];
    b0.backgroundColor = [UIColor whiteColor];
    b0.userInteractionEnabled = YES;
    b0.layer.borderWidth = 1.0f;
    b0.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    [self.view addSubview:b0];
    [b0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(_avtar.mas_bottom).offset(35);
        make.height.equalTo(@40);
    }];
    
    _nickName = [[UITextField alloc] init];
    _nickName.font = FONT14;
    _nickName.textColor = TextColor;
    _nickName.placeholder = @"请输入昵称";
    _nickName.returnKeyType = UIReturnKeyDone;
    _nickName.delegate = self;
    [self.view addSubview:_nickName];
    [_nickName makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.centerY.equalTo(b0);
        make.right.equalTo(self.view);
    }];
    
    UIImageView *icon0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register1-1"]];
    [self.view addSubview:icon0];
    [icon0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_left).offset(25);
        make.centerY.equalTo(b0);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UIView *b1 = [UIView new];
    b1.backgroundColor = [UIColor whiteColor];
    b1.userInteractionEnabled = YES;
    b1.layer.borderWidth = 1.0f;
    b1.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    [b1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBirth:)]];
    [self.view addSubview:b1];
    [b1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(b0.mas_bottom).offset(5);
        make.height.equalTo(@40);
    }];
    
    UIView *b2 = [UIView new];
    b2.backgroundColor = [UIColor whiteColor];
    b2.userInteractionEnabled = YES;
    b2.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    b2.layer.borderWidth = 1.0f;
    [b2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectSex:)]];
    [self.view addSubview:b2];
    [b2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(b1.mas_bottom).offset(5);
        make.height.equalTo(@40);
    }];
    
    UIImageView *icon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register2-2"]];
    icon2.contentMode = UIViewContentModeScaleAspectFit;
    _sexIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register2-4"]];
    _sexIcon.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *icon4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register2-3"]];
    icon4.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *arrow1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow_lightGray"]];
    arrow1.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *arrow2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow_lightGray"]];
    arrow2.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:icon2];
    [icon2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_left).offset(25);
        make.centerY.equalTo(b1);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [self.view addSubview:_sexIcon];
    [_sexIcon makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_left).offset(25);
        make.centerY.equalTo(b2);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [self.view addSubview:arrow1];
    [arrow1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(b1);
        make.right.equalTo(self.view).offset(-10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [self.view addSubview:arrow2];
    [arrow2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(b2);
        make.right.equalTo(self.view).offset(-10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _birth = [[UILabel alloc] init];
    _birth.text = @"请选择生日";
    _birth.backgroundColor = [UIColor whiteColor];
    _birth.font = FONT14;
    _birth.textColor = TextColor;
    [self.view addSubview:_birth];
    [_birth makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.centerY.equalTo(b1);
    }];
    
    _sex = [[UILabel alloc] init];
    _sex.text = @"请选择性别";
    _sex.backgroundColor = [UIColor whiteColor];
    _sex.font = FONT14;
    _sex.textColor = TextColor;
    [self.view addSubview:_sex];
    [_sex makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.centerY.equalTo(b2);
    }];
    
    UILabel *tip = [UILabel new];
    tip.text = @"性别选择后不允许更改,请谨慎操作";
    tip.font = FONT11;
    tip.textColor = UIColorFromRGB(0x868686);
    [self.view addSubview:tip];
    [tip makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(b2.mas_bottom).offset(10);
    }];
    
    UIView *inputView = [UIView new];
    inputView.backgroundColor = [UIColor whiteColor];
    inputView.layer.borderWidth = 1.0f;
    inputView.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    [self.view addSubview:inputView];
    [inputView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(tip.mas_bottom).offset(10);
        make.height.equalTo(@120);
    }];
    
    [inputView addSubview:icon4];
    [icon4 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_left).offset(25);
        make.top.equalTo(inputView).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *tip2 = [UILabel new];
    tip2.text = @"请输入简介(50字以内)";
    tip2.textColor = UIColorFromRGB(0x868686);
    tip2.font = FONT14;
    [inputView addSubview:tip2];
    [tip2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sex);
        make.centerY.equalTo(icon4);
    }];
    
    
    _textView = [[UITextView alloc] init];
    _textView.delegate = self;
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.textColor = TextColor;
    _textView.font = FONT14;
    [self.view addSubview:_textView];
    [_textView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(icon4.mas_bottom).offset(5);
        make.bottom.equalTo(inputView).offset(-1);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated

//- (void)setUMSocialAccount:(UMSocialAccountEntity *)UMSocialAccount
{
    [super viewDidAppear:animated];
//    _UMSocialAccount = UMSocialAccount;
    [_avtar sd_setImageWithURL:[NSURL URLWithString:_UMSocialAccount.iconURL]];
    _nickName.text = _UMSocialAccount.userName;
}

- (void)nextStep:(id)sender
{
    if (!date) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"请选择生日" continueTime:1.0f];
        return;
    }
    if (!sx) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"请选择性别" continueTime:1.0f];
        return;
    }
    if (_textView.text.length > 50) {
        [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"个人简介最多输入50个字符" continueTime:1.0f];
        return;
    }
    [self modifyWxUser];
}

- (void)modifyWxUser
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *birthString = [formatter stringFromDate:date];
    
    NSString *url = @"http://wx.qlogo.cn/mmopen/oYwP0cFmRU2TQvsJW5U0GJ0joABnzWVib1djiabC8rcvJufZGhicyN6nzibWYrXn2P2iaTXup1bue8mFd077wta5CnOyDic3L3ialpa/0";
    
    NSDictionary *dict = @{@"openId":_UMSocialAccount.openId,
                           @"nickname":_nickName.text,
//                           @"password":self.password,
                           @"sex":sx,
                           @"birthday":birthString,
//                           @"phone":self.phone,
                           @"email":@"",
                           @"picture":url,
                           @"signature":self.textView.text,
                           };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApplicationDelegate.defaultEngine getDataByURL:Register params:dict complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            NSString *token = [responseObject objectForKey:@"token"];
            ApplicationDelegate.token = token;
            ViewController *vc = [[ViewController alloc] init];
            XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }];
}

- (void)viewTapped:(id)sender
{
    if (_datePicker.superview)
        [_datePicker removeFromSuperview];
    if (_sexPicker.superview)
        [_sexPicker removeFromSuperview];
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    }
}

- (void)selectImage:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [actionSheet showInView:self.view];
}

- (void)selectBirth:(UITapGestureRecognizer*)sender
{
    [_sexPicker removeFromSuperview];
    [_textView resignFirstResponder];
    
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.backgroundColor = BackgroundColor;
    [_datePicker setDate:[NSDate date]];
    [_datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    CGRect frame = _datePicker.frame;
    frame.origin.y = self.view.bounds.size.height - frame.size.height;
    _datePicker.frame = frame;
    //    [self.view addSubview:_datePicker];
    if ([_birth.text isEqualToString:@"请选择生日"]) {
        date = [NSDate date];
        _birth.text = [Common dateToTimeString:[NSDate date] formatt:@"yyyy-MM-dd"];
    }
    [self.view addSubview:_datePicker];
}

- (void)selectSex:(UITapGestureRecognizer*)sender
{
    [_datePicker removeFromSuperview];
    [_textView resignFirstResponder];
    
    _sexPicker = [[UIPickerView alloc] init];
    _sexPicker.backgroundColor = BackgroundColor;
    _sexPicker.delegate = self;
    _sexPicker.dataSource = self;
    
    CGRect frame = _sexPicker.frame;
    frame.origin.y = self.view.bounds.size.height - frame.size.height;
    _sexPicker.frame = frame;
    
    if ([_sex.text isEqualToString:@"请选择性别"]) {
        sx = @"男";
        _sex.text =  @"男";
        _sexIcon.image = [UIImage imageNamed:@"register2-male"];
    }
    [self.view addSubview:_sexPicker];
}

- (void)datePickerChanged:(id)sender
{
    date = _datePicker.date;
    _birth.text = [Common dateToTimeString:_datePicker.date formatt:@"yyyy-MM-dd"];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (textView.text.length >= 50) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"拍照"]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"相册"]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
}

#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    img = image;
    _avtar.image = image;
    _avtar.layer.cornerRadius = 3.0f;
    _avtar.layer.borderColor = [UIColor whiteColor].CGColor;
    _avtar.layer.borderWidth = 2.0f;
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row) {
        return @"女";
    }else
        return @"男";
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row) {
        sx = @"女";
        _sex.text = @"女";
        _sexIcon.image = [UIImage imageNamed:@"register2-female"];
    }else {
        sx = @"男";
        _sex.text = @"男";
        _sexIcon.image = [UIImage imageNamed:@"register2-male"];
    }
}

- (void)keyboardWillChangeFrameNotification:(NSNotification*)notification
{
    if (![_textView isFirstResponder]) {
        return;
    }
    NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *keyboardDuration = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGRect keyboardBounds;
    CGFloat duration;
    [keyboardBoundsValue getValue:&keyboardBounds];
    [keyboardDuration getValue:&duration];
    if (keyboardBounds.origin.y >= self.view.bounds.size.height) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
    }else {
        CGRect rect = self.view.frame;
        rect.origin.y = 64 - (260 - (rect.size.height - _textView.frame.size.height - _textView.frame.origin.y));
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = rect;
        }];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

@end
