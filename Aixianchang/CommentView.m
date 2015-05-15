//
//  CommentView.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/22.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "CommentView.h"
#import "CommentModel.h"
#import "ScoreView.h"

@interface CommentView ()
@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *username;
@property (strong, nonatomic) ScoreView *score;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) UILabel *zanCount;
@property (strong, nonatomic) UILabel *time;
@end

@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _avatar = [[UIImageView alloc] init];
        _avatar.layer.cornerRadius = 3.0f;
        _avatar.layer.borderColor = UIColorFromRGB(0x868686).CGColor;
        _avatar.layer.borderWidth = 1.0f;
        _avatar.layer.masksToBounds = YES;
        _avatar.image = [UIImage imageNamed:@"16"];
        [self addSubview:_avatar];
        [_avatar makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.top.equalTo(self).offset(5);
            make.width.equalTo(@60);
            make.height.equalTo(@60);
        }];
        
        _username = [UILabel new];
        _username.font = FONT14;
        _username.textColor = TextColor;
        [self addSubview:_username];
        [_username makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatar.mas_right).offset(10);
            make.top.equalTo(_avatar);
        }];
        
        _score = [[ScoreView alloc] init];
        [self addSubview:_score];
        [_score makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_username.mas_right).offset(10);
            make.centerY.equalTo(_username);
            make.height.equalTo(@10);
            make.width.equalTo(@60);
        }];
        
        _content = [UILabel new];
        _content.font = FONT12;
        _content.numberOfLines = 3;
        _content.textColor = UIColorFromRGB(0x868686);
        [self addSubview:_content];
        [_content makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_username);
            make.top.equalTo(_username.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-20);
        }];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_icon5"]];
        [self addSubview:icon];
        [icon makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_username);
            make.bottom.equalTo(self.mas_bottom).offset(-7);
        }];
        
        _zanCount = [UILabel new];
        _zanCount.font = FONT10;
        _zanCount.textColor = UIColorFromRGB(0x868686);
        [self addSubview:_zanCount];
        [_zanCount makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(5);
            make.centerY.equalTo(icon);
//            make.bottom.equalTo(self).offset(-10);
        }];
        
        _time = [UILabel new];
        _time.font = FONT10;
        _time.textColor = UIColorFromRGB(0x868686);
        [self addSubview:_time];
        [_time makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.centerY.equalTo(_zanCount);
//            make.bottom.equalTo(self).offset(-10);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0x868686);
        [self addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.height.equalTo(@1);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)setModel:(CommentModel *)model
{
    _model = model;
    
//    _avatar.image = [UIImage imageNamed:@"16"];
    [_avatar sd_setImageWithURL:_model.picture];
    
    _username.text = _model.nickname;
    _score.score = _model.grade.integerValue / 2;
    _content.text = _model.content;
    
    _zanCount.text = _model.goodNum.stringValue;
    _time.text = [Common makeCalendarOffset:_model.createDate];
}

@end
