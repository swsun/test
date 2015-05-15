//
//  AXSegment.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/28.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "AXSegment.h"

@interface AXSegment()
@property (strong, nonatomic) UILabel *title1;
@property (strong, nonatomic) UILabel *title2;
@property (strong, nonatomic) UILabel *title3;
@property (strong, nonatomic) UIImageView *selectBack;
@end

@implementation AXSegment

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
        backView.backgroundColor = UIColorFromRGB(0x747474);
        backView.layer.cornerRadius = frame.size.height / 2;
        backView.layer.masksToBounds = YES;
        [self addSubview:backView];
        self.backgroundColor = [UIColor clearColor];
        
        _selectBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 3, frame.size.height)];
        [self addSubview:_selectBack];
        
        _title1 = [[UILabel alloc] init];
        _title1.backgroundColor = [UIColor clearColor];
        _title1.textColor = [UIColor whiteColor];
        [self addSubview:_title1];
        [_title1 makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(- frame.size.width / 3.0f);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        _title2 = [[UILabel alloc] init];
        _title2.backgroundColor = [UIColor clearColor];
        _title2.textColor = [UIColor whiteColor];
        [self addSubview:_title2];
        [_title2 makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        _title3 = [[UILabel alloc] init];
        _title3.backgroundColor = [UIColor clearColor];
        _title3.textColor = [UIColor whiteColor];
        [self addSubview:_title3];
        [_title3 makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(frame.size.width / 3.0f);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)]];
        
        [self setSelectIndex:0];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    NSAssert(titles.count == 3, @"Segemnt titles number must be 3");
    _title1.text = titles[0];
    _title2.text = titles[1];
    _title3.text = titles[2];
}

- (void)tapped:(UITapGestureRecognizer*)tap
{
    CGPoint p = [tap locationInView:self];
    if (p.x < self.bounds.size.width / 3.0f) {
        [self setSelectIndex:0];
    }else if (p.x < self.bounds.size.width / 3.0f * 2) {
        [self setSelectIndex:1];
    }else {
        [self setSelectIndex:2];
    }
}

- (void)setSelectIndex:(NSInteger)idx
{
    switch (idx) {
        case 0:
        {
            _selectBack.image = [UIImage imageNamed:@"seg_left"];
            _selectBack.frame = CGRectMake(0, 0, self.bounds.size.width / 3.0f, self.bounds.size.height);
        }
            break;
        case 1:
        {
            _selectBack.image = [UIImage imageNamed:@"seg_center"];
            _selectBack.frame = CGRectMake(self.bounds.size.width / 3.0f, 0, self.bounds.size.width / 3.0f, self.bounds.size.height);
        }
            break;
        case 2:
        {
            _selectBack.image = [UIImage imageNamed:@"seg_right"];
            _selectBack.frame = CGRectMake(self.bounds.size.width / 3.0f * 2, 0, self.bounds.size.width / 3.0f, self.bounds.size.height);
        }
            break;
        default:
            break;
    }
    
    if (self.selectBlock) {
        self.selectBlock(idx);
    }
}

@end
