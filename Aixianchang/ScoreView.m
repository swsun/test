//
//  ScoreView.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/22.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "ScoreView.h"

#define MIN_SPACE 3

@interface ScoreView ()
@property (strong, nonatomic) NSMutableArray *icons;
@end

@implementation ScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _icons = [NSMutableArray array];
        
        CGFloat width = MIN(frame.size.width / 5.0 - MIN_SPACE * 4, frame.size.height);
        CGFloat space = (frame.size.width - (width * 5)) / 4;
        for (int i = 0; i < 5; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"score_1"]];
            imgView.frame = CGRectMake(i * (width + space), (frame.size.height - width) / 2, width, width);
            [self addSubview:imgView];
            [_icons addObject:imgView];
        }
    }
    return self;
}

- (void)setScore:(NSInteger)score
{
    for (int i = 0; i < 5; i++) {
        UIImageView *imgView = [_icons objectAtIndex:i];
        if (i < score) {
            imgView.image = [UIImage imageNamed:@"score_1"];
        }else {
            imgView.image = [UIImage imageNamed:@"score_2"];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = MIN(self.frame.size.width / 5.0 , self.frame.size.height);
    CGFloat space = (self.frame.size.width - (width * 5)) / 4;
    for (int i = 0; i < 5; i++) {
        UIImageView *imgView = [_icons objectAtIndex:i];
        imgView.frame = CGRectMake(i * (width + space), (self.frame.size.height - width) / 2, width, width);
//        [self addSubview:imgView];
    }
}

@end
