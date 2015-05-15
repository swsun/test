//
//  RelatedActView.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/22.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "RelatedActView.h"
#import "ScoreView.h"
#import "ActivityModel.h"

@interface RelatedActView ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *actName;
@property (strong, nonatomic) ScoreView *score;
@end

@implementation RelatedActView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        [_imageView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"22"]];
        back.contentMode = UIViewContentModeBottom;
        [self addSubview:back];
        [back makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _actName = [UILabel new];
        _actName.textColor = [UIColor whiteColor];
        _actName.font = FONT12;
        _actName.layer.shadowColor = [UIColor grayColor].CGColor;
        _actName.layer.shadowOffset = CGSizeMake(1, 1);
        _actName.layer.shadowOpacity = 0.5f;
        _actName.layer.shadowRadius = 1.0f;
        [self addSubview:_actName];
        [_actName makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-2);
            make.centerX.equalTo(self);
        }];
        
        _score = [[ScoreView alloc] init];
        [self addSubview:_score];
        [_score makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(_actName.mas_top).offset(-2);
            make.height.equalTo(@10);
            make.width.equalTo(@60);
        }];
    }
    return self;
}

- (void)setModel:(ActivityModel *)model
{
    _model = model;
    
    _imageView.image = [UIImage imageNamed:@"21"];
    _actName.text = @"<这辈子有过你>";
    _score.score = 4;
}

@end
