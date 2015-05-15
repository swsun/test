//
//  TpoNewsView.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/8.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "TopNewsView.h"
#import "NewsModel.h"

@interface TopNewsView ()
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *loveCount;
@property (strong, nonatomic) UILabel *forwardCount;
@end

@implementation TopNewsView

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
        
        UIImageView *icon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d-jian"]];
        [self addSubview:icon1];
        [icon1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self.mas_top).offset(15);
            make.width.equalTo(@16);
            make.height.equalTo(@16);
        }];
        
        UILabel *week = [UILabel new];
        week.font = FONT11;
        week.textColor = TextColor;
        week.text = @"每周推荐";
        [self addSubview:week];
        [week makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon1.mas_right).offset(10);
            make.centerY.equalTo(icon1);
        }];
        
        UILabel *w2 = [UILabel new];
        w2.font = FONT11;
        w2.text = @"每周为您推荐好剧";
        w2.textColor = UIColorFromRGB(0x868686);
        [self addSubview:w2];
        [w2 makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon1);
            make.centerX.equalTo(self);
        }];
        
        UIView *bar = [UIView new];
        bar.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [self addSubview:bar];
        [bar makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@30);
        }];
        
        UIImageView *icon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_title3"]];
        icon2.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:icon2];
        [icon2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(bar);
            make.height.equalTo(@20);
            make.width.equalTo(@45);
        }];
        
        UIImageView *icon3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like-white"]];
        [self addSubview:icon3];
        icon3.contentMode = UIViewContentModeScaleAspectFit;
        [icon3 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX);
            make.centerY.equalTo(bar);
            make.width.equalTo(@12);
            make.height.equalTo(@12);
        }];
        
        UIImageView *icon4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward-white"]];
        [self addSubview:icon4];
        icon4.contentMode = UIViewContentModeScaleAspectFit;
        [icon4 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(SCREEN_WIDTH / 4);
            make.centerY.equalTo(bar);
            make.width.equalTo(@12);
            make.height.equalTo(@12);
        }];
        
        _loveCount = [UILabel new];
        _loveCount.backgroundColor = [UIColor clearColor];
        _loveCount.font = FONT9;
        _loveCount.textColor = [UIColor whiteColor];
        [self addSubview:_loveCount];
        [_loveCount makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon3.mas_right).offset(2);
            make.centerY.equalTo(icon3);
        }];
        
        _forwardCount = [UILabel new];
        _forwardCount.backgroundColor = [UIColor clearColor];
        _forwardCount.font = FONT9;
        _forwardCount.textColor = [UIColor whiteColor];
        [self addSubview:_forwardCount];
        [_forwardCount makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon4.mas_right).offset(2);
            make.centerY.equalTo(icon4);
        }];
    }
    return self;
}

- (void)setModel:(NewsModel *)model
{
    _model = model;
    [_image sd_setImageWithURL:[NSURL URLWithString:_model.picture]];
    _loveCount.text = [NSString stringWithFormat:@"%d人喜欢",_model.loveNum.intValue];
    _forwardCount.text = [NSString stringWithFormat:@"%d人转发",_model.forwardNum.intValue];
}

@end
