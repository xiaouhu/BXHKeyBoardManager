//
//  BXHInputAccessoryView.m
//  BXHKeyBoardManager
//
//  Created by 步晓虎 on 2017/9/5.
//  Copyright © 2017年 步晓虎. All rights reserved.
//

#import "BXHInputAccessoryView.h"

@implementation BXHInputAccessoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:0.98]];
        
        NSBundle *sourceBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"BXHKeyBoardBundle" ofType:@"bundle"]];
        
        [self.doneBtn setImage:[UIImage imageNamed:@"BXHButtonBarArrowDown" inBundle:sourceBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [self.preBtn setImage:[UIImage imageNamed:@"BXHButtonBarArrowLeft" inBundle:sourceBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [self.nextBtn setImage:[UIImage imageNamed:@"BXHButtonBarArrowRight" inBundle:sourceBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        
        [self addSubview:self.doneBtn];
        [self addSubview:self.preBtn];
        [self addSubview:self.nextBtn];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews
{
    self.doneBtn.frame = CGRectMake(self.frame.size.width - 40, 0, 30, self.frame.size.height);
    self.preBtn.frame = CGRectMake(10, 0, 30, self.frame.size.height);
    self.nextBtn.frame = CGRectMake(CGRectGetMaxX(self.preBtn.frame) + 5, 0, 30, self.frame.size.height);
}

#pragma mark - lazyLoad
- (UIButton *)doneBtn
{
    if (!_doneBtn)
    {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _doneBtn;
}

- (UIButton *)preBtn
{
    if (!_preBtn)
    {
        _preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _preBtn;
}

- (UIButton *)nextBtn
{
    if (!_nextBtn)
    {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _nextBtn;
}


@end
