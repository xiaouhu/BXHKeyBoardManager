//
//  ViewTextFiledViewController.m
//  BXHKeyBoardManager
//
//  Created by 步晓虎 on 2017/9/6.
//  Copyright © 2017年 步晓虎. All rights reserved.
//

#import "ViewTextFiledViewController.h"
#import "UIView+BXHKeyBoard.h"
#import "UIResponder+BXHKeyBoardResponder.h"

@interface ViewTextFiledViewController ()

@end

@implementation ViewTextFiledViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"ViewKeyBoard";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *topTextFiled = nil;
    CGRect frame = [UIScreen mainScreen].bounds;
    for (int i = 0; i < 10; i ++)
    {
        UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(10, 100 + 40 * i , frame.size.width - 20, 30)];
        textFiled.bxh_preResonder = topTextFiled;
        textFiled.backgroundColor = [UIColor redColor];
        [textFiled bxh_showAccessoryView];
        [self.view addSubview:textFiled];
        if (topTextFiled)
        {
            topTextFiled.bxh_nextResponder = textFiled;
        }
        topTextFiled = textFiled;
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view bxh_registToKeyBoardManager];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view bxh_unregistToKeyBoardManager];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
