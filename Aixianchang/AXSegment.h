//
//  AXSegment.h
//  Aixianchang
//
//  Created by zhangliugang on 14/12/28.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SegmentSelctBlock)(NSInteger selectIndex);

@interface AXSegment : UIView

@property (strong, nonatomic) NSArray *titles;
@property (copy, nonatomic) SegmentSelctBlock selectBlock;

@end
