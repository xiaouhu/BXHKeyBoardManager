//
//  UIScrollView+BXHKeyBoard.m
//  BXHKeyBoardManager
//
//  Created by 步晓虎 on 2017/9/5.
//  Copyright © 2017年 步晓虎. All rights reserved.
//

#import "UIScrollView+BXHKeyBoard.h"
#import <objc/runtime.h>

static int kBXH_orgainOffset;

@implementation UIScrollView (BXHKeyBoard)

- (CGPoint)bxh_orgainOffset
{
    NSValue *value = objc_getAssociatedObject(self, &kBXH_orgainOffset);
    return [value CGPointValue];
}

- (void)setBxh_orgainOffset:(CGPoint)bxh_orgainOffset
{
    objc_setAssociatedObject(self, &kBXH_orgainOffset, [NSValue valueWithCGPoint:bxh_orgainOffset], OBJC_ASSOCIATION_RETAIN);
}

@end
