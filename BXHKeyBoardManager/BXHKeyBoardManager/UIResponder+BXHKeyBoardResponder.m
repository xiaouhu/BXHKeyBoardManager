//
//  UIResponder+BXHKeyBoardResponder.m
//  BXHKeyBoardManager
//
//  Created by 步晓虎 on 2017/9/5.
//  Copyright © 2017年 步晓虎. All rights reserved.
//

#import "UIResponder+BXHKeyBoardResponder.h"
#import <objc/runtime.h>
#import "BXHInputAccessoryView.h"

static __weak UIResponder *bxh_firstResponder = nil;

static int kBxh_preResponder;
static int kBxh_nextResponder;

@implementation UIResponder (BXHKeyBoardResponder)

+ (void)load
{
    SEL originalSelector = @selector(becomeFirstResponder);
    SEL swizzledSelector = @selector(bxh_becomeFirstResponder);
    [self selector_exchangeImpWithOrginalSelectior:originalSelector AndSwizzledSelector:swizzledSelector];
}

#pragma mark - public
+ (UIResponder *)bxh_FirstResponder
{
    bxh_firstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(bxh_finderFirstReponder) to:nil from:nil forEvent:nil];
    return bxh_firstResponder;
}

- (BOOL)bxh_showAccessoryView
{
    if(!self.inputAccessoryView && [self respondsToSelector:@selector(setInputAccessoryView:)])
    {
        BXHInputAccessoryView *accessoryView = [self accessoryView];
        [self performSelectorOnMainThread:@selector(setInputAccessoryView:) withObject:accessoryView waitUntilDone:YES];
        return YES;
    }
    return NO;
}

#pragma mark - private
- (BOOL)bxh_becomeFirstResponder
{
   BOOL canBecome = [self bxh_becomeFirstResponder];
    if (canBecome && [self respondsToSelector:@selector(inputAccessoryView)])
    {
        if ([self.inputAccessoryView isKindOfClass:[BXHInputAccessoryView class]])
        {
            BXHInputAccessoryView *accessoryView = (BXHInputAccessoryView *)self.inputAccessoryView;
            accessoryView.preBtn.enabled = self.bxh_preResonder;
            accessoryView.nextBtn.enabled = self.bxh_nextResponder;
        }
    }
    return canBecome;
}

- (void)bxh_finderFirstReponder
{
    bxh_firstResponder = self;
}

- (void)preAction
{
    [self.bxh_preResonder becomeFirstResponder];
}

- (void)nextAction
{
    [self.bxh_nextResponder becomeFirstResponder];
}

- (void)doneAction
{
    [self resignFirstResponder];
}

#pragma mark - RunTimeSet/Get

- (void)setBxh_preResonder:(UIResponder *)bxh_preResonder
{
    objc_setAssociatedObject(self, &kBxh_preResponder, bxh_preResonder, OBJC_ASSOCIATION_ASSIGN);
}

- (UIResponder *)bxh_preResonder
{
   return objc_getAssociatedObject(self, &kBxh_preResponder);
}

- (void)setBxh_nextResponder:(UIResponder *)bxh_nextResponder
{
    objc_setAssociatedObject(self, &kBxh_nextResponder, bxh_nextResponder, OBJC_ASSOCIATION_ASSIGN);
}

- (UIResponder *)bxh_nextResponder
{
    return objc_getAssociatedObject(self, &kBxh_nextResponder);
}

- (BXHInputAccessoryView *)accessoryView
{
    BXHInputAccessoryView *view = [[BXHInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    [view.preBtn addTarget:self action:@selector(preAction) forControlEvents:UIControlEventTouchUpInside];
    [view.nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [view.doneBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

#pragma runTime
+ (void)selector_exchangeImpWithOrginalSelectior:(SEL)orginalSelector AndSwizzledSelector:(SEL)swizzledSelector
{
    Method orginalMethod = class_getInstanceMethod(self, orginalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(self, orginalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(orginalMethod), method_getTypeEncoding(orginalMethod));
    }
    else
    {
        method_exchangeImplementations(orginalMethod, swizzledMethod);
    }
}


@end
