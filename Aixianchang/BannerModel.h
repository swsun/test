//
//  BannerModel.h
//  Aixianchang
//
//  Created by zhangliugang on 15/2/4.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import <Mantle/Mantle.h>

typedef enum {
    BannerTypeWeb = 2,
    BannerTypeNews = 1
}BannerType;

@interface BannerModel : MTLModel <MTLJSONSerializing>
@property (copy, nonatomic) NSNumber *bannerId;
@property (assign, nonatomic) BannerType type;
@property (copy, nonatomic) NSNumber *newsId;
@property (copy, nonatomic) NSURL *contentUrl;
@property (copy, nonatomic) NSURL *bannerPic;
@property (copy, nonatomic) NSString *chtext;       //中文
@property (copy, nonatomic) NSString *entext;       //英文
@end
