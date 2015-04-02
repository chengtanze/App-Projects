//
//  UIIconTabBar.m
//  Smartbox
//
//  Created by Mesada on 14-10-17.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "UIIconTabBar.h"

@implementation UIIconTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//    UIColor *selectColor = [ UIColor colorWithRed: 0.41
//                                            green: 0.42
//                                             blue: 0.92
//                                            alpha: 1.0
//                            ];
//    UIImageView* Icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 16, 16)];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIImage *image = [UIImage imageNamed:@"1.png"];
    CGContextDrawImage(ctx, rect, image.CGImage);
}
@end
