//
//  ViewController.m
//  BXHKeyBoardManager
//
//  Created by 步晓虎 on 2017/9/5.
//  Copyright © 2017年 步晓虎. All rights reserved.
//

#import "ViewController.h"
#import "ScrollViewTextFiledViewController.h"
#import "ViewTextFiledViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if ([touch locationInView:self.view].y > self.view.frame.size.height / 2)
    {
        ScrollViewTextFiledViewController *vc = [[ScrollViewTextFiledViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        ViewTextFiledViewController *vc = [[ViewTextFiledViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
