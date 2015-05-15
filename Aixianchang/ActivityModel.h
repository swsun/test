//
//  ActivityModel.h
//  Aixianchang
//
//  Created by zhangliugang on 15/1/7.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "MTLModel.h"

@interface ActivityModel : MTLModel
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *type; //1-内容,2-跳转
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *picture;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *authorPicture;
@property (strong, nonatomic) NSString *authorUrl;
@property (strong, nonatomic) NSString *director;
@property (strong, nonatomic) NSString *actor;
@property (strong, nonatomic) NSString *startDate;
@property (strong, nonatomic) NSString *endDate;
@property (strong, nonatomic) NSString *addr;
@property (strong, nonatomic) NSString *keyWords;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *topic;
@property (strong, nonatomic) NSString *stagePicture;
@property (strong, nonatomic) NSString *smallPicture;
@property (strong, nonatomic) NSString *bigPicture;
@property (strong, nonatomic) NSString *storyUrl;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSNumber *star; //推荐指数 0-10
@property (strong, nonatomic) NSNumber *readNum;
@property (strong, nonatomic) NSNumber *loveNum;
@property (strong, nonatomic) NSNumber *lowNum;
@property (strong, nonatomic) NSNumber *forwardNum;
@property (strong, nonatomic) NSNumber *commentNum;
@property (strong, nonatomic) NSString *top;
@property (strong, nonatomic) NSNumber *status; //1-发布成功, 2-审核中, 3-审核未通过
@property (strong, nonatomic) NSString *createMan;
@property (strong, nonatomic) NSString *updateMan;
@property (strong, nonatomic) NSNumber *totalNum;
@property (strong, nonatomic) NSNumber *leftNum;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSNumber *discount;
@property (strong, nonatomic) NSNumber *discountPrice;
@end
