//
//  PLevevCell1.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "PLevelCell1.h"

@interface PLevelCell1 ()
@property (strong, nonatomic) UILabel *level;
@property (strong, nonatomic) UILabel *describe;
@property (strong ,nonatomic) UIView *icons;
@end

@implementation PLevelCell1

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
        
        _level = [UILabel new];
        _level.font = FONT14;
        [self.contentView addSubview:_level];
        [_level makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(15);
            make.top.equalTo(view).offset(5);
        }];
        
        _describe = [UILabel new];
        _describe.font = FONT12;
        _describe.numberOfLines = 0;
        [self.contentView addSubview:_describe];
        [_describe makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_level);
            make.top.equalTo(_level.mas_bottom).offset(5);
            make.right.equalTo(view).offset(-15);
        }];
        
        _icons = [UIView new];
        _icons.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_icons];
        [_icons makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_level.mas_right).offset(10);
            make.centerY.equalTo(_level);
            make.height.equalTo(@15);
            make.width.equalTo(@200);
        }];
    }
    return self;
}

- (void)setLv:(NSInteger)lv
{
    _lv = lv;
    
    _level.text = [NSString stringWithFormat:@"等级%ld",(long)lv];
    _describe.text = @"新华网昆明1月22日电 中共中央总书记、国家主席、中央军委主席习近平21日在视察驻昆明部队时强调，要坚决贯彻党中央、中央军委决策指示，认真贯彻全军政治工作会议精神，牢固树立强基固本思想，按照军队基层建设纲要抓好基层建设，夯实部队建设基础，推动强军目标在基层落地生根。";
    
    while (_icons.subviews.count) {
        [_icons.subviews.lastObject removeFromSuperview];
    }
    
    for (int i = 0; i < lv; i++) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"score_1"]];
        img.frame = CGRectMake(17 * i, 0, 15, 15);
        [_icons addSubview:img];
    }
}

@end
