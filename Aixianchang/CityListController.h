//
//  CityListController.h
//  Aixianchang
//
//  Created by zhangliugang on 15/1/9.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityLsitDelegate <NSObject>

@required
- (void)didSelectCity:(NSString*)city;

@end

@interface CityListController : UIViewController
@property (assign, nonatomic) id<CityLsitDelegate> delegate;
@end
