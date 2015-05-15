//
//  PLevelCell3.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "PLevelCell3.h"

#import "ActivityModel.h"

@interface PLevelCell3 ()
@property (strong, nonatomic) UILabel *convertDate;
@property (strong, nonatomic) UIImageView *actImage;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *daoyan;
@property (strong, nonatomic) UILabel *zhuyan;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) UILabel *count;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *integration;
@end

@implementation PLevelCell3

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
        
        _convertDate = [UILabel new];
        _convertDate.font = FONT13;
        [view addSubview:_convertDate];
        [_convertDate makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(10);
            make.top.equalTo(view).offset(8);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xbebebe);
        [view addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_convertDate.mas_bottom).offset(8);
            make.left.equalTo(view).offset(10);
            make.right.equalTo(view).offset(-10);
            make.height.equalTo(@1);
        }];
        
        _actImage = [[UIImageView alloc] init];
        [view addSubview:_actImage];
        [_actImage makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(15);
            make.top.equalTo(line).offset(10);
            make.width.equalTo(@60);
            make.height.equalTo(@75);
        }];
        
        _title = [UILabel new];
        _title.font = FONT13;
        [view addSubview:_title];
        [_title makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_actImage.mas_right).offset(15);
            make.top.equalTo(line).offset(5);
        }];
        
        _daoyan = [UILabel new];
        _daoyan.font = FONT10;
        _daoyan.textColor = UIColorFromRGB(0xbebebe);
        [view addSubview:_daoyan];
        [_daoyan makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_title.mas_bottom).offset(3);
            make.left.equalTo(_title);
        }];
        
        _zhuyan = [UILabel new];
        _zhuyan.font = FONT10;
        _zhuyan.textColor = UIColorFromRGB(0xbebebe);
        [view addSubview:_zhuyan];
        [_zhuyan makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.top.equalTo(_daoyan.mas_bottom).offset(1);
        }];
        
        _content = [UILabel new];
        _content.font = FONT12;
        _content.numberOfLines = 3;
        [view addSubview:_content];
        [_content makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.right.equalTo(view).offset(-10);
            make.top.equalTo(_zhuyan.mas_bottom).offset(3);
        }];
        
        _count = [UILabel new];
        _count.font = FONT12;
        [view addSubview:_count];
        [_count makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.bottom.equalTo(view).offset(-5);
        }];
        
        _price = [UILabel new];
        _price.font = FONT12;
        [view addSubview:_price];
        [_price makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_count.mas_right).offset(15);
            make.top.equalTo(_count);
        }];
        
        _integration = [UILabel new];
        _integration.font = FONT15;
        _integration.textColor = UIColorFromRGB(0xff1700);
        [view addSubview:_integration];
        [_integration makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).offset(-10);
            make.bottom.equalTo(_count);
        }];
    }
    return self;
}

- (void)setModel:(ActivityModel *)model
{
    _model = model;
    
    _convertDate.text = [NSString stringWithFormat:@"兑换时间: 2011-12-22 12:00:00"];
    _actImage.image = [UIImage imageNamed:@"9"];
    _title.text = @"山茶树之恋";
    _daoyan.text = [NSString stringWithFormat:@"导演:郭小四 编剧:杨幂"];
    _zhuyan.text = [NSString stringWithFormat:@"主演:潘长江/冯巩/蔡明"];
    _content.text = @"有部分北京市政协委员不太赞成让北京高校在河北办分校，或主体迁到河北的做法，认为要破除“大锅饭”、“削峰填谷”的思路，不能简单采取行政化、一刀切的手法。也有北京市政协委员建议，可先从校办企业、产业研发基地等高校内部与教学联系不是特别紧密的部分入手，将他们外迁到河北、天津。";
    
    _count.text = [NSString stringWithFormat:@"数量: 22"];
    _price.text = [NSString stringWithFormat:@"价值: $123"];
    _integration.text = [NSString stringWithFormat:@"1000积分兑换"];
}
@end
