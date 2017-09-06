//
//  UIResponder+BXHKeyBoardResponder.h
//  BXHKeyBoardManager
//
//  Created by 步晓虎 on 2017/9/5.
//  Copyright © 2017年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (BXHKeyBoardResponder)

@property (nonatomic, weak) UIResponder *bxh_preResonder;

@property (nonatomic, weak) UIResponder *bxh_nextResponder;

+ (UIResponder *)bxh_FirstResponder;

- (BOOL)bxh_showAccessoryView;

@end
