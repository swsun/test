//
//  CustomWebView.h
//  ymatou
//
//  Created by 草泥马 on 14-8-29.
//  Copyright (c) 2014年 草泥马. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "EGORefreshTableHeaderView.h"
//#import "SocialShareView.h"

@protocol CustomWebViewDelegate

@optional
-(BOOL)PushViewController:(NSString*)url;
- (void)FinshLoad:(BOOL)HasError;
@end


@interface CustomWebView : UIView<UIWebViewDelegate,UIScrollViewDelegate>

@property(strong,nonatomic) UIWebView * webView;
@property(strong,nonatomic) NSString * urlStr;
//@property(strong,nonatomic) EGORefreshTableHeaderView * refreshHeaderView;
@property(weak,nonatomic) id<CustomWebViewDelegate> delegate;
@property(weak,nonatomic) UIViewController *parentController;

//- (id)initWithFrame:(CGRect)frame  andDelegate:(id)delegate;
- (void)StartLoadPage;
@end

