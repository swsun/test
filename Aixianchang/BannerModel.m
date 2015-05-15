//
//  BannerModel.m
//  Aixianchang
//
//  Created by zhangliugang on 15/2/4.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{@"bannerId":@"id"};
}

//+ (NSValueTransformer *)bannerIdJSONTransformer {
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}

+ (NSValueTransformer *)typeJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                   @"1": @(BannerTypeWeb),
                                   @"2": @(BannerTypeNews)
                                   }];
}

+ (NSValueTransformer *)contentUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)bannerPicJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (void)setNilValueForKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
