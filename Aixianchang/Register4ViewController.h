//
//  Register4ViewController.h
//  Aixianchang
//
//  Created by zhangliugang on 14/12/29.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register4ViewController : UIViewController
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSDate *birth;
@property (nonatomic, assign) UserSex sex;
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *username;

@end
