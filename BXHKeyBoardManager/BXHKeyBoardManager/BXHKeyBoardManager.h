//
//  BXHKeyBoardManager.h
//  BXHKeyBoardManager
//
//  Created by 步晓虎 on 2017/9/5.
//  Copyright © 2017年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXHKeyBoardManager : NSObject

+ (BXHKeyBoardManager *)shareInstance;

- (void)addRegistView:(UIView *)registView;

- (void)removeRegistView:(UIView *)registView;

@end
