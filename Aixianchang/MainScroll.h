//
//  MainScroll.h
//  Aixianchang
//
//  Created by zhangliugang on 15/1/18.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainScrollDelegate ;

@interface MainScroll : UIView
@property (strong, nonatomic) NSArray *models;
@property (assign, nonatomic) id<MainScrollDelegate> delegate;
@end


@protocol MainScrollDelegate <NSObject>

@required
- (void)mainScrollDidSelectAtIndex:(NSInteger)index;

@end