//
//  DetailController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/20.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "DetailController.h"
#import "HtmlPageViewController.h"
#import "LoginViewController.h"
#import "XJNavController.h"
#import "StillsScrolll.h"
#import "CommentView.h"
#import "RelatedActView.h"
#import "ScoreView.h"
#import "AddCommentController.h"

#import "NewsModel.h"
#import "CommentModel.h"

#import "UMSocial.h"
#import "UIImage+Blur.h"
#import "UIImage+ProportionalFill.h"

#define PageSize 10

@interface DetailController () <UMSocialUIDelegate>
{
    UILabel *recMan;
    UIImageView *authorAvatar;
    UILabel *authorName;
    UILabel *recDesc;
    UILabel *publisher;
    UILabel *content;
    UILabel *contentExp;
    
    BOOL contentExpand;
    BOOL describeExpand;
    
    MASConstraint *buttomConstraint;
    
    NSInteger currentPage;
}
@property (strong, nonatomic) UIView *topView;

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *imageBack;
@property (strong, nonatomic) UILabel *lblTitle;
@property (strong, nonatomic) UILabel *lblScore;
@property (strong, nonatomic) ScoreView *scoreView;
@property (strong, nonatomic) UILabel *lblDirector;
@property (strong, nonatomic) UILabel *lblAddress;
@property (strong, nonatomic) UILabel *lblActDate;
@property (strong, nonatomic) UIButton *button1;
@property (strong, nonatomic) UIButton *button2;
@property (strong, nonatomic) UILabel *lblTitle2;
@property (strong, nonatomic) UILabel *lblDescribe;

@property (strong, nonatomic) UIView *introductionView;

@property (strong, nonatomic) UILabel *lblStillTip;
@property (strong, nonatomic) StillsScrolll *stills;
@property (strong, nonatomic) UIView *commentsView;
//@property (strong, nonatomic) UIView *relatedAct;


@property (strong, nonatomic) NSMutableArray *comments;
@end

@implementation DetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _comments = [NSMutableArray array];
    
    UIView *r = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50,44);
    [rightBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [r addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

    
    _topView = [UIView new];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    [_topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [_topView addSubview:img];
    [img makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topView);
        make.centerY.equalTo(_topView).offset(10);
    }];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 0400)];
    [self.view addSubview:_scrollView];
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets (UIEdgeInsetsMake(100, 0, 0, 0));
    }];
    
    _mainView = [[UIView alloc] initWithFrame:_scrollView.bounds];
    _mainView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_mainView];
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    _imageBack = [[UIImageView alloc] init];
    [_mainView addSubview:_imageBack];
    [_imageBack makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.top.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.height.equalTo(@223);
    }];
    
    _imageView = [[UIImageView alloc] init];
    [_mainView addSubview:_imageView];
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_imageBack);
        make.width.equalTo(@124);
        make.height.equalTo(@175);
    }];
    
    _lblTitle = [UILabel new];
    _lblTitle.font = FONT14;
    _lblTitle.text = @"活动标题";
    _lblTitle.textColor = TextColor;
    [_mainView addSubview:_lblTitle];
    [_lblTitle makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(_imageBack.mas_bottom).offset(20);
    }];
    
    UILabel *tip1 = [UILabel new];
    tip1.font = FONT11;
    tip1.textColor = UIColorFromRGB(0x868686);
    tip1.text = @"爱现场评分:";
    [_mainView addSubview:tip1];
    [tip1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblTitle);
        make.top.equalTo(_lblTitle.mas_bottom).offset(2);
    }];
    
    _scoreView = [[ScoreView alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [_mainView addSubview:_scoreView];
    [_scoreView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tip1.mas_right).offset(5);
        make.centerY.equalTo(tip1);
        make.width.equalTo(@60);
        make.height.equalTo(@9);
    }];
    
    _lblScore = [UILabel new];
    _lblScore.textColor = UIColorFromRGB(0x868686);
//    _lblScore.text = @"爱现场评分";
    _lblScore.font = FONT11;
    [_mainView addSubview:_lblScore];
    [_lblScore makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scoreView.mas_right).offset(5);
        make.centerY.equalTo(tip1);
    }];
    
    _lblDirector = [UILabel new];
    _lblDirector.font = FONT11;
    _lblDirector.text = @"导演:";
    _lblDirector.textColor = UIColorFromRGB(0x868686);
    [_mainView addSubview:_lblDirector];
    [_lblDirector makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tip1);
        make.top.equalTo(tip1.mas_bottom).offset(2);
    }];
    
    _lblAddress = [UILabel new];
    _lblAddress.font = FONT11;
    _lblAddress.textColor = UIColorFromRGB(0x868686);
    _lblAddress.text = @"演出地址:";
    [_mainView addSubview:_lblAddress];
    [_lblAddress makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblTitle);
        make.top.equalTo(_lblDirector.mas_bottom);
    }];
    
    _lblActDate = [UILabel new];
    _lblActDate.font = FONT11;
    _lblActDate.text = @"演出时间:";
    _lblActDate.textColor = UIColorFromRGB(0x868686);
    [_mainView addSubview:_lblActDate];
    [_lblActDate makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblTitle);
        make.top.equalTo(_lblAddress.mas_bottom);
    }];
    
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button1.titleLabel.font = FONT14;
    [_button1 setTitle:@"看过" forState:UIControlStateNormal];
    [_button1 setTitleColor:UIColorFromRGB(0x868686) forState:UIControlStateNormal];
    [_button1 setImage:[UIImage imageNamed:@"detail_icon3"] forState:UIControlStateNormal];
    [_button1 setBackgroundImage:[[Common imageWithColor:UIColorFromRGB(0xffc785) cornerRadius:3.0f] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)] forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(showAddCommentView:) forControlEvents:UIControlEventTouchUpInside];
    _button1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [_mainView addSubview:_button1];
    [_button1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView).offset(40);
        make.top.equalTo(_lblActDate.mas_bottom).offset(20);
        make.width.equalTo(@110);
        make.height.equalTo(@30);
    }];
    
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button2.titleLabel.font = FONT14;
    [_button2 setTitle:@"想看" forState:UIControlStateNormal];
    [_button2 setTitleColor:UIColorFromRGB(0x868686) forState:UIControlStateNormal];
    [_button2 setImage:[UIImage imageNamed:@"detail_icon4"] forState:UIControlStateNormal];
    [_button2 setBackgroundImage:[[Common imageWithColor:UIColorFromRGB(0xffc785) cornerRadius:3.0f] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)] forState:UIControlStateNormal];
    [_button2 addTarget:self action:@selector(want:) forControlEvents:UIControlEventTouchUpInside];
    _button2.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [_mainView addSubview:_button2];
    [_button2 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_mainView).offset(-40);
        make.top.equalTo(_lblActDate.mas_bottom).offset(20);
        make.width.equalTo(@110);
        make.height.equalTo(@30);
    }];
    
    UIView *bar1 = [UIView new];
    bar1.backgroundColor = [UIColor clearColor];
    bar1.userInteractionEnabled = YES;
    [bar1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showActWeb:)]];
    [_mainView addSubview:bar1];
    [bar1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(_button2.mas_bottom).offset(20);
        make.height.equalTo(@40);
    }];
    
    UIView *bar2 = [UIView new];
    bar2.backgroundColor = [UIColor clearColor];
    bar2.userInteractionEnabled = YES;
    [bar2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDescribe:)]];
    [_mainView addSubview:bar2];
    [bar2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(bar1.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    UIImageView *icon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_icon1"]];
    icon1.contentMode = UIViewContentModeScaleAspectFit;
    [bar1 addSubview:icon1];
    [icon1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bar1).offset(20);
        make.top.equalTo(bar1.mas_top);
        make.width.equalTo(@10);
        make.height.equalTo(@15);
    }];
    
    UIImageView *icon11 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow_gray"]];
    [bar1 addSubview:icon11];
    [icon11 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bar1).offset(-20);
        make.centerY.equalTo(icon1);
    }];
    
    _lblTitle2 = [UILabel new];
    _lblTitle2.font = FONT9;
    _lblTitle2.textColor = UIColorFromRGB(0x868686);
    [bar1 addSubview:_lblTitle2];
    [_lblTitle2 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(icon11.mas_left).offset(-20);
        make.centerY.equalTo(icon11);
    }];
    
    UILabel *label1 = [UILabel new];
    label1.font = FONT14;
    label1.text = @"活动";
    label1.textColor = TextColor;
    [bar1 addSubview:label1];
    [label1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon1.mas_right).offset(10);
        make.centerY.equalTo(icon1);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = UIColorFromRGB(0xbebebe);
    [bar1 addSubview:line1];
    [line1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon1);
        make.right.equalTo(icon11);
        make.top.equalTo(icon1.mas_bottom).offset(5);
        make.height.equalTo(@1);
    }];
    
    UIImageView *icon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_icon2"]];
    icon2.contentMode = UIViewContentModeScaleAspectFit;
    [bar2 addSubview:icon2];
    [icon2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bar2).offset(20);
        make.top.equalTo(bar2);
        make.width.equalTo(@10);
        make.height.equalTo(@15);
    }];
    
    UIImageView *icon2_1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow_gray"]];
    icon2_1.transform = CGAffineTransformMakeRotation(M_PI / 2);
    icon2_1.tag = 222;
    [bar2 addSubview:icon2_1];
    [icon2_1 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bar2).offset(-20);
        make.centerY.equalTo(icon2);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.font = FONT14;
    label2.text = @"简介";
    label2.textColor = TextColor;
    [bar2 addSubview:label2];
    [label2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon2.mas_right).offset(10);
        make.centerY.equalTo(icon2);
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = UIColorFromRGB(0xbebebe);
    [bar2 addSubview:line2];
    [line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon2);
        make.right.equalTo(icon2_1);
        make.top.equalTo(icon2.mas_bottom).offset(5);
        make.height.equalTo(@1);
    }];
    
    _lblDescribe = [UILabel new];
    _lblDescribe.font = FONT12;
    _lblDescribe.textColor = TextColor;
    _lblDescribe.numberOfLines = 0;
    describeExpand = YES;
    [_mainView addSubview:_lblDescribe];
    [_lblDescribe makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bar2.mas_bottom).offset(2);
        make.left.equalTo(line2);
        make.right.equalTo(line2);
    }];
    
    [_mainView addSubview:self.introductionView];
    [self.introductionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblDescribe.mas_bottom);
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
    }];
    
    _lblStillTip = [UILabel new];
    _lblStillTip.text = @"预告片/剧照";
    _lblStillTip.font = FONT11;
    _lblStillTip.textColor = UIColorFromRGB(0x868686);
    _lblStillTip.layer.masksToBounds = YES;
    [_mainView addSubview:_lblStillTip];
    [_lblStillTip makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView).offset(20);
        make.top.equalTo(_introductionView.mas_bottom);
        make.height.equalTo(@15);
    }];
    
    _stills = [[StillsScrolll alloc] init];
    _stills.stills = @[];
    _stills.layer.masksToBounds = YES;
    [_mainView addSubview:_stills];
    [_stills makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(_lblStillTip.mas_bottom).offset(10);
        make.height.equalTo(@0);
    }];
    
    [_mainView addSubview:self.commentsView];
    [_commentsView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainView);
        make.right.equalTo(_mainView);
        make.top.equalTo(_stills.mas_bottom);
        make.height.equalTo(@(90 * _comments.count + 70));
    }];
    
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        buttomConstraint = make.bottom.equalTo(_commentsView.mas_bottom);
    }];
    
}

- (UIView *)introductionView
{
    if (_introductionView) {
        return _introductionView;
    }
    _introductionView = [UIView new];
    
    recMan = [UILabel new];
    recMan.textColor = UIColorFromRGB(0x868686);
    recMan.text = @"";
    recMan.font = FONT11;
    [_introductionView addSubview:recMan];
    [recMan makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_introductionView).offset(20);
        make.top.equalTo(_introductionView).offset(10);
    }];
    
    authorAvatar = [[UIImageView alloc] init];
    authorAvatar.layer.cornerRadius = 3.0f;
    authorAvatar.layer.borderColor = UIColorFromRGB(0x868686).CGColor;
    authorAvatar.layer.borderWidth = 1.0f;
    authorAvatar.layer.masksToBounds = YES;
//    authorAvatar.image = [UIImage imageNamed:@"16"];
    [_introductionView addSubview:authorAvatar];
    [authorAvatar makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recMan);
        make.top.equalTo(recMan.mas_bottom).offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    authorName = [UILabel new];
    authorName.text = @"作者:";
    authorName.textColor = TextColor;
    authorName.font = FONT11;
    [_introductionView addSubview:authorName];
    [authorName makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(authorAvatar.mas_right).offset(10);
        make.top.equalTo(authorAvatar);
    }];
    
    recDesc = [UILabel new];
    recDesc.textColor = TextColor;
    recDesc.text = @"简介:";
    recDesc.font = FONT11;
    recDesc.numberOfLines = 2;
    [_introductionView addSubview:recDesc];
    [recDesc makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(authorName);
        make.right.equalTo(_introductionView.mas_right).offset(-20);
        make.top.equalTo(authorName.mas_bottom).offset(2);
    }];
    
    publisher = [UILabel new];
    publisher.text = @"本文由爱现场工作室出品";
    publisher.textColor = UIColorFromRGB(0x868686);
    publisher.font = FONT10;
    [_introductionView addSubview:publisher];
    [publisher makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_introductionView).offset(-20);
        make.top.equalTo(authorAvatar.mas_bottom);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0x868686);
    [_introductionView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(authorAvatar);
        make.right.equalTo(publisher);
        make.top.equalTo(publisher.mas_bottom).offset(2);
        make.height.equalTo(@1);
    }];
    
    content = [UILabel new];
    content.textColor = TextColor;
    content.font = FONT12;
    content.numberOfLines = 2;
    content.userInteractionEnabled = YES;
    [content  addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandContent:)]];
    [_introductionView addSubview:content];
    [content makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_introductionView).offset(20);
        make.right.equalTo(_introductionView).offset(-20);
        make.top.equalTo(line).offset(10);
//        make.bottom.equalTo(_introductionView);
    }];
    
    contentExp = [UILabel new];
    contentExp.textColor = [UIColor blueColor];
    contentExp.text = @"展开";
    contentExp.font = FONT12;
    contentExp.textAlignment = NSTextAlignmentCenter;
    contentExp.userInteractionEnabled = YES;
    [contentExp addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandContent:)]];
    [_introductionView addSubview:contentExp];
    [contentExp makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(content.mas_bottom).offset(2);
        make.left.equalTo(_introductionView);
        make.right.equalTo(_introductionView);
        make.bottom.equalTo(_introductionView);
    }];
    
    return _introductionView;
}

- (UIView *)commentsView
{
    if (_commentsView) return _commentsView;
    _commentsView = [[UIView alloc] init];
    _commentsView.layer.masksToBounds = YES;
    
    UILabel *label = [UILabel new];
    label.text = @"评论";
    label.font = FONT11;
    label.textColor = UIColorFromRGB(0x868686);
    [_commentsView addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentsView).offset(10);
        make.left.equalTo(_commentsView).offset(20);
    }];
    
//    for (int i = 0; i < 10; i++) {
//        CommentView *comment = [[CommentView alloc] init];
//        comment.frame = CGRectMake(0, 30 + 90 * i, 320, 90);
//        comment.model = nil;
//        [_commentsView addSubview:comment];
//    }
    
    UIView *view = [UIView new];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadMoreComment:)]];
    [_commentsView addSubview:view];
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_commentsView);
        make.bottom.equalTo(_commentsView);
        make.right.equalTo(_commentsView);
        make.height.equalTo(@40);
    }];
    
    UILabel *more = [UILabel new];
    more.font = FONT12;
    more.textColor = [UIColor blueColor];
    more.text = @"查看更多评论";
    [_commentsView addSubview:more];
    [more makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    
    return _commentsView;
}

- (void)reloadCommentView
{
    for (UIView *view in _commentsView.subviews) {
        if ([view isKindOfClass:[CommentView class]])
            [view removeFromSuperview];
    }
    for (int i = 0; i < _comments.count; i++) {
        CommentModel *model = _comments[i];
        CommentView *comment = [[CommentView alloc] init];
        comment.frame = CGRectMake(0, 30 + 90 * i, 320, 90);
        comment.model = model;
        comment.tag = i;
        comment.userInteractionEnabled = YES;
        [comment addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zan:)]];
        [_commentsView addSubview:comment];
    }
    if (!_comments.count) {
        [_commentsView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }else {
        [_commentsView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(90 * _comments.count + 70));
        }];
    }
}

- (void)reloadData
{
    [_imageView sd_setImageWithURL:_model.topic completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        float quality = .00001f;
        float blurred = .5f;
        CGRect rect = CGRectMake(0, 100, 250, 125);
        
        NSData *imageData = UIImageJPEGRepresentation([image croppIngimageByImageName:image toRect:rect], quality);
        UIImage *blurredImage = [[UIImage imageWithData:imageData] blurredImage:blurred];
        _imageBack.image = blurredImage;
    }];
    
    _lblTitle.text = _model.title;
    _scoreView.score = _model.star.integerValue / 2;
    _lblScore.text = [NSString stringWithFormat:@"%.1f分",_model.star.intValue / 2.0f];
    _lblDirector.text = [NSString stringWithFormat:@"导演: %@ 主演:%@",_model.director,_model.actor];
    _lblAddress.text = [NSString stringWithFormat:@"演出地址: %@",_model.addr];
    _lblActDate.text = [NSString stringWithFormat:@"演出时间: %@",_model.showtime];
    
    _lblTitle2.text = _model.campaignDesc;
    
    recMan.text = _model.recMan;
    [authorAvatar sd_setImageWithURL:_model.recPicUrl];
    authorName.text = [NSString stringWithFormat:@"作者:%@", _model.recAuthor];
    recDesc.text = [NSString stringWithFormat:@"简介:%@", _model.recDesc];
    publisher.text = _model.recProducer;
    
    _lblDescribe.text = _model.describe;
    
    if (_model.content) {
        content.text = _model.content;
        content.hidden = NO;
        contentExp.hidden = NO;
    }else {
        content.hidden = YES;
        contentExp.hidden = YES;
    }
    
    if (_model.isShowBtn)
        _button2.hidden = NO;
    else
        _button2.hidden = YES;
    if (_model.btnType)
        [_button2 setTitle:_model.btnType forState:UIControlStateNormal];
    else
        [_button2 setTitle:@"想看" forState:UIControlStateNormal];
    
    if (_model.storyUrls.count) {
        [_stills updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@125);
        }];
        [_lblStillTip updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
        }];
    }else {
        [_stills updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        [_lblStillTip updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    
    [self reloadCommentView];
}

- (void)expandContent:(UITapGestureRecognizer*)tap
{
    if (contentExpand) {
        content.numberOfLines = 2;
        contentExp.text = @"展开";
    }else {
        content.numberOfLines = 0;
        contentExp.text = @"收起";
    }
    contentExpand = !contentExpand;
    
    [_mainView setNeedsLayout];
    [_mainView layoutIfNeeded];
}

- (void)showDescribe:(UITapGestureRecognizer*)tap
{
    UIImageView *icon = (UIImageView *)[_mainView viewWithTag:222];
    if (describeExpand) {
        _lblDescribe.text = @"";
        icon.transform = CGAffineTransformMakeRotation(0);
    }else {
        _lblDescribe.text = _model.describe;
        icon.transform = CGAffineTransformMakeRotation(M_PI / 2);
    }
    describeExpand = !describeExpand;
    [_mainView setNeedsLayout];
    [_mainView layoutIfNeeded];
}

- (void)loadMoreComment:(UITapGestureRecognizer*)tap
{
    [self doRequestComments];
}

- (void)zan:(UITapGestureRecognizer*)tap
{
    if (!ApplicationDelegate.token) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    NSInteger idx = tap.view.tag;
    CommentView *view = (CommentView*)tap.view;
    CommentModel *model = _comments[idx];
    [ApplicationDelegate.defaultEngine postDataByURL:CommentGood params:@{@"commentid":model.commentId,@"userid":ApplicationDelegate.loginUser?ApplicationDelegate.loginUser.userId:@""} complete:^(NSDictionary *responseObject, NSError *error) {
        if (error) return ;
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            model.goodNum = @(model.goodNum.intValue + 1);
            view.model = model;
        }
    }];
}

- (void)share:(id)sender
{
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://live.linking5.com/Html/events/neiye.html?newsId=%@",_model.newsId];
    [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://live.linking5.com/Html/events/neiye.html?newsId=%@",_model.newsId];
    [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMAppKey
                                      shareText:_model.title
                                     shareImage:_imageView.image
                                shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession]
                                       delegate:self];
}

- (void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    UMSocialUrlResource *resource = [[UMSocialUrlResource alloc] init];
    resource.url = [NSString stringWithFormat:@"http://live.linking5.com/Html/events/neiye.html?newsId=%@",_model.newsId];
    socialData.urlResource = resource;
}

- (void)showAddCommentView:(id)sender
{
    if (!ApplicationDelegate.token) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    AddCommentController *vc = [[AddCommentController alloc] init];
    vc.model = _model;
    [self.navigationController pushViewController:vc animated:YES];
//    HtmlPageViewController *webPage = [[HtmlPageViewController alloc] init];
//    webPage.url = [NSString stringWithFormat:@"http://%@%@?userid=%@&newis=%@",HOSTADDRESS,GoComment,ApplicationDelegate.loginUser.userId,_model.newsId];
//    [self.navigationController pushViewController:webPage animated:YES];
}

- (void)want:(id)sender
{
    HtmlPageViewController *webPage = [[HtmlPageViewController alloc] init];
    webPage.url = [NSString stringWithFormat:@"http://%@",_model.url];
    [self.navigationController pushViewController:webPage animated:YES];
}

- (void)showActWeb:(id)sender
{
    HtmlPageViewController *webPage = [[HtmlPageViewController alloc] init];
    webPage.url = [NSString stringWithFormat:@"http://%@",_model.url];
    [self.navigationController pushViewController:webPage animated:YES];
}

- (void)setModel:(NewsModel *)model
{
    _model = model;
    [self doRequestActDetail];
}

- (void)setNnewsid:(NSInteger)nnewsid
{
    _nnewsid = nnewsid;
    [self doRequestActDetail];
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doRequestActDetail
{
    NSDictionary *param = _model?@{@"id":_model.newsId}:@{@"id":@(_nnewsid)};
    [ApplicationDelegate.defaultEngine getDataByURL:GetNewsDetail params:param complete:^(NSDictionary *responseObject, NSError *error) {
        if (error)
        {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
            return ;
        }
        if ([responseObject[RESPONSE_CODE] integerValue] == 0) {
            _model = [MTLJSONAdapter modelOfClass:[NewsModel class] fromJSONDictionary:responseObject[RESPONSE_RESULT] error:nil];
            NSArray *comments = [responseObject objectForKey:@"comment_result"];
            for (NSDictionary *dict in comments) {
                CommentModel *model = [MTLJSONAdapter modelOfClass:[CommentModel class] fromJSONDictionary:dict error:nil];
                [_comments addObject:model];
            }
            [self reloadData];
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
    }];
}

- (void)doRequestComments
{
    NSDictionary *param = @{@"page":@(++currentPage),
                            @"size":@(PageSize)};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApplicationDelegate.defaultEngine getDataByURL:GetComment params:param complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:error.description continueTime:1.0f];
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            for (NSDictionary *dict in responseObject[RESPONSE_RESULT]) {
                CommentModel *model = [MTLJSONAdapter modelOfClass:[CommentModel class] fromJSONDictionary:dict error:nil];
                [_comments addObject:model];
            }
            if ([responseObject[RESPONSE_RESULT] count]) {
                [self reloadCommentView];
            }else {
                --currentPage;
                [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"没有更多评论了!" continueTime:1.0f];
            }
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
    }];
}

#pragma UMSocialUIDelegate
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    
}

@end
