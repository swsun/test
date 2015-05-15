//
//  RecommendActiviytCell.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/9.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "RecommendActiviytCell.h"
#import "ActivityModel.h"

@interface RecommendActiviytCell ()
@property (strong, nonatomic) UIImageView *activityImage;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *star;
@property (strong, nonatomic) UILabel *describe;
//@property (strong, nonatomic) UILabel *activityDate;
//@property (strong, nonatomic) UILabel *forwardCount;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *priceOld;
@property (strong, nonatomic) UILabel *leftCount;
@end

@implementation RecommendActiviytCell

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
        
        _star = [UILabel new];
        _star.textColor = UIColorFromRGB(0x00a6f7);
        _star.font = FONT12;
        [self.contentView addSubview:_star];
        [_star makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.top.equalTo(_title.mas_bottom).offset(3);
        }];
        
        _describe = [UILabel new];
        _describe.textColor = UIColorFromRGB(0x868686);
        _describe.font = FONT11;
        _describe.numberOfLines = 4;
        _describe.preferredMaxLayoutWidth = SCREEN_WIDTH - 115;
        [self.contentView addSubview:_describe];
        [_describe makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.top.equalTo(_star.mas_bottom).offset(3);
            make.right.equalTo(_title);
        }];
        
        _price = [UILabel new];
        _price.textColor = [UIColor redColor];
        _price.font = FONT12;
        [self.contentView addSubview:_price];
        [_price makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.top.equalTo(_describe.mas_bottom).offset(5);
        }];
        
        _priceOld = [UILabel new];
        _priceOld.textColor = TextColor;
        _priceOld.font = FONT12;
        [self.contentView addSubview:_priceOld];
        [_priceOld makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_price);
            make.top.equalTo(_price.mas_bottom).offset(5);
        }];
        
        _leftCount = [UILabel new];
        _leftCount.textColor = TextColor;
        _leftCount.font = FONT12;
        [self.contentView addSubview:_leftCount];
        [_leftCount makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_title);
            make.centerY.equalTo(_priceOld);
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
    _star.text = @"2";
    _describe.text = _model.summary;
    _price.text = _model.discountPrice.stringValue;
    _priceOld.attributedText = [self textWithDeleteLine:@""];
    _leftCount.text = [NSString stringWithFormat:@"仅剩%d件",_model.leftNum.intValue];
}

- (NSAttributedString*)textWithDeleteLine:(NSString*)text
{
    NSString *str = [NSString stringWithFormat:@"原价%d (%d折)",_model.price.intValue,_model.discount.intValue];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
    [att addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, _model.price.stringValue.length + 2)];
    return att;
}


@end
