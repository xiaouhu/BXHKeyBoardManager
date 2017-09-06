//
//  UIView+BXHKeyBoard.h
//  BXHKeyBoardManager
//
//  Created by 步晓虎 on 2017/9/5.
//  Copyright © 2017年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BXHKeyBoard)

//默认是10
@property (nonatomic, assign) CGFloat keyboardDistanceFromTextField;

@property (nonatomic, assign) CGRect bxh_orgrinFrame;

- (void)bxh_registToKeyBoardManager;

- (void)bxh_unregistToKeyBoardManager;

@end
