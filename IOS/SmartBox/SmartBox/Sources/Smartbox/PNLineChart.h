//
//  PNLineChart.h
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define chartMargin     10
#define xLabelMargin    15
#define yLabelMargin    15
#define yLabelHeight    14

typedef struct __CHARDATARANG
{
    int min;
    int max;
}CHARDATARANG;

@interface PNLineChart : UIView

/**
 * This method will call and troke the line in animation
 */

//-(void)strokeChart;
-(void)setChardata:(NSArray *)data;
-(id)initWithFrame:(CGRect)frame;
-(void)endstrokeChart;


@property (nonatomic,strong) CAShapeLayer * chardial;
@property (strong,nonatomic) NSArray *chardata; //“desc” “value”  nsdirectory
@property (nonatomic) int grade;  //等阶线条数
@property (nonatomic) CHARDATARANG rang;
@end
