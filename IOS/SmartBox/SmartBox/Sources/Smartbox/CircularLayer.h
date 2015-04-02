//
//  CircularLayer.h
//  Smartbox
//
//  Created by Mesada on 15/1/13.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CircularLayer : CAShapeLayer
@property (nonatomic) CGPoint arcCenter;
@property (nonatomic) float radius;
@property (nonatomic) float endAngle;
-(void)setLevel:(int)nlevel;
@end
