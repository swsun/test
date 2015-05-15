//
//  DiscoveryCell1.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/8.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "DiscoveryCell1.h"
#import "ActivityModel.h"

@interface DiscoveryCell1 ()
@property (strong, nonatomic) UIImageView *activityImage;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *producer;
@property (strong, nonatomic) UILabel *describe;
@property (strong, nonatomic) UILabel *activityDate;
@property (strong, nonatomic) UILabel *forwardCount;
@end

@implementation DiscoveryCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _activityImage = [[UIImageView alloc] init];
        _activityImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_activityImage];
        [_activityImage makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(15);
            make.bottom.equalTo(self.contentView).offset(-15);
            make.width.equalTo(@75);
        }];
        
        UIImageView *mask = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d-back1"]];
        [self.contentView addSubview:mask];
        [mask makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_activityImage).insets(UIEdgeInsetsMake(-5, -5, -5, -5));
        }];
        
        _title = [UILabel new];
        _title.textColor = TextColor;
        _title.font = FONT13;
        [self.contentView addSubview:_title];
        [_title makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(105);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(mask);
        }];
        
        _producer = [UILabel new];
        _producer.textColor = UIColorFromRGB(0x00a6f7);
        _producer.font = FONT12;
        [self.contentView addSubview:_producer];
        [_producer makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.top.equalTo(_title.mas_bottom).offset(5);
        }];
        
        _describe = [UILabel new];
        _describe.textColor = UIColorFromRGB(0x868686);
        _describe.font = FONT11;
        _describe.numberOfLines = 4;
        _describe.preferredMaxLayoutWidth = SCREEN_WIDTH - 115;
        [self.contentView addSubview:_describe];
        [_describe makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.top.equalTo(_producer.mas_bottom).offset(5);
            make.right.equalTo(_title);
        }];
        
        _activityDate = [UILabel new];
        _activityDate.font = FONT11;
        _activityDate.textColor = UIColorFromRGB(0xff4100);
        [self.contentView addSubview:_activityDate];
        [_activityDate makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.bottom.equalTo(_activityImage);
        }];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward-count"]];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:icon];
        [icon makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_activityDate.mas_right).offset(15);
            make.centerY.equalTo(_activityDate);
            make.width.equalTo(@12);
            make.height.equalTo(@12);
        }];
        
        _forwardCount = [UILabel new];
        _forwardCount.font = FONT11;
        _forwardCount.textColor = UIColorFromRGB(0x868686);
        [self.contentView addSubview:_forwardCount];
        [_forwardCount makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(3);
            make.centerY.equalTo(_activityDate);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xcbcbcb);
        [self.contentView addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@1);
        }];
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

- (void)setModel:(ActivityModel *)model
{
    _model = model;
//    [_activityImage sd_setImageWithURL:[NSURL URLWithString:_model.picture]];
    _activityImage.image = [UIImage imageNamed:@"4"];
    _title.text = _model.title;
    _producer.text = _model.author;
    _describe.text = _model.summary;
    _activityDate.text = [NSString stringWithFormat:@"活动时间:"];
    _forwardCount.text = [NSString stringWithFormat:@"%d人转发",_model.forwardNum.intValue];
}

@end
