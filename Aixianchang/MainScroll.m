//
//  MainScroll.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/18.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "MainScroll.h"
#import "BannerModel.h"

@interface MainScroll () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) UIButton *left;
@property (strong, nonatomic) UIButton *right;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UILabel *enTitle;
@property (strong, nonatomic) UILabel *title;
@end

@implementation MainScroll

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 170)];
        _scroll.delegate  = self;
        _scroll.pagingEnabled = YES;
        _scroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scroll];

        _left  =[UIButton buttonWithType:UIButtonTypeCustom];
        [_left setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
        [_left addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_left];
        [_left makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self).offset(-25);
        }];
        
        _right = [UIButton buttonWithType:UIButtonTypeCustom];
        [_right setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
        [_right addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_right];
        [_right makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self).offset(-25);
        }];
        
        _pageControl = [[UIPageControl alloc] init];
//        _pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
//        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        [self addSubview:_pageControl];
        [_pageControl makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(_scroll);
        }];
        
        _enTitle = [UILabel new];
        _enTitle.textColor = TextColor;
        _enTitle.font = [UIFont italicSystemFontOfSize:14];
        [self addSubview:_enTitle];
        [_enTitle makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.mas_bottom).offset(-35);
        }];
        
        _title = [UILabel new];
        _title.font = FONT14;
        _title.textColor = TextColor;
        [self addSubview:_title];
        [_title makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.mas_bottom).offset(-15);
        }];
    }
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

- (void)setModels:(NSArray *)models
{
    while (_scroll.subviews.count) {
        [_scroll.subviews.lastObject removeFromSuperview];
    }
    
    _models = models;
    _scroll.contentSize = CGSizeMake(320 * _models.count, 170);
    _pageControl.numberOfPages = _models.count;
    for (int i = 0; i < _models.count; i++) {
        BannerModel *model = _models[i];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0 + 320 * i, 0, 320, 170)];
//        img.image = [UIImage imageNamed:@"6"];
        img.tag = i;
        img.userInteractionEnabled = YES;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)]];
        [img sd_setImageWithURL:model.bannerPic];
        [_scroll addSubview:img];
    }
    
    BannerModel *model = _models[0];
    _enTitle.text = model.entext;
    _title.text = model.chtext;
//    _enTitle.text = @"November for The Electronic Music";
//    _title.text = @"属于电音的十一月";
}

- (void)imageTapped:(UITapGestureRecognizer*)tap
{
    [_delegate mainScrollDidSelectAtIndex:tap.view.tag];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / 320.0f;
    
    BannerModel *model = _models[_pageControl.currentPage];
    [UIView animateWithDuration:0.1 animations:^{
        _enTitle.alpha = 0;
        _title.alpha = 0;
    } completion:^(BOOL finished) {
        _enTitle.text = model.entext;
        _title.text = model.chtext;
        [UIView animateWithDuration:0.1 animations:^{
            _enTitle.alpha = 1;
            _title.alpha = 1;
        }];
    }];
    
}

@end
