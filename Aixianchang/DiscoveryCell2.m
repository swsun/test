//
//  DiscoveryCell2.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/8.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "DiscoveryCell2.h"
#import "NewsModel.h"

@interface DiscoveryCell2 ()
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) UILabel *likeCount;
@property (strong, nonatomic) UILabel *commentCount;
@end

@implementation DiscoveryCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _image = [[UIImageView alloc] init];
        [self.contentView addSubview:_image];
        [_image makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.height.equalTo(@100);
            make.width.equalTo(@100);
        }];
        
        UIView *bl = [UIView new];
        bl.backgroundColor = UIColorFromRGB(0xc2c2c2);
        [self.contentView addSubview:bl];
        [bl makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@2);
        }];
        
        UIView *v1 = [UIView new];
        v1.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        [self.contentView addSubview:v1];
        [v1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_image);
            make.right.equalTo(_image);
            make.bottom.equalTo(_image);
            make.height.equalTo(@20);
        }];
        
        UIView *v2 = [UIView new];
        v2.backgroundColor = UIColorFromRGB(0x00ffff);
        [self.contentView addSubview:v2];
        [v2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(v1);
            make.top.equalTo(v1);
            make.bottom.equalTo(v1);
            make.width.equalTo(@3);
        }];
        
        _name = [UILabel new];
        _name.backgroundColor = [UIColor clearColor];
        _name.font = FONT11;
        _name.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_name];
        [_name makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(v2.mas_right).offset(1);
            make.centerY.equalTo(v1);
        }];
        
        UIImageView *mask = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d-back2"]];
        [self.contentView addSubview:mask];
        [mask makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_image).insets(UIEdgeInsetsMake(0, 50, 0, 0));
        }];
        
        _title = [UILabel new];
        _title.font = FONT14;
        _title.textColor = TextColor;
        [self.contentView addSubview:_title];
        [_title makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_image.mas_right).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.contentView).offset(5);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = TextColor;
        [self.contentView addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.right.equalTo(_title);
            make.top.equalTo(_title.mas_bottom).offset(5);
            make.height.equalTo(@1);
        }];
        
        _content = [UILabel new];
        _content.font = FONT11;
        _content.textColor = UIColorFromRGB(0x868686);
        _content.numberOfLines = 3;
        _content.preferredMaxLayoutWidth = SCREEN_WIDTH - 95;
        [self.contentView addSubview:_content];
        [_content makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.right.equalTo(_title);
            make.top.equalTo(line).offset(5);
        }];
        
        UIImageView *icon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d-love"]];
        [self.contentView addSubview:icon1];
        [icon1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_centerX);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
            make.width.equalTo(@12);
            make.height.equalTo(@12);
        }];
        
        _likeCount = [UILabel new];
        _likeCount.textColor = UIColorFromRGB(0xbbbbbb);
        _likeCount.font = FONT9;
        [self.contentView addSubview:_likeCount];
        [_likeCount makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon1.mas_right).offset(2);
            make.centerY.equalTo(icon1);
        }];
        
        UIImageView *icon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d-comment"]];
        [self.contentView addSubview:icon2];
        [icon2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_centerX).offset(SCREEN_WIDTH / 4 - 20);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.centerY.equalTo(icon1);
            make.width.equalTo(@12);
            make.height.equalTo(@12);
        }];
        
        _commentCount = [UILabel new];
        _commentCount.textColor = UIColorFromRGB(0xbbbbbb);
        _commentCount.font = FONT9;
        [self.contentView addSubview:_commentCount];
        [_commentCount makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon2.mas_right).offset(2);
            make.centerY.equalTo(icon2);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(NewsModel *)model
{
    _model = model;
    _title.text = _model.title;
    _content.text = _model.summary;
//    [_image sd_setImageWithURL:[NSURL URLWithString:_model.picture]];
    _image.image = [UIImage imageNamed:@"6"];
    _name.text = _model.author;
    _likeCount.text = [NSString stringWithFormat:@"%d人赞",_model.loveNum.intValue];
    _commentCount.text = [NSString stringWithFormat:@"%d人参与讨论",_model.commentNum.intValue];
}

@end
