//
//  PLevel3Controller.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "PLevel3Controller.h"
#import "PLevelCell3.h"

@interface PLevel3Controller () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end

static NSString *reuseIndentifier = @"reuse";

@implementation PLevel3Controller

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
    self.view.backgroundColor = BackgroundColor;
    
    self.title = @"等级积分兑换物品";
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = BackgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    _tableView.tableHeaderView = self.tableHeaderView;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[PLevelCell3 class] forCellReuseIdentifier:reuseIndentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLevelCell3 *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier forIndexPath:indexPath];
    cell.model = nil;
    return cell;
}

@end
