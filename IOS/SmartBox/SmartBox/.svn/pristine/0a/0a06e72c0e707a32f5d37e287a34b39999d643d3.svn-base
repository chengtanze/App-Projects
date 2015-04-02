//
//  PNBarChart.h
//  PNChartDemo
//
//  Created by bobo on 10/29/14.
//  Copyright (c) 2014年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define chartMargin     10
#define xLabelMargin    15
#define yLabelMargin    15
#define yLabelHeight    11

@interface PNDBarChart : UIView

/**
 * This method will call and troke the line in animation
 */

-(void)setChardata:(NSArray *)data;
- (id)initWithFrame:(CGRect)frame;
-(NSString *)removeEscapeFrom:(NSString *)string;
-(void)endstrokeChart;

@property (strong,nonatomic) NSArray *chardata; //“desc” “value”  "color" nsdirectory
@property (nonatomic) float valueMax;
@property (nonatomic,strong) CAShapeLayer * chardial;
@property (nonatomic, strong) UIColor * strokeColor;

@end
