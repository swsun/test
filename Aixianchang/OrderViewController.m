//
//  OrderViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderDetailController.h"
#import "OrderModel.h"
#import "OrderCell.h"

@interface OrderViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *orderList;

@property (strong, nonatomic) UILabel *emptyLabel;
@end

static NSString *reuseIdentifier = @"reuse";

@implementation OrderViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _orderList = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的订单";
    self.view.backgroundColor = BackgroundColor;
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = BackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    _emptyLabel = [UILabel new];
    _emptyLabel.textColor = UIColorFromRGB(0x868686);
    _emptyLabel.text = @"您暂时还没有订单";
    _emptyLabel.hidden = YES;
    [self.tableView addSubview:_emptyLabel];
    [_emptyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_tableView);
    }];
    
    [self.tableView registerClass:[OrderCell class] forCellReuseIdentifier:reuseIdentifier];
    
    [self doRequestOrder];
}

- (void)doRequestOrder
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApplicationDelegate.defaultEngine getDataByURL:OrderList params:@{} complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"请求失败" continueTime:1.0f];
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            [_orderList removeAllObjects];
            for (NSDictionary *dict in responseObject[RESPONSE_RESULT]) {
                OrderModel *model = [MTLJSONAdapter modelOfClass:[OrderModel class] fromJSONDictionary:dict error:nil];
                [_orderList addObject:model];
            }
            [self.tableView reloadData];
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
    }];
}

#pragma mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_orderList.count) {
        _emptyLabel.hidden = YES;
    }else
        _emptyLabel.hidden = NO;
    return _orderList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = _orderList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderDetailController *detail = [[OrderDetailController alloc] init];
    
    [self.navigationController pushViewController:detail animated:YES];
    
    detail.model = nil;
}

@end
