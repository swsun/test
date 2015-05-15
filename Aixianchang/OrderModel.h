//
//  OrderModel.h
//  Aixianchang
//
//  Created by zhangliugang on 15/1/7.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OrderModel : MTLModel <MTLJSONSerializing>
@property (strong, nonatomic) NSString *orderId;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *addressId;
@property (strong, nonatomic) NSNumber *totalNum;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSNumber *discount;
@property (strong, nonatomic) NSNumber *status;
@end
