//
//  ScrollViewTextFiledViewController.m
//  BXHKeyBoardManager
//
//  Created by 步晓虎 on 2017/9/6.
//  Copyright © 2017年 步晓虎. All rights reserved.
//

#import "ScrollViewTextFiledViewController.h"
#import "UIView+BXHKeyBoard.h"
#import "UIResponder+BXHKeyBoardResponder.h"

@interface ScrollViewTextFiledViewController ()

@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation ScrollViewTextFiledViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ScrollViewKeyBoard";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentScrollView];
    
    UITextField *topTextFiled = nil;
    CGRect frame = [UIScreen mainScreen].bounds;
    for (int i = 0; i < 10; i ++)
    {
        UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(10, 50 + 40 * i , frame.size.width - 20, 30)];
        textFiled.bxh_preResonder = topTextFiled;
        textFiled.backgroundColor = [UIColor redColor];
        [textFiled bxh_showAccessoryView];
        [self.contentScrollView addSubview:textFiled];
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
    [self.contentScrollView bxh_registToKeyBoardManager];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.contentScrollView bxh_unregistToKeyBoardManager];
}


#pragma mark - lazyLoad
- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView)
    {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
    }
    return _contentScrollView;
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
