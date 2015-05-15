//
//  scrolll.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/21.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "StillsScrolll.h"

@interface StillsScrolll () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) UIButton *left;
@property (strong, nonatomic) UIButton *right;
//@property (strong, nonatomic) UIPageControl *pageControl;
//@property (strong, nonatomic) UILabel *enTitle;
//@property (strong, nonatomic) UILabel *title;
@end

@implementation StillsScrolll
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 125)];
    _scroll.delegate  = self;
//    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scroll];
    
    _left  =[UIButton buttonWithType:UIButtonTypeCustom];
    [_left setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
    [_left addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_left];
    [_left makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    _right = [UIButton buttonWithType:UIButtonTypeCustom];
    [_right setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
    [_right addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_right];
    [_right makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self);
    }];

    return self;
}

- (void)changeIndex:(id)sender
{
    CGPoint offset = _scroll.contentOffset;
    if (sender == _left && offset.x >=320) {
        offset.x -= 320;
    }else if (sender == _right && offset.x <= _scroll.contentSize.width - 320) {
        offset.x += 320;
    }
    [_scroll setContentOffset:offset animated:YES];
}

- (void)setStills:(NSArray *)stills
{
    _stills = stills;
    _scroll.contentSize = CGSizeMake(200 * _stills.count, 125);
//    _pageControl.numberOfPages = _models.count;
    for (int i = 0; i < _stills.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0 + 200 * i, 0, 200, 125)];
        img.image = [UIImage imageNamed:@"17"];
        [_scroll addSubview:img];
    }
}

//
//- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
//{
//    NSLog(@"touch scroll");
//    // If not dragging, send event to next responder
//    if (!self.dragging)
//        [self.nextResponder touchesEnded: touches withEvent:event];
//    else
//        [super touchesEnded: touches withEvent: event];
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    if (self.dragging) {
//        [super touchesMoved:touches withEvent:event];
//    } else {
//        if ([self.delegate isKindOfClass:[UITableViewCell class]]) {
//            [(UITableViewCell *)self.delegate touchesCancelled:touches withEvent:event];
//        }
//        
//        [self.superview touchesMoved:touches withEvent:event];
//    }
//}
@end
