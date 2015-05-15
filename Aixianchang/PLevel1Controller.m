//
//  PLevel1Controller.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "PLevel1Controller.h"
#import "PLevelCell1.h"

@interface PLevel1Controller () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *tableHeaderView;
@end

static NSString *reuseIndentifier = @"reuse";

@implementation PLevel1Controller

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"了解个人等级";
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = BackgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _tableView.tableHeaderView = self.tableHeaderView;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[PLevelCell1 class] forCellReuseIdentifier:reuseIndentifier];
}

- (UIView*)tableHeaderView
{
    if (_tableHeaderView) return _tableHeaderView;
    
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    _tableHeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    label.text = @"了解个人等级获得更多特权";
    label.font = FONT13;
    [_tableHeaderView addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_tableHeaderView);
        make.left.equalTo(_tableHeaderView).offset(15);
    }];
    
    return _tableHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLevelCell1 *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier forIndexPath:indexPath];
    cell.lv = indexPath.row + 1;
    return cell;
}

@end
