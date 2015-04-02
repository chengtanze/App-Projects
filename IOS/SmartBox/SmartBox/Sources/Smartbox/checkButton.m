//
//  checkButton.m
//  Smartbox
//
//  Created by Mesada on 15/3/6.
//  Copyright (c) 2015年 mesada. All rights reserved.
//
//bobo 自定义 类似checkbox控件
#import "checkButton.h"

@implementation checkButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setIsSelect:(BOOL)isSelect
{
    if (isSelect) {
        if (_SelectImageName)
        [self setImage:[UIImage imageNamed: _SelectImageName] forState:UIControlStateNormal];
    }
    else{
        if (_NormalImageName)
        [self setImage:[UIImage imageNamed: _NormalImageName] forState:UIControlStateNormal];
    }
}
@end
