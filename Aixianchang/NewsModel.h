//
//  NewsModel.h
//  Aixianchang
//
//  Created by zhangliugang on 15/1/8.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import <Mantle.h>

typedef enum {
    NewsCategoryAll = 0,
    NewsCategory1 = 1, //舞台剧
    NewsCategory2 = 2, //赛事
    NewsCategory3 = 3, //活动
    NewsCategory4 = 4, //展览
    NewsCategory5 = 5, //音乐剧
    NewsCategory6 = 6, //liveshow
    NewsCategory7 = 7, //音乐会
    NewsCategory8 = 8, //所有
}NewsCategory;

typedef enum {
    NewsTypeContent, //内容
    NewsTypeRedirect //跳转
}NewsType;


@interface NewsModel : MTLModel <MTLJSONSerializing>
@property (strong, nonatomic) NSNumber *newsId;
@property (assign, nonatomic) NewsCategory category;
@property (assign, nonatomic) NewsType type; //0-内容, 1-跳转
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *picture;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSURL *authorPicture;
@property (strong, nonatomic) NSString *authorUrl;
@property (strong, nonatomic) NSString *director;
@property (strong, nonatomic) NSString *actor;

@property (strong, nonatomic) NSString *showtime;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

//@property (strong, nonatomic) NSString *startDate;
//@property (strong, nonatomic) NSString *endDate;
@property (strong, nonatomic) NSString *addr;
@property (strong, nonatomic) NSString *keyWords;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *describe;

@property (strong, nonatomic) NSURL *topic;
@property (strong, nonatomic) NSURL *stagePicture;
@property (strong, nonatomic) NSURL *smallPicture;
@property (strong, nonatomic) NSURL *bigPicture;
@property (strong, nonatomic) NSString *storyUrl;
@property (copy, nonatomic) NSURL *campaignUrl;
@property (copy, nonatomic) NSString *campaignDesc;
@property (strong, nonatomic) NSURL *url;
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

@property (strong, nonatomic) NSURL *recPicUrl;
@property (strong, nonatomic) NSString *recAuthor;
@property (strong, nonatomic) NSString *recDesc;
@property (strong, nonatomic) NSString *recProducer;
@property (strong, nonatomic) NSString *referee;
@property (strong, nonatomic) NSString *recMan;
@property (copy, nonatomic) NSString *content;
@property (strong, nonatomic) NSArray *storyUrls;

@property (assign, nonatomic) BOOL isfree;

@property (assign, nonatomic) BOOL isShowBtn;
@property (copy, nonatomic) NSURL *btnUrl;
@property (copy, nonatomic) NSString *btnType;

+ (NSArray *)NewsCategoryNames;
@end
