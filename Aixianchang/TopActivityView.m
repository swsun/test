//
//  TopActivityView.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/8.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "TopActivityView.h"
#import "ActivityModel.h"

@interface TopActivityView ()
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *downLabel;
@end

@implementation TopActivityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = [[UIImageView alloc] init];
        [self addSubview:_image];
        [_image makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(30, 0, 0, 0));
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = TextColor;
        [self addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self).offset(29);
            make.height.equalTo(@1);
        }];
        
        UIImageView *circle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"count-down"]];
        [self addSubview:circle];
        [circle makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(10);
            make.width.equalTo(@100);
            make.height.equalTo(@100);
        }];
        
        
        UILabel *tip3 = [UILabel new];
        tip3.font = FONT12B;
        tip3.text = @"抢票倒计时";
        tip3.textColor = UIColorFromRGB(0x00ffff);
        tip3.backgroundColor = [UIColor clearColor];
        [self addSubview:tip3];
        [tip3 makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(circle.mas_centerY).offset(-3);
        }];
        _downLabel = [UILabel new];
        _downLabel.font = DIGIIFont(16);
        _downLabel.textColor = UIColorFromRGB(0x00ffff);
        _downLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_downLabel];
        [_downLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(circle.mas_centerY).offset(3);
        }];
        
        
        UIImageView *icon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d_free"]];
        [self addSubview:icon1];
        [icon1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self.mas_top).offset(15);
            make.width.equalTo(@16);
            make.height.equalTo(@16);
        }];
        
        UILabel *tip = [UILabel new];
        tip.text = @"每日限免";
        tip.textColor = TextColor;
        tip.font = FONT11;
        [self addSubview:tip];
        [tip makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon1.mas_right).offset(10);
            make.centerY.equalTo(icon1);
        }];
        
        UILabel *tip2 = [UILabel new];
        tip2.textColor = UIColorFromRGB(0x868686);
        tip2.text = @"每日11时准时开放免费票";
        tip2.font = FONT11;
        [self addSubview:tip2];
        [tip2 makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon1);
            make.centerX.equalTo(self);
        }];
        
        UIView *bar = [UIView new];
        bar.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [self addSubview:bar];
        [bar makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_image);
            make.right.equalTo(_image);
            make.bottom.equalTo(_image);
            make.height.equalTo(@30);
        }];
        
        _title = [UILabel new];
        _title.textColor = [UIColor whiteColor];
        _title.font = FONT12;
        _title.backgroundColor = [UIColor clearColor];
        [self addSubview:_title  ];
        [_title makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.centerY.equalTo(bar);
        }];
        
        _price = [UILabel new];
        _price.textColor = [UIColor whiteColor];
        _price.font = FONT12;
        _price.backgroundColor = [UIColor clearColor];
        [self addSubview:_price];
        [_price makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.centerY.equalTo(_title);
        }];
    }
    return self;
}

- (void)setModel:(ActivityModel *)model
{
    _model = model;
    [_image sd_setImageWithURL:[NSURL URLWithString:model.picture]];
    _title.text = _model.title;
    _price.attributedText = [self textWithDeleteLine:[NSString stringWithFormat:@"原价%d元",_model.price.intValue]];
    _downLabel.text = @"12:12:12";
}

- (NSAttributedString*)textWithDeleteLine:(NSString*)text
{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:text];
    [att addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, text.length)];
    return att;
}

@end
