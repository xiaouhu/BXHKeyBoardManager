//
//  BXHKeyBoardManager.m
//  BXHKeyBoardManager
//
//  Created by 步晓虎 on 2017/9/5.
//  Copyright © 2017年 步晓虎. All rights reserved.
//

#import "BXHKeyBoardManager.h"
#import "UIView+BXHKeyBoard.h"
#import "UIScrollView+BXHKeyBoard.h"
#import "UIResponder+BXHKeyBoardResponder.h"

@interface BXHKeyBoardManager ()

@property (nonatomic, strong) NSHashTable *weakTable;

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) NSInteger curve;

@end


@implementation BXHKeyBoardManager

+ (void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self shareInstance];
    });
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self registKeyboardNotification];
    }
    return self;
}


+ (BXHKeyBoardManager *)shareInstance
{
    static dispatch_once_t onceToken;
    static BXHKeyBoardManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[BXHKeyBoardManager alloc] init];
    });
    return manager;
}

#pragma mark - public
- (void)addRegistView:(UIView *)registView
{
    if (![self.weakTable containsObject:registView])
    {
        [self.weakTable addObject:registView];
    }
}

- (void)removeRegistView:(UIView *)registView
{
    if ([self.weakTable containsObject:registView])
    {
        [self.weakTable removeObject:registView];
    }
}

#pragma mark - private
- (void)registKeyboardNotification
{
    //  Registering for keyboard notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (UIView *)getFirstRespondView
{
    for (UIView *registView in self.weakTable)
    {
        if (registView.isFirstResponder)
        {
            return registView;
        }
    }
    return nil;
}

- (void)animateRegistViewToFrame:(CGRect)toFrame registView:(UIView *)registView completion:(void (^ __nullable)(BOOL finished))completion
{
    
    [UIView animateKeyframesWithDuration:self.duration delay:0 options:self.curve animations:^{
        registView.frame = toFrame;
    } completion:completion];
}

- (void)animateRegistScrollViewToOffset:(CGPoint)offset registView:(UIScrollView *)registView
{
    [registView setContentOffset:offset animated:YES];
}


#pragma mark - UIKeyboad Notification methods
/*  UIKeyboardWillShowNotification. */
-(void)keyboardWillShow:(NSNotification*)aNotification
{
    UIResponder *firstResponder = [UIResponder bxh_FirstResponder];
    if (![firstResponder isKindOfClass:[UIView class]])
    {
        return;
    }
    
    UIView *firstResponderView = (UIView *)firstResponder;
    
    //  Getting keyboard animation.
    self.curve = [[aNotification userInfo][UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    //  Getting keyboard animation duration
    self.duration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //  Getting UIKeyboardSize.
    CGRect kbFrame = [[aNotification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect respondWindowFrame = [firstResponderView.superview convertRect:firstResponderView.frame toView:[UIApplication sharedApplication].keyWindow];
    
    
    
    CGFloat preAnimateDistance = kbFrame.origin.y - CGRectGetMaxY(respondWindowFrame);
    for (UIView *registView in self.weakTable)
    {
        CGFloat animateDistance = preAnimateDistance - registView.keyboardDistanceFromTextField;
        if (![registView isKindOfClass:[UIScrollView class]])
        {

            if (CGRectIsEmpty(registView.bxh_orgrinFrame))
            {
                registView.bxh_orgrinFrame = registView.frame;
            }
            CGRect frame = registView.frame;
            if (animateDistance < 0)
            {
                frame.origin.y += animateDistance;
                [self animateRegistViewToFrame:frame registView:registView completion:nil];
            }
            else if (respondWindowFrame.origin.y <= 74)
            {
                frame.origin.y += (74 - respondWindowFrame.origin.y);
                [self animateRegistViewToFrame:frame registView:registView completion:nil];
            }
        }
        else
        {

            UIScrollView *scrollRegistView = (UIScrollView *)registView;
            CGRect respondRegistViewFrame = [firstResponderView.superview convertRect:firstResponderView.frame toView:scrollRegistView];
            if (CGPointEqualToPoint(scrollRegistView.bxh_orgainOffset, CGPointZero))
            {
                scrollRegistView.bxh_orgainOffset = scrollRegistView.contentOffset;
            }
            CGPoint currentOffset = scrollRegistView.contentOffset;
            if (animateDistance < 0)
            {
                currentOffset.y -= animateDistance;
                [self animateRegistScrollViewToOffset:currentOffset registView:scrollRegistView];
            }
            else if (respondRegistViewFrame.origin.y <= 10)
            {
                currentOffset.y -= (respondWindowFrame.origin.y - 10);
                [self animateRegistScrollViewToOffset:currentOffset registView:scrollRegistView];
            }

        }
    }

}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    //  Getting keyboard animation.
    self.curve = [[aNotification userInfo][UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    //  Getting keyboard animation duration
    self.duration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
    for (UIView *registView in self.weakTable)
    {
        if ([registView isKindOfClass:[UIScrollView class]])
        {
            [self animateRegistScrollViewToOffset:[(UIScrollView *)registView bxh_orgainOffset] registView:(UIScrollView *)registView];

        }
        else
        {
            [self animateRegistViewToFrame:registView.bxh_orgrinFrame registView:registView completion:^(BOOL finished) {
                registView.bxh_orgrinFrame = CGRectZero;
            }];
        }
    }
}

#pragma mark - LazyLoad
- (NSHashTable *)weakTable
{
    if (!_weakTable)
    {
        _weakTable = [NSHashTable hashTableWithOptions:NSMapTableWeakMemory];
    }
    return _weakTable;
}


@end
