//
//  ActivityView.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/8.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "SuggestActivityView.h"
#import "ActivityModel.h"

@interface SuggestActivityView ()
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *address;
@property (strong, nonatomic) UILabel *activityDate;
@property (strong, nonatomic) UILabel *activityDescribe;
@property (strong, nonatomic) UILabel *likeCount;
@property (strong, nonatomic) UILabel *wantCount;
@end

@implementation SuggestActivityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView * icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_title2"]];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:icon];
        [icon makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self.mas_top).offset(15);
            make.height.equalTo(@20);
            make.width.equalTo(@45);
        }];
        
        UILabel *label = [UILabel new];
        label.text = @"活动推介";
        label.font = FONT13;
        label.textColor = UIColorFromRGB(0x868686);
        [self addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.mas_top).offset(15);
        }];
        
        _image = [[UIImageView alloc] init];
//        _image.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_image];
        [_image makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self);
//            make.right.equalTo(self);
//            make.top.equalTo(self).offset(30);
//            make.height.equalTo(@200);
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(30, 0, 110, 0));
        }];
        
        UIView *b = [UIView new];
        b.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        [self addSubview:b];
        [b makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_image);
            make.right.equalTo(_image);
            make.bottom.equalTo(_image);
            make.height.equalTo(@30);
        }];
        
        _title = [UILabel new];
        _title.font = FONT14;
//        _title.backgroundColor = [UIColor whiteColor];
        _title.textColor = UIColorFromRGB(0xf64c33);
        [self addSubview:_title];
        [_title makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(b);
        }];
        
        _address = [UILabel new];
        _address.font = BoldFont(12);
        _address.textColor = TextColor;
        [self addSubview:_address];
        [_address makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(_image.mas_bottom).offset(3);
        }];
        
        _activityDate = [UILabel new];
        _activityDate.font = BoldFont(12);
        _activityDate.textColor = TextColor;
        [self addSubview:_activityDate];
        [_activityDate makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(_address);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = TextColor;
        [self addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_address);
            make.right.equalTo(_activityDate);
            make.top.equalTo(_address.mas_bottom).offset(3);
            make.height.equalTo(@1);
        }];
        
        _activityDescribe = [UILabel new];
        _activityDescribe.backgroundColor = [UIColor clearColor];
        _activityDescribe.textColor = UIColorFromRGB(0x868686);
        _activityDescribe.font = SystemFont(12);
        _activityDescribe.numberOfLines = 3;
        _activityDescribe.preferredMaxLayoutWidth = SCREEN_WIDTH - 60;
        [self addSubview:_activityDescribe];
        [_activityDescribe makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_address);
            make.right.equalTo(_activityDate);
            make.top.equalTo(line).offset(3);
        }];
        
        UIImageView *likeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like_count"]];
        likeIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:likeIcon];
        [likeIcon makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.bottom.equalTo(self).offset(-20);
            make.width.equalTo(@12);
            make.height.equalTo(@12);
        }];
        
        UIImageView *wantIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"want_count"]];
        wantIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:wantIcon];
        [wantIcon makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX);
            make.bottom.equalTo(likeIcon);
            make.width.equalTo(@12);
            make.height.equalTo(@12);
        }];
        
        _likeCount = [UILabel new];
        _likeCount.font = SystemFont(9);
        _likeCount.textColor = UIColorFromRGB(0xbbbbbb);
        [self addSubview:_likeCount];
        [_likeCount makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(likeIcon.mas_right).offset(2);
            make.centerY.equalTo(likeIcon);
        }];
        
        _wantCount = [UILabel new];
        _wantCount.font = SystemFont(9);
        _wantCount.textColor = UIColorFromRGB(0xbbbbbb);
        [self addSubview:_wantCount];
        [_wantCount makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wantIcon.mas_right).offset(2);
            make.centerY.equalTo(wantIcon);
        }];
    }
    return self;
}

- (void)setModel:(ActivityModel *)model
{
    _model = model;
    
    _image.image = [UIImage imageNamed:@"14"];
    _title.text = _model.title;
    _address.text = _model.addr;
    _activityDate.text = _model.startDate;
    _activityDescribe.text = _model.summary;
    _likeCount.text = [NSString stringWithFormat:@"%d人喜欢",_model.loveNum.intValue];
    _wantCount.text = [NSString stringWithFormat:@"%d人想看",_model.forwardNum.intValue];
}

@end
