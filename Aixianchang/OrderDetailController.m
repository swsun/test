//
//  OrderDetailController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "OrderDetailController.h"

@interface OrderDetailController ()
@property (strong, nonatomic) UIImageView *actImage;
@property (strong, nonatomic) UILabel *actTitle;
@property (strong, nonatomic) UILabel *count;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *serialNumber;
@property (strong, nonatomic) UILabel *orderDate;

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) UILabel *address;

@property (strong, nonatomic) UILabel *price1;
@property (strong, nonatomic) UILabel *price2;
@property (strong, nonatomic) UILabel *price3;

@property (strong, nonatomic) UIButton *button;
@end

@implementation OrderDetailController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _actImage = [[UIImageView alloc] init];
    [self.view addSubview:_actImage];
    [_actImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@75);
    }];
    
    _actTitle = [UILabel new];
    _actTitle.font = FONT14;
    [self.view addSubview:_actTitle];
    [_actTitle makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_actImage.mas_right).offset(10);
        make.top.equalTo(_actImage);
    }];
    
    _count = [UILabel new];
    _count.font = FONT11;
    [self.view addSubview:_count];
    [_count makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_actTitle);
        make.centerY.equalTo(_actImage).offset(-3);
    }];
    
    _price = [UILabel new];
    _price.font = FONT12;
    [self.view addSubview:_price];
    [_price makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_actTitle);
        make.centerY.equalTo(_actImage.mas_bottom).offset(-6);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = BackgroundColor;
    [self.view addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(_actImage.mas_bottom).offset(40);
        make.height.equalTo(@1);
    }];
    
    _serialNumber = [UILabel new];
    _serialNumber.font = FONT13;
    [self.view addSubview:_serialNumber];
    [_serialNumber makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.centerY.equalTo(line).offset(-20);
    }];
    
    _orderDate = [UILabel new];
    _orderDate.font = FONT11;
    [self.view addSubview:_orderDate];
    [_orderDate makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.centerY.equalTo(_serialNumber);
    }];
    
    UILabel *label1 = [UILabel new];
    label1.font = FONT12;
    label1.text = @"收件人";
    [self.view addSubview:label1];
    [label1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_serialNumber);
        make.top.equalTo(line).offset(10);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"联系电话";
    label2.font = FONT12;
    [self.view addSubview:label2];
    [label2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_serialNumber);
        make.top.equalTo(label1.mas_bottom).offset(10);
    }];
    
    UILabel *label3 = [UILabel new];
    label3.text = @"收货地址";
    label3.font = FONT12;
    [self.view addSubview:label3];
    [label3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_serialNumber);
        make.top.equalTo(label2.mas_bottom).offset(10);
    }];
    
    _name = [UILabel new];
    _name.font = FONT12;
    [self.view addSubview:_name];
    [_name makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line);
        make.centerY.equalTo(label1);
    }];
    
    _phone = [UILabel new];
    _phone.font = FONT12;
    [self.view addSubview:_phone];
    [_phone makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line);
        make.centerY.equalTo(label2);
    }];
    
    _address = [UILabel new];
    _address.font = FONT12;
    [self.view addSubview:_address];
    [_address makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line);
        make.centerY.equalTo(label3);
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = BackgroundColor;
    [self.view addSubview:line2];
    [line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.right.equalTo(line);
        make.top.equalTo(label3.mas_bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UILabel *label4 = [UILabel new];
    label4.font = FONT13;
    label4.text = @"结算";
    [self.view addSubview:label4];
    [label4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.top.equalTo(line2).offset(10);
    }];
    
    UILabel *label5 = [UILabel new];
    label5.font = FONT12;
    label5.text = @"商品价";
    [self.view addSubview:label5];
    [label5 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2);
        make.top.equalTo(label4.mas_bottom).offset(10);
    }];
    
    UILabel *label6 = [UILabel new];
    label6.font = FONT12;
    label6.text = @"运费(货到付款)";
    [self.view addSubview:label6];
    [label6 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2);
        make.top.equalTo(label5.mas_bottom).offset(10);
    }];
    
    UILabel *label7 = [UILabel new];
    label7.font = FONT12;
    label7.text = @"总计";
    [self.view addSubview:label7];
    [label7 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2);
        make.top.equalTo(label6.mas_bottom).offset(10);
    }];
    
    _price1 = [UILabel new];
    _price1.font = FONT12;
    [self.view addSubview:_price1];
    [_price1 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line2);
        make.centerY.equalTo(label5);
    }];
    
    _price2 = [UILabel new];
    _price2.font = FONT12;
    [self.view addSubview:_price2];
    [_price2 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line2);
        make.centerY.equalTo(label6);
    }];
    
    _price3 = [UILabel new];
    _price3.font = FONT12;
    [self.view addSubview:_price3];
    [_price3 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line2);
        make.centerY.equalTo(label7);
    }];
    
    UIView *line3 = [UIView new];
    line3.backgroundColor = BackgroundColor;
    [self.view addSubview:line3];
    [line3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(label7.mas_bottom).offset(10);
        make.height.equalTo(@2);
    }];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.titleLabel.font = FONT14;
    [_button setTitle:@"确认收货" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button setBackgroundImage:[[Common imageWithColor:MainColor cornerRadius:4.0f] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [self.view addSubview:_button];
    [_button makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(line3).offset(20);
        make.height.equalTo(@40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//}
//- (void)setModel:(OrderModel *)model
//{
//    _model = model;
    
    _actImage.image = [UIImage imageNamed:@"9"];
    _actTitle.text = @"山茶树之恋";
    _count.text = [NSString stringWithFormat:@"数量: 1"];
    _price.text = [NSString stringWithFormat:@"原价: $188"];
    _serialNumber.text = [NSString stringWithFormat:@"订单号:1223435454"];
    _orderDate.text =[NSString stringWithFormat:@"2015-10-12 22:12:10"];
    _name.text = @"小二";
    _phone.text = @"13000000000";
    _address.text = @"上海 南京东路 1234号";
    
    _price1.text = @"$ 188";
    _price2.text = @"$ 10";
    _price3.text = @"$ 200";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
