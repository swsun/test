//
//  AdressCell.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "AdressCell.h"
#import "AddressModel.h"

@interface AdressCell ()
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) UILabel *address;
@end

@implementation AdressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = UIColorFromRGB(0x868686).CGColor;
        [self.contentView addSubview:view];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(3, -1, 3, -1));
        }];
        
        UILabel *label1 = [UILabel new];
        label1.font = FONT13;
        label1.text = @"收件人";
        [self.contentView addSubview:label1];
        [label1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(15);
            make.top.equalTo(view).offset(15);
        }];
        
        UILabel *label2 = [UILabel new];
        label2.font = FONT13;
        label2.text = @"联系电话";
        [self.contentView addSubview:label2];
        [label2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label1);
            make.centerY.equalTo(view);
        }];
        
        UILabel *label3 = [UILabel new];
        label3.font = FONT13;
        label3.text = @"收货地址";
        [self.contentView addSubview:label3];
        [label3 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label1);
            make.bottom.equalTo(view).offset(-15);
        }];
        
        _name = [UILabel new];
        _name.font = FONT13;
        [self.contentView addSubview:_name];
        [_name makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label1.mas_right).offset(10);
            make.centerY.equalTo(label1);
        }];
        
        _phone = [UILabel new];
        _phone.font = FONT13;
        [self.contentView addSubview:_phone];
        [_phone makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label2.mas_right).offset(10);
            make.centerY.equalTo(label2);
        }];
        
        _address = [UILabel new];
        _address.font = FONT13;
        [self.contentView addSubview:_address];
        [_address makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label3.mas_right).offset(10);
            make.centerY.equalTo(label3);
        }];
    }
    return self;
}

- (void)setModel:(AddressModel *)model
{
    _model = model;
    
    _name.text = @"蛤蛤蛤";
    _phone.text = @"13000000000";
    _address.text = @"上海南京东路222号";
}

@end
