//
//  UIView+BXHKeyBoard.m
//  BXHKeyBoardManager
//
//  Created by 步晓虎 on 2017/9/5.
//  Copyright © 2017年 步晓虎. All rights reserved.
//

#import "UIView+BXHKeyBoard.h"
#import "BXHKeyBoardManager.h"
#import <objc/runtime.h>

static int kBXH_KTDistance;
static int kBXH_OrgrinFrame;

@implementation UIView (BXHKeyBoard)

- (CGFloat)keyboardDistanceFromTextField
{
    NSNumber *number = objc_getAssociatedObject(self, &kBXH_KTDistance);
    if (!number)
    {
        return 10;
    }
    return [number floatValue];
}

- (void)setKeyboardDistanceFromTextField:(CGFloat)keyboardDistanceFromTextField
{
    objc_setAssociatedObject(self, &kBXH_KTDistance, [NSNumber numberWithFloat:keyboardDistanceFromTextField], OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)bxh_orgrinFrame
{
    return [objc_getAssociatedObject(self, &kBXH_OrgrinFrame) CGRectValue];
}

- (void)setBxh_orgrinFrame:(CGRect)bxh_orgrinFrame
{
    objc_setAssociatedObject(self, &kBXH_OrgrinFrame, [NSValue valueWithCGRect:bxh_orgrinFrame], OBJC_ASSOCIATION_RETAIN);
}

- (void)bxh_registToKeyBoardManager
{
    [[BXHKeyBoardManager shareInstance] addRegistView:self];
}

- (void)bxh_unregistToKeyBoardManager
{
    [[BXHKeyBoardManager shareInstance] removeRegistView:self];
}
@end
