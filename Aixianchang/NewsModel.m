//
//  NewsModel.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/8.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (NSArray *)NewsCategoryNames
{
    static NSArray *_NewsCategoryNames;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _NewsCategoryNames = @[@"舞台剧",@"赛事",@"活动",@"展览",@"音乐剧",@"liveshow",@"音乐会",@"所有"];
    });
    return _NewsCategoryNames;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"newsId":@"id",
             @"describe":@"description"};
}

+ (NSValueTransformer *)categoryJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                           @"1": @(NewsCategory1),
                           @"2": @(NewsCategory2),
                           @"3": @(NewsCategory3),
                           @"4": @(NewsCategory4),
                           @"5": @(NewsCategory5),
                           @"6": @(NewsCategory6),
                           @"7": @(NewsCategory7),
                           @"8": @(NewsCategory8),
                           }];
}

+ (NSValueTransformer *)isfreeJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)isShowBtnJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)stagePictureJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)bigPictureJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)smallPictureJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)authorPictureJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)recPicUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)topicJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)compaignUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (void)setNilValueForKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
