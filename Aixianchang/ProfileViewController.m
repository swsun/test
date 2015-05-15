//
//  ProfileViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/4.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController () <UIScrollViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
{
    UIImage *cacheImage;
    NSString *cacheImageURL;
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) NSArray *titles;

@property (strong, nonatomic) UIView *backImageView;
@property (strong, nonatomic) UIImageView *avtar;
@property (strong, nonatomic) UILabel *username;


@property (strong, nonatomic) UIDatePicker *datePicker;

@property (strong, nonatomic) UITextField *nickName;
@property (strong, nonatomic) UITextField *age;
@property (strong, nonatomic) UITextField *signature;
//@property (strong, nonatomic) UITextField *nickName;
//@property (strong, nonatomic) UITextField *nickName;
//@property (strong, nonatomic) UITextField *nickName;
@end

static NSString *reuseIdentifier = @"reuse";

@implementation ProfileViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _titles = @[@"昵称",@"年龄",@"星座",@"情感状态",@"个性签名",@"个人说明"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = BackgroundColor;
    
    UIButton *done = [Common navButtonWithTitle:@"修改"];
    [done addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:done];

    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets (UIEdgeInsetsMake(-64, 0, 0, 0));
    }];
    
    _mainView = [[UIView alloc] initWithFrame:_scrollView.bounds];
    _mainView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_mainView];
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.greaterThanOrEqualTo(@(SCREEN_HEIGHT + 1));
    }];
    
    _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_back"]];
    [_mainView addSubview:_backImageView];
    [_backImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.top.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.height.equalTo(@175);
    }];
    
    _avtar = [[UIImageView alloc] init];
    _avtar.image = [UIImage imageNamed:@"16"];
    _avtar.layer.borderColor = [UIColor whiteColor].CGColor;
    _avtar.layer.borderWidth = 2.0f;
    _avtar.layer.cornerRadius = 4.0f;
    _avtar.layer.masksToBounds = YES;
    _avtar.userInteractionEnabled = YES;
    [_avtar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImagePicker:)]];
    [_mainView addSubview:_avtar];
    [_avtar makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backImageView);
        make.centerY.equalTo(_backImageView).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    _username = [[UILabel alloc] init];
    _username.font = FONT16;
//    _username.text = @"Sean.Deng";
    _username.textColor = [UIColor whiteColor];
    [_mainView addSubview:_username];
    [_username makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avtar.mas_bottom).offset(10);
        make.centerX.equalTo(_backImageView);
    }];
    
    UILabel *tip = [UILabel new];
    tip.font = FONT15;
    tip.text = @"基本资料";
    [_mainView addSubview:tip];
    [tip makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView).offset(15);
        make.centerY.equalTo(_mainView.mas_top).offset(20 + 175);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = UIColorFromRGB(0x868686);
    [_mainView addSubview:line1];
    [line1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(_mainView).offset(40 + 175);
        make.height.equalTo(@1);
    }];
    
    UIView *view1 = [UIView new];
    [_mainView addSubview:view1];
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(line1);
        make.height.equalTo(@50);
    }];
    
    UIView *view2 = [UIView new];
    view2.userInteractionEnabled = YES;
    [view2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker:)]];
    [_mainView addSubview:view2];
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(view1.mas_bottom);
        make.height.equalTo(@50);
    }];
    
    UIView *view3 = [UIView new];
    [_mainView addSubview:view3];
    [view3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(view2.mas_bottom);
        make.height.equalTo(@50);
    }];
    /*
    UIView *view4 = [UIView new];
    [_mainView addSubview:view4];
    [view4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(view3.mas_bottom);
        make.height.equalTo(@50);
    }];
    
    UIView *view5 = [UIView new];
    [_mainView addSubview:view5];
    [view5 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(view4.mas_bottom);
        make.height.equalTo(@50);
    }];
    
    UIView *view6 = [UIView new];
    [_mainView addSubview:view6];
    [view6 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(view5.mas_bottom);
        make.height.equalTo(@50);
    }];*/
    
    
    UIView *line3 = [UIView new];
    line3.backgroundColor = UIColorFromRGB(0xbebebe);
    [_mainView addSubview:line3];
    [line3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView).offset(15);
        make.right.equalTo(_mainView).offset(-15);
        make.bottom.equalTo(view1);
        make.height.equalTo(@1);
    }];
    
    UIView *line4 = [UIView new];
    line4.backgroundColor = UIColorFromRGB(0xbebebe);
    [_mainView addSubview:line4];
    [line4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView).offset(15);
        make.right.equalTo(_mainView).offset(-15);
        make.bottom.equalTo(view2);
        make.height.equalTo(@1);
    }];
   /*
    UIView *line5 = [UIView new];
    line5.backgroundColor = UIColorFromRGB(0xbebebe);
    [_mainView addSubview:line5];
    [line5 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView).offset(15);
        make.right.equalTo(_mainView).offset(-15);
        make.bottom.equalTo(view3);
        make.height.equalTo(@1);
    }];
    
    UIView *line6 = [UIView new];
    line6.backgroundColor = UIColorFromRGB(0xbebebe);
    [_mainView addSubview:line6];
    [line6 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView).offset(15);
        make.right.equalTo(_mainView).offset(-15);
        make.bottom.equalTo(view4);
        make.height.equalTo(@1);
    }];
    
    UIView *line7 = [UIView new];
    line7.backgroundColor = UIColorFromRGB(0xbebebe);
    [_mainView addSubview:line7];
    [line7 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView).offset(15);
        make.right.equalTo(_mainView).offset(-15);
        make.bottom.equalTo(view5);
        make.height.equalTo(@1);
    }];*/
    
    UILabel *label1 = [UILabel new];
    label1.font = FONT14;
    [view1 addSubview:label1];
    [label1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1).offset(15);
        make.centerY.equalTo(view1);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.font = FONT14;
    [view2 addSubview:label2];
    [label2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2).offset(15);
        make.centerY.equalTo(view2);
    }];
    
    UILabel *label3 = [UILabel new];
    label3.font = FONT14;
    [view3 addSubview:label3];
    [label3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3).offset(15);
        make.centerY.equalTo(view3);
    }];
    /*
    UILabel *label4 = [UILabel new];
    label4.font = FONT14;
    [view4 addSubview:label4];
    [label4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4).offset(15);
        make.centerY.equalTo(view4);
    }];
    
    UILabel *label5 = [UILabel new];
    label5.font = FONT14;
    [view5 addSubview:label5];
    [label5 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view5).offset(15);
        make.centerY.equalTo(view5);
    }];
    
    UILabel *label6 = [UILabel new];
    label6.font = FONT14;
    [view6 addSubview:label6];
    [label6 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view6).offset(15);
        make.centerY.equalTo(view6);
    }];*/
    
    _nickName = [[UITextField alloc] init];
    _nickName.textAlignment = NSTextAlignmentRight;
    _nickName.textColor = TextColor;
    _nickName.font = FONT14;
    _nickName.delegate = self;
    [_mainView addSubview:_nickName];
    [_nickName makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view1);
        make.right.equalTo(view1).offset(-10);
        make.height.equalTo(@50);
        make.left.equalTo(label1).offset(20);
    }];
    _age = [[UITextField alloc] init];
    _age.textAlignment = NSTextAlignmentRight;
    _age.textColor = TextColor;
    _age.font = FONT14;
    _age.delegate = self;
    _age.enabled = NO;
    [_mainView addSubview:_age];
    [_age makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view2);
        make.right.equalTo(view2).offset(-10);
        make.height.equalTo(@50);
        make.left.equalTo(label2).offset(20);
    }];
    _signature = [[UITextField alloc] init];
    _signature.textAlignment = NSTextAlignmentRight;
    _signature.textColor = TextColor;
    _signature.font = FONT14;
    _signature.delegate =self;
    [_mainView addSubview:_signature];
    [_signature makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view3);
        make.right.equalTo(view3).offset(-10);
        make.height.equalTo(@50);
        make.left.equalTo(label3).offset(20);
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = UIColorFromRGB(0x868686);
    [_mainView addSubview:line2];
    [line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(view3.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    
    label1.text = @"昵称";
    label2.text = @"生日";
    label3.text = @"个性签名";
//    label4.text = @"情感状态";
//    label5.text = @"个性签名";
//    label6.text = @"个人说明";
    
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(line2.mas_bottom).offset(10);
    }];
    
    if (!ApplicationDelegate.loginUser) {
        [self doRequestGetUserInfo];
    }else
        [self reloadTableHeaderData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDatePicker:(UITapGestureRecognizer*)tap
{
    [_nickName resignFirstResponder];
    [_signature resignFirstResponder];
    NSDate *date;
    if (ApplicationDelegate.loginUser.birthday) {
        date = ApplicationDelegate.loginUser.birthday;
//        _age.text = [Common dateToTimeString:ApplicationDelegate.loginUser.birthday formatt:@"yyyy-MM-dd"];
    }else
        date = [NSDate date];
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.backgroundColor = BackgroundColor;
    [_datePicker setDate:date];
    [_datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    CGRect frame = _datePicker.frame;
    frame.origin.y = self.view.bounds.size.height - frame.size.height;
    _datePicker.frame = frame;
    
    _age.text = [Common dateToTimeString:date formatt:@"yyyy-MM-dd"];
    
    [self.view addSubview:_datePicker];
}

- (void)showImagePicker:(UITapGestureRecognizer*)tap
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [actionSheet showInView:self.view];
}

- (void)datePickerChanged:(id)sender
{
    _age.text = [Common dateToTimeString:_datePicker.date formatt:@"yyyy-MM-dd"];
}

- (void)doRequestGetUserInfo
{
    NSDictionary *param = @{@"token":ApplicationDelegate.token};
    [ApplicationDelegate.defaultEngine getDataByURL:GetUserInfo params:param complete:^(NSDictionary *responseObject, NSError *error) {
        if (error) {
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            UserModel *user = [MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:responseObject[RESPONSE_RESULT] error:nil];
            ApplicationDelegate.loginUser = user;
            [self reloadTableHeaderData];
        }
    }];
}

- (void)reloadTableHeaderData
{
    UserModel *model = ApplicationDelegate.loginUser;
    [_avtar sd_setImageWithURL:model.picture];
    _username.text = model.nickname;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
//    return dateFormatter;
    
    _nickName.text = model.nickname;
    _age.text = [dateFormatter stringFromDate: model.birthday];
    _signature.text = model.signature;
}

- (void)editAvatar:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
    [sheet showInView:self.view];
}

- (void)edit:(id)sender
{
    if (cacheImage) {
        [self uploadAvatar];
    }else
        [self doRequestEdit];
}

- (void)doRequestEdit
{
    NSDictionary *dict = @{@"token":ApplicationDelegate.token,
                           @"nickname":_nickName.text,
                           @"birthday":_age.text,
                           @"signature":_signature.text,
                           @"sex":@(ApplicationDelegate.loginUser.sex),
                           @"phone":ApplicationDelegate.loginUser.phone?ApplicationDelegate.loginUser.phone:ApplicationDelegate.loginUser.username,
                           @"picture":cacheImageURL?cacheImageURL:(ApplicationDelegate.loginUser.picture?ApplicationDelegate.loginUser.picture:@"")};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApplicationDelegate.defaultEngine postDataByURL:ModifyUserInfo params:dict complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ( error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:error.description continueTime:1.0f];
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            ApplicationDelegate.loginUser.nickname = _nickName.text;
            ApplicationDelegate.loginUser.birthday = _datePicker.date;
            ApplicationDelegate.loginUser.signature = _signature.text;
            ApplicationDelegate.loginUser.phone = ApplicationDelegate.loginUser.phone?ApplicationDelegate.loginUser.phone:ApplicationDelegate.loginUser.username;
            ApplicationDelegate.loginUser.picture = cacheImageURL?[NSURL URLWithString:cacheImageURL]:(ApplicationDelegate.loginUser.picture?ApplicationDelegate.loginUser.picture:[NSURL URLWithString:@""]);
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
    }];
}

- (void)uploadAvatar
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApplicationDelegate.defaultEngine uploadImage:cacheImage complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:error.description continueTime:1.5f];
            return ;
        }
        if ([[responseObject objectForKey:@"rspCode"] intValue] == 0) {
            cacheImageURL = [NSString stringWithFormat:@"http://%@/%@",HOSTADDRESS,responseObject[@"url"]];
            [self doRequestEdit];
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:[responseObject objectForKey:@"rspMsg"] continueTime:1.0f];
    }];
}


#pragma mark UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [_scrollView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-220);
    }];
    [_datePicker removeFromSuperview];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [_scrollView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark UIActionSheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"拍照"]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"相册"]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark UIImagePicker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKeyedSubscript:UIImagePickerControllerEditedImage];
    _avtar.image = img;
    cacheImage = img;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        if (scrollView.contentOffset.y + 64 <= 0) {
//            _tableHeaderView.frame = CGRectMake(0, 0, 320, 175 - scrollView.contentOffset.y - 64);
            [_backImageView updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(175 - scrollView.contentOffset.y - 64));
                make.top.equalTo(_mainView).offset(scrollView.contentOffset.y + 64);
            }];
        }else {
//            [_backImageView updateConstraints:^(MASConstraintMaker *make) {
//                make.height.equalTo(@175);
//                make.top.equalTo(self.view).offset(-scrollView.contentOffset.y);
//            }];
        }
    }
}
@end
