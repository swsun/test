//
//  DiscoveryViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/28.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoveryCell1.h"
#import "DiscoveryCell2.h"
#import "TopActivityView.h"
#import "TopNewsView.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

#import "ActivityModel.h"
#import "NewsModel.h"

@interface DiscoveryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UIScrollView *mainScroll;
@property (strong, nonatomic) UITableView *tableView1;
@property (strong, nonatomic) UITableView *tableView2;
@property (strong, nonatomic) TopActivityView *tableHeader1;
@property (strong, nonatomic) TopNewsView *tableHeader2;

@property (strong, nonatomic) HMSegmentedControl *segment;

@property (strong, nonatomic) NSMutableArray *array1;
@property (strong, nonatomic) NSMutableArray *array2;
@end

static NSString *reuseIdentifier1 = @"reuse1";
static NSString *reuseIdentifier2 = @"reuse2";

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    
    _array1 = [NSMutableArray array];
    _array2 = [NSMutableArray array];
    
    _segment = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"福利", @"互动"]];
    _segment.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    _segment.textColor = TextColor;
    _segment.selectedTextColor = UIColorFromRGB(0xff2500);
    _segment.font = FONT14;
    _segment.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segment.selectionIndicatorColor = UIColorFromRGB(0xff2500);
    _segment.selectionIndicatorHeight = 4.0f;
    [self.view addSubview:_segment];
    
    __block typeof(self) bSelf = self;
    [_segment setIndexChangeBlock:^(NSInteger index) {
        [bSelf segmentIndexChanged:index];
    }];
    
    _mainScroll = [[UIScrollView alloc] init];
    _mainScroll.pagingEnabled = YES;
    _mainScroll.showsHorizontalScrollIndicator = NO;
    _mainScroll.delegate = self;
    _mainScroll.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT - 155);
    [self.view addSubview:_mainScroll];
    [_mainScroll makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(42, 0, 0, 0));
    }];
    
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _mainScroll.bounds.size.height) style:UITableViewStylePlain];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableHeader1 = [[TopActivityView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    _tableView1.tableHeaderView = _tableHeader1;
    _tableView1.tableFooterView = [UIView new];
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mainScroll addSubview:_tableView1];
    [_tableView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainScroll);
        make.top.equalTo(_mainScroll);
        make.height.equalTo(_mainScroll);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _mainScroll.bounds.size.height) style:UITableViewStylePlain];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableHeader2 = [[TopNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    _tableView2.tableHeaderView = _tableHeader2;
    _tableView2.tableFooterView = [UIView new];
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mainScroll addSubview:_tableView2];
    [_tableView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainScroll).offset(SCREEN_WIDTH);
        make.top.equalTo(_mainScroll);
        make.height.equalTo(_mainScroll);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];

    [_tableView1 registerClass:[DiscoveryCell1 class] forCellReuseIdentifier:reuseIdentifier1];
    [_tableView2 registerClass:[DiscoveryCell2 class] forCellReuseIdentifier:reuseIdentifier2];
    
    [self reloadTableHeader1:[[ActivityModel alloc] init]];
    [self reloadTableHeader2:[[NewsModel alloc] init]];
    
    [self doRequestActivity];
}

- (void)segmentIndexChanged:(NSInteger)index
{
    [_mainScroll setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
}

- (void)reloadTableHeader1:(ActivityModel*)model
{
    model.title = @"南派三叔";
    model.price = @123;
    model.picture = @"http://img6.cache.netease.com/cnews/2015/1/8/20150108112844c5233.jpg";
    _tableHeader1.model = model;
}

- (void)reloadTableHeader2:(NewsModel*)model
{
    model.picture = @"http://img6.cache.netease.com/cnews/2015/1/8/20150108112844c5233.jpg";
    model.author = @"王小二";
    model.title = @"论傻逼与2B的区别";
    model.summary = @"啊的发奋为了你脾气烦呢我怕你放屁我呢烦kmmpsdfmpwieadnpweiip陪莪面前破灭我却颇矛盾哦莪面前但买泡面迫切么wo";
    model.loveNum = @1111;
    model.commentNum = @12312;
    model.forwardNum = @112221;
    _tableHeader2.model = model;
}

#pragma mark - UIScrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _mainScroll) {
        NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
        [_segment setSelectedSegmentIndex:index animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView1)
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
    if (tableView == _tableView1) {
        return 6;
    }else {
        return 8;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView1) {
        return 140;
    }else {
        return 102;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableView1) {
        return 30;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableView1) {
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
        tip.text = @"活动推荐";
        tip.textColor = TextColor;
        tip.font = FONT11;
        [view addSubview:tip];
        [tip makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(10);
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
    if (tableView == _tableView1) {
        DiscoveryCell1 *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier1 forIndexPath:indexPath];
        ActivityModel *model = [[ActivityModel alloc] init];
        model.title = @"啊多久啊苦逼的服务饿哦烦我恩平";
        model.author = @"亚力克斯顿";
        model.summary = @"发布内容必须遵循国家相关法律规定，凡是涉及色情暴力，违反伦理道德的，将会被立刻删除，并封停使用者账号。举报邮箱 appseller@ymatou.com发布内容必须遵循国家相关法律规定，凡是涉及色情暴力，违反伦理道德的，将会被立刻删除，并封停使用者账号。举报邮箱 appseller@ymatou.com";
        model.picture = @"http://img6.cache.netease.com/cnews/2015/1/8/20150108112844c5233.jpg";
        model.forwardNum = @110;
        cell.model = model;
        return cell;
    }else {
        DiscoveryCell2 *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2 forIndexPath:indexPath];
        NewsModel *model = [[NewsModel alloc] init];
        model.picture = @"http://img6.cache.netease.com/cnews/2015/1/8/20150108112844c5233.jpg";
        model.author = @"王小二";
        model.title = @"论傻逼与2B的区别";
        model.summary = @"啊的发奋为了你脾气烦呢我怕你放屁我呢烦kmmpsdfmpwieadnpweiip陪莪面前破灭我却颇矛盾哦莪面前但买泡面迫切么wo";
        model.loveNum = @1111;
        model.commentNum = @12312;
        cell.model = model;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Request
- (void)doRequestActivity
{
    NSDictionary *param = @{@"page":@1,
                            @"size":@10};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApplicationDelegate.defaultEngine getDataByURL:GetNews params:param complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)doRequestNews
{
    
}

@end
