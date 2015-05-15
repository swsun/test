//
//  FilterView.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/20.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "FilterView.h"

@interface FilterView()
//@property (strong, nonatomic) NSArray *cates;
@end

@implementation FilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.cates = @[@"舞台剧",@"赛事",@"活动",@"娱乐",@"音乐剧",@"liveshow",@"音乐会",@"展览"];
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        [[NewsModel NewsCategoryNames] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *str = (NSString*)obj;
            CGFloat width = SCREEN_WIDTH / 4.0f;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(floor(idx % 4) * width, floor(idx / 4) * 40, width, 40)];
            label.text = str;
            label.font = FONT13;
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            
            label.tag = idx;
            label.userInteractionEnabled = YES;
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryTapped:)]];
        }];
    }
    return self;
}

- (void)categoryTapped:(UITapGestureRecognizer*)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(filterView:didSelectCategory:)]) {
        [_delegate filterView:self didSelectCategory:(NewsCategory)(sender.view.tag == 7 ? 0 : (sender.view.tag + 1))];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGFloat width = SCREEN_WIDTH / 4.0f;
    [UIColorFromRGB(0x6e6e6e) setFill];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, rect.size.height / 2, rect.size.width  -40, 1)];
    [path fill];
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width - 2, rect.size.height / 2 - 2, 4, 4) cornerRadius:2];
    [path2 fill];
    
    UIBezierPath *path3 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width * 2 - 2, rect.size.height / 2 - 2, 4, 4) cornerRadius:2];
    [path3 fill];
    
    UIBezierPath *path4 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width * 3 - 2, rect.size.height / 2 - 2, 4, 4) cornerRadius:2];
    [path4 fill];
}

@end
