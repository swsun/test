//
//  PersonalCell.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/27.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "PersonalCell.h"

@interface PersonalCell ()
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation PersonalCell

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
        
        _icon = [UIImageView new];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:_icon];
        [_icon makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(20);
            make.centerY.equalTo(view);
            make.height.equalTo(@15);
            make.width.equalTo(@15);
        }];
        
        _titleLabel = [UILabel new];
        _titleLabel.font = FONT15;
        [view addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_icon.mas_right).offset(20);
            make.centerY.equalTo(view);
        }];
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow_gray"]];
        [view addSubview:arrow];
        [arrow makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).offset(-20);
            make.centerY.equalTo(view);
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

- (UILabel *)textLabel
{
    return _titleLabel;
}

- (UIImageView *)imageView
{
    return _icon;
}

@end
