//
//  UINavigationBar+CustomHeight.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/19.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "UINavigationBar+CustomHeight.h"
#import "objc/runtime.h"

static char const *const heightKey = "Height";

@implementation UINavigationBar (CustomHeight)

- (void)setHeight:(CGFloat)height
{
    objc_setAssociatedObject(self, heightKey, @(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)height
{
    return objc_getAssociatedObject(self, heightKey);
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize newSize;
    
    if (objc_getAssociatedObject(self, heightKey)) {
        newSize = CGSizeMake(self.superview.bounds.size.width, [objc_getAssociatedObject(self, heightKey) floatValue]);
    } else {
        newSize = [super sizeThatFits:size];
    }
    
    return newSize;
}

@end
