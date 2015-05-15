//
//  MessageModel.h
//  Aixianchang
//
//  Created by zhangliugang on 15/1/7.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "MTLModel.h"

@interface MessageModel : MTLModel
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *sender;
@property (strong, nonatomic) NSString *senderPicture;
@property (strong, nonatomic) NSString *stauts;
@end
