//
//  AddCommentController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/2/17.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "AddCommentController.h"
#import "ScoreView.h"
#import "UMSocial.h"

@interface AddCommentController () <UITextViewDelegate, UMSocialUIDelegate>
{
    UIImageView *shareImage;
    BOOL shareToWX;
}
@property (strong, nonatomic) ScoreView *scoreView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *commitBtn;
@end

@implementation AddCommentController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    self.title = @"评论";
    
    _scoreView = [[ScoreView alloc] init];
    _scoreView.userInteractionEnabled = YES;
    _scoreView.score = 0;
    [_scoreView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scoreViewClicked:)]];
    [self.view addSubview:_scoreView];
    [_scoreView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@230);
        make.height.equalTo(@35);
    }];
    
    _textView = [[UITextView alloc] init];
    _textView.layer.borderColor = UIColorFromRGB(0xbebebe).CGColor;
    _textView.layer.borderWidth = 1.0f;
    _textView.delegate = self;
    [self.view addSubview:_textView];
    [_textView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(_scoreView.mas_bottom).offset(20);
        make.height.equalTo(@130);
    }];
    
    
    UILabel *tip = [UILabel new];
    tip.text = @"同步到";
    tip.textColor = TextColor;
    tip.font = FONT13;
//    [self.view addSubview:tip];
//    [tip makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(20);
//        make.top.equalTo(_textView.mas_bottom).offset(20);
//    }];
    
    shareImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wx2"]];
    shareImage.userInteractionEnabled = YES;
    [shareImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeShareState:)]];
//    [self.view addSubview:shareImage];
//    [shareImage makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(tip.mas_right).offset(10);
//        make.centerY.equalTo(tip);
//        make.width.equalTo(@24);
//        make.height.equalTo(@24);
//    }];
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_commitBtn addTarget:self action:@selector(commitComment:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitBtn];
    [_commitBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(tip);
        make.top.equalTo(_textView.mas_bottom).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
}

- (void)scoreViewClicked:(UITapGestureRecognizer*)tap
{
    CGPoint point = [tap locationInView:tap.view];
    _scoreView.score = point.x / _scoreView.bounds.size.width * 5 + 1;
}

- (void)changeShareState:(id)sender
{
    if (shareToWX) {
        shareToWX = NO;
        shareImage.image = [UIImage imageNamed:@"wx2"];
    }else {
        shareToWX = YES;
        shareImage.image = [UIImage imageNamed:@"wx1"];
    }
}

- (void)commitComment:(id)sender
{
    [_textView resignFirstResponder];
    
    NSDictionary  *param = @{@"token":ApplicationDelegate.token,
                             @"newsId":_model.newsId,
                             @"content":_textView.text,
                             @"grade":@(_scoreView.score * 2),
                             @"isshare":shareToWX?@1:@0};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApplicationDelegate.defaultEngine postDataByURL:PubComment params:param complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:error.description continueTime:1.0f];
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
//            if (shareToWX) {
//                [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://live.linking5.com/Html/events/neiye.html?newsId=%@",_model.newsId];
//                [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
//                [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://live.linking5.com/Html/events/neiye.html?newsId=%@",_model.newsId];
//                [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
//                [UMSocialSnsService presentSnsIconSheetView:self
//                                                     appKey:UMAppKey
//                                                  shareText:_textView.text
//                                                 shareImage:nil
//                                            shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession]
//                                                   delegate:self];
//            }else
//            {
                [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"评论发表成功" continueTime:1.0f];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
//            }
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
