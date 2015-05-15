//
//  AddressBookController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "AddressBookController.h"
#import "AdressCell.h"
#import "AddressModel.h"

@interface AddressBookController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *addressList;

@property (strong, nonatomic) UILabel *emptyLabel;
@end

static NSString *reuseIdentifier = @"reuse";

@implementation AddressBookController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _addressList = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的收货地址";
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
    _emptyLabel.text = @"还未添加收货地址";
    _emptyLabel.hidden = YES;
    [self.tableView addSubview:_emptyLabel];
    [_emptyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_tableView);
    }];
    
    [_tableView registerClass:[AdressCell class] forCellReuseIdentifier:reuseIdentifier];
    
    [self doRequestAddress];
}

- (void)doRequestAddress
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApplicationDelegate.defaultEngine getDataByURL:GetAddress params:@{} complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"请求失败" continueTime:1.0f];
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            [_addressList removeAllObjects];
            
            for (NSDictionary *dict in responseObject[RESPONSE_RESULT]) {
                AddressModel *model = [MTLJSONAdapter modelOfClass:[AddressModel class] fromJSONDictionary:dict error:nil];
                [_addressList addObject:model];
            }
            [self.tableView reloadData];
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
    }];
}

#pragma mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_addressList.count) {
        _emptyLabel.hidden = YES;
    }else
        _emptyLabel.hidden = NO;
    return _addressList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = _addressList[indexPath.row];
    return cell;
}
@end
