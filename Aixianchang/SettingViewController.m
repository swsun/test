//
//  SettingViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/30.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "SettingViewController.h"
#import "SingleCell.h"
#import "ChangePasswordController.h"
#import "BindPhone1Controller.h"
#import "MainViewController.h"
#import <SDWebImageManager.h>
#import <SDWebImage/SDImageCache.h>

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    NSArray *titles;
}
@property (strong, nonatomic) UITableView *tableView;
@end

static NSString *reuseIdentifier = @"identifier";
static NSInteger alertClearCacheTag = 11111;
static NSInteger alertLogoutTag = 22222;

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = BackgroundColor;
    
    if (ApplicationDelegate.loginUser.phone)
        titles = @[@"修改密码",@"清除缓存",@"退出当前帐号"];
    else
        titles = @[@"绑定手机",@"清除缓存",@"退出当前帐号"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = BackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_tableView registerClass:[SingleCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logout
{
    
}

#pragma mark - UIAlertVeiw
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        if (alertView.tag == alertClearCacheTag) {
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                
            }];
        }else if (alertView.tag == alertLogoutTag) {
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            [self dismissViewControllerAnimated:YES completion:nil];
            ApplicationDelegate.loginUser = nil;
            ApplicationDelegate.token = nil;
            
            MainViewController *vc = [[MainViewController alloc] init];
            ApplicationDelegate.window.rootViewController = vc;
        }
    }
}

#pragma mark - UITableView Delagate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0://change password
        {
            if (ApplicationDelegate.loginUser.phone) {
                ChangePasswordController *vc = [[ChangePasswordController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                BindPhone1Controller *vc = [[BindPhone1Controller alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 1://clear cache
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否清除程序缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = alertClearCacheTag;
            [alert show];
        }
            break;
        case 2://log out
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"退出当前帐号" message:@"退出爱现场帐号可能会使你错失最新的舞台剧咨询,确认退出?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认退出?", nil];
            alert.tag = alertLogoutTag;
            [alert show];
        }
            break;
        default:
            break;
    }
}
@end
