//
//  AddressModel.h
//  Aixianchang
//
//  Created by zhangliugang on 15/1/7.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface AddressModel : MTLModel <MTLJSONSerializing>
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *linkMan;
@property (strong, nonatomic) NSString *linkPhone;
@property (strong, nonatomic) NSString *province;//省
@property (strong, nonatomic) NSString *city;//市
@property (strong, nonatomic) NSString *area;//区
@property (strong, nonatomic) NSString *addr;//详细
@end
