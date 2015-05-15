//
//  CommentModel.h
//  Aixianchang
//
//  Created by zhangliugang on 15/1/22.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CommentModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSNumber *commentId;
@property (nonatomic, copy) NSDate *createDate;
@property (nonatomic, copy) NSDate *updateDate;
@property (nonatomic, copy) NSNumber *newsId;
@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSURL *picture;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *goodNum;
@property (nonatomic, copy) NSNumber *grade;
@property (nonatomic, assign) BOOL isshare;
@end
