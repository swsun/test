//
//  HtmlPageViewController.h
//  ymatou
//
//  Created by 草泥马 on 14-8-29.
//  Copyright (c) 2014年 草泥马. All rights reserved.
//

#import "CustomWebView.h"
//#import "SocialShareView.h"
@interface HtmlPageViewController : UIViewController<CustomWebViewDelegate>
@property(copy,nonatomic) NSString * url;
//@property(copy,nonatomic) NSString *title;

@property(assign,nonatomic) BOOL shareFlag;

@end
