//
//  PersonalLevelController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "PersonalLevelController.h"
#import "PLevel1Controller.h"
#import "PLevel2Controller.h"
#import "PLevel3Controller.h"
#import "PersonalCell.h"

@interface PersonalLevelController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UIView *tableHeaderView;
@property (strong, nonatomic) UILabel *level;
@property (strong, nonatomic) UIProgressView *progress;
@property (strong, nonatomic) UILabel *integration;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *tableTitles;
@end

static NSString *reuseIdentifier = @"reuse";

@implementation PersonalLevelController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _tableTitles = @[@"了解个人等级",@"如何提高个人等级",@"等级积分兑换过的物品"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"个人等级";
    self.view.backgroundColor = BackgroundColor;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = BackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = self.tableHeaderView;
    [_tableView registerClass:[PersonalCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (UIView *)tableHeaderView
{
    if (_tableHeaderView) return _tableHeaderView;
    
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_back2"]];
    back.clipsToBounds = YES;
    [_tableHeaderView addSubview:back];
    [back makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(back);
    }];
    
    _level = [UILabel new];
    _level.font = FONT14;
    _level.textColor = [UIColor whiteColor];
    _level.text = @"当前等级 LV3";
    [_tableHeaderView addSubview:_level];
    [_level makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_tableHeaderView);
        make.top.equalTo(_tableHeaderView).offset(30);
    }];
    
    _progress = [[UIProgressView alloc] init];
    _progress.progress = 0.7;
    _progress.trackTintColor = [UIColor whiteColor];
    _progress.progressTintColor = [UIColor orangeColor];
    [_tableHeaderView addSubview:_progress];
    [_progress makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_tableHeaderView);
        make.width.equalTo(@260);
        make.height.equalTo(@5);
    }];
    
    _integration = [UILabel new];
    _integration.font = FONT12;
    _integration.textColor = [UIColor whiteColor];
    _integration.text = @"等级积分99,距离下一级还剩55";
    [_tableHeaderView addSubview:_integration];
    [_integration makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_tableHeaderView);
        make.top.equalTo(_progress.mas_bottom).offset(10);
    }];
    
    UILabel *tip = [UILabel new];
    tip.font = FONT10;
    tip.text = @"个人等级体现了您在爱现场平台上的活跃度,您可以通过积分换取奖励";
    tip.textColor = [UIColor whiteColor];
    [_tableHeaderView addSubview:tip];
    [tip makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_tableHeaderView);
        make.top.equalTo(_integration.mas_bottom).offset(10);
    }];
    
    return _tableHeaderView;
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
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"p_level_icon%ld.png",indexPath.row+1]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            PLevel1Controller *vc = [[PLevel1Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            PLevel2Controller *vc = [[PLevel2Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            PLevel3Controller *vc = [[PLevel3Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
