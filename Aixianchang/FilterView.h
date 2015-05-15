//
//  FilterView.h
//  Aixianchang
//
//  Created by zhangliugang on 15/1/20.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@protocol FilterViewDelegate;

@interface FilterView : UIView
@property (assign, nonatomic) id<FilterViewDelegate> delegate;
@end


@protocol FilterViewDelegate <NSObject>

- (void)filterView:(FilterView*)filterView didSelectCategory:(NewsCategory)category;

@end