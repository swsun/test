//
//  OrderCell.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "OrderCell.h"
#import "OrderModel.h"

@interface OrderCell ()
@property (strong, nonatomic) UILabel *serialNumber;
@property (strong, nonatomic) UILabel *orderDate;
@property (strong, nonatomic) UIImageView *actImage;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *totalPrice;
@property (strong, nonatomic) UIButton *button;
@end

@implementation OrderCell

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
        
        _serialNumber = [UILabel new];
        _serialNumber.font = FONT14;
        [self.contentView addSubview:_serialNumber];
        [_serialNumber makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(15);
            make.centerY.equalTo(view.mas_top).offset(20);
        }];
        
        _orderDate = [UILabel new];
        _orderDate.font = FONT10;
        _orderDate.textColor = UIColorFromRGB(0x868686);
        [self.contentView addSubview:_orderDate];
        [_orderDate makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).offset(-15);
            make.centerY.equalTo(_serialNumber);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = BackgroundColor;
        [self.contentView addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(40);
            make.left.equalTo(_serialNumber);
            make.right.equalTo(_orderDate);
            make.height.equalTo(@1);
        }];
        
        _actImage = [[UIImageView alloc] init];
        _actImage.image = [UIImage imageNamed:@"9"];
        [self.contentView addSubview:_actImage];
        [_actImage makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.top.equalTo(line).offset(5);
            make.width.equalTo(@60);
            make.height.equalTo(@75);
        }];
        
        UIView *line2 = [UIView new];
        line2.backgroundColor = BackgroundColor;
        [self.contentView addSubview:line2];
        [line2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_actImage.mas_bottom).offset(5);
            make.left.equalTo(line);
            make.right.equalTo(line);
            make.height.equalTo(@1);
        }];
        
        _title = [UILabel new];
        _title.font = FONT14;
        [self.contentView addSubview:_title];
        [_title makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_actImage.mas_right).offset(10);
            make.top.equalTo(_actImage);
        }];
        
        _content = [UILabel new];
        _content.font = FONT11;
        _content.numberOfLines = 2;
        [self.contentView addSubview:_content];
        [_content makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.top.equalTo(_title.mas_bottom).offset(5);
            make.right.equalTo(line);
        }];
        
        _price = [UILabel new];
        _price.font = FONT11;
        [self.contentView addSubview:_price];
        [_price makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.bottom.equalTo(_actImage);
        }];
        
        _totalPrice = [UILabel new];
        _totalPrice.font = FONT15;
        [self.contentView addSubview:_totalPrice ];
        [_totalPrice makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.top.equalTo(line2).offset(10);
        }];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_button];
        [_button makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(line2);
            make.centerY.equalTo(_totalPrice);
            make.width.equalTo(@80);
            make.height.equalTo(@25);
        }];
        
        _button.titleLabel.font = FONT14;
        [_button setTitle:@"确认收货" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setBackgroundImage:[[Common imageWithColor:MainColor cornerRadius:4.0f] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(OrderModel *)model
{
    _model = model;
    
    _serialNumber.text = @"订单号: 1213243423";
    _orderDate.text = @"2012-12-12 14:12:22";
    _actImage.image = [UIImage imageNamed:@"9"];
    _title.text = @"围城";
    _content.text = @"熨斗最早的历史可溯至商代，它是作为刑具而发明的，专门用于熨烫人的肌肤，这使人联想到残暴的商纣王炮烙忠臣的故事。熨斗到汉代始用于熨烫衣服并流行于明清，又叫“火斗”，也有把熨斗叫做“北斗”、“金斗”";
    _price.text = @"原价: $122";
    _totalPrice.text = @"总价: $122";
}

@end
