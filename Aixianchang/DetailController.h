//
//  DetailController.h
//  Aixianchang
//
//  Created by zhangliugang on 15/1/20.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

@interface DetailController : UIViewController
@property (strong, nonatomic) NewsModel *model;
@property (assign, nonatomic) NSInteger nnewsid;
@end
