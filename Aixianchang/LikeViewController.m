//
//  LikeViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/9.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "LikeViewController.h"
#import "ActivityModel.h"
#import "RecommendActiviytCell.h"

@interface LikeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end

static NSString *reuseIdentifier = @"reuse1";

@implementation LikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackgroundColor;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_tableView registerClass:[RecommendActiviytCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView)
    {
        CGFloat sectionHeaderHeight = 30;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d_good"]];
        [view addSubview:icon];
        [icon makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(10);
            make.centerY.equalTo(view);
            make.width.equalTo(@16);
            make.height.equalTo(@16);
        }];
        UILabel *tip = [UILabel new];
        tip.text = @"好戏推荐";
        tip.textColor = TextColor;
        tip.font = FONT11;
        [view addSubview:tip];
        [tip makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(10);
            make.centerY.equalTo(icon);
        }];
        UILabel *tip2 = [UILabel new];
        tip2.text = @"每周10部好剧请你看";
        tip2.textColor = UIColorFromRGB(0xbbbbbb);
        tip2.font = FONT11;
        [view addSubview:tip2];
        [tip2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(105);
            make.centerY.equalTo(icon);
        }];
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xcbcbcb);
        [view addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view);
            make.right.equalTo(view);
            make.bottom.equalTo(view);
            make.height.equalTo(@1);
        }];
        return view;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendActiviytCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    ActivityModel *model = [[ActivityModel alloc] init];
    model.title = @"啊多久啊苦逼的服务饿哦烦我恩平";
    model.author = @"亚力克斯顿";
    model.summary = @"发布内容必须遵循国家相关法律规定，凡是涉及色情暴力，违反伦理道德的，将会被立刻删除，并封停使用者账号。举报邮箱 appseller@ymatou.com发布内容必须遵循国家相关法律规定，凡是涉及色情暴力，违反伦理道德的，将会被立刻删除，并封停使用者账号。举报邮箱 appseller@ymatou.com";
    model.picture = @"http://img6.cache.netease.com/cnews/2015/1/8/20150108112844c5233.jpg";
    model.forwardNum = @110;
    model.leftNum = @20;
    model.price = @100;
    model.discount = @2;
    model.discountPrice = @20;
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
