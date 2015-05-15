//
//  PersonalViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/27.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "PersonalViewController.h"
#import "SettingViewController.h"
#import "ProfileViewController.h"
#import "PersonalLevelController.h"
#import "AddressBookController.h"
#import "OrderViewController.h"
#import "AssistViewController.h"
#import "LoginViewController.h"
#import "XJNavController.h"
#import "PersonalCell.h"
#import "UserModel.h"

@interface PersonalViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UIView *tableHeaderView;
@property (strong, nonatomic) UIImageView *avtar;
@property (strong, nonatomic) UIImageView *avtarBack;
@property (strong, nonatomic) UILabel *username;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *tableTitles;
@end

static NSString *reuseIdentifier = @"Identifier";

@implementation PersonalViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        _tableTitles = @[@"个人等级",@"配送地址",@"我的订单",@"设置",@"帮助"];
//        _tableTitles = @[@"配送地址",@"我的订单",@"设置",@"帮助"];
        _tableTitles = @[@"设置",@"帮助"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.view.backgroundColor = BackgroundColor;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = BackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(-64, 0, 0, 0));
    }];
    
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = self.tableHeaderView;
    [_tableView registerClass:[PersonalCell class] forCellReuseIdentifier:reuseIdentifier];
    
    [self reloadTableHeaderData];
    
    if (!ApplicationDelegate.loginUser) {
        [self doRequestGetUserInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)profile:(id)sender
{
//    if (ApplicationDelegate.loginUser) {
        ProfileViewController *pro = [[ProfileViewController alloc] init];
        [self.navigationController pushViewController:pro animated:YES];
//    }else {
//        LoginViewController *vc = [[LoginViewController alloc] init];
//        XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
//        [self presentViewController:nav animated:YES completion:nil];
//    }
}

#pragma mark TableHeaderView
- (UIView *)tableHeaderView
{
    if (_tableHeaderView) return _tableHeaderView;
    
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
        [_tableHeaderView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profile:)]];
        
        _avtarBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_back"]];
        [_tableHeaderView addSubview:_avtarBack];
        [_avtarBack makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tableHeaderView);
            make.left.equalTo(_tableHeaderView);
            make.right.equalTo(_tableHeaderView);
            make.bottom.equalTo(_tableHeaderView);
        }];

        _avtar = [[UIImageView alloc] init];
        _avtar.image = [UIImage imageNamed:@"16"];
        _avtar.layer.borderColor = [UIColor whiteColor].CGColor;
        _avtar.layer.borderWidth = 2.0f;
        _avtar.layer.cornerRadius = 4.0f;
        _avtar.layer.masksToBounds = YES;
        [_tableHeaderView addSubview:_avtar];
        [_avtar makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_avtarBack);
            make.centerY.equalTo(_avtarBack).offset(10);
            make.width.equalTo(@60);
            make.height.equalTo(@60);
        }];
        
        _username = [[UILabel alloc] init];
        _username.font = FONT16;
//        _username.text = @"Sean.Deng";
        _username.textColor = [UIColor whiteColor];
        [_tableHeaderView addSubview:_username];
        [_username makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_avtar.mas_bottom).offset(10);
            make.centerX.equalTo(_avtarBack);
        }];

    return _tableHeaderView;
}

- (void)reloadTableHeaderData
{
    UserModel *model = ApplicationDelegate.loginUser;
    if (model) {
        [_avtar sd_setImageWithURL:model.picture placeholderImage:[UIImage imageNamed:@"头像2"]];
        _username.text = model.nickname;
    }else {

    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self reloadTableHeaderData];
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

#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView) {
        if (scrollView.contentOffset.y + 64 <= 0) {
            [_avtarBack updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_tableHeaderView).offset(scrollView.contentOffset.y + 64);
            }];
        }
    }
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _tableTitles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"personal_icon%ld.png",indexPath.row+1]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
/*
        case 0:
        {
            AddressBookController *vc = [[AddressBookController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            OrderViewController *vc = [[OrderViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
 */
        case 0:
        {
            SettingViewController *setting = [[SettingViewController alloc] init];
            [self.navigationController pushViewController:setting animated:YES];
        }
            break;
        case 1:
        {
            AssistViewController *assist = [[AssistViewController alloc] init];
            [self.navigationController pushViewController:assist animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
