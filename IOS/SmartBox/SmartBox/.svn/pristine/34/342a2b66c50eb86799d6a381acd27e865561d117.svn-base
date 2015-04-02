//
//  PNBar.h
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum __PNBARTYPE
{
    NORMALTYPE = 0,
    UPTYPE =1,
    DWONTYPE = 2,
}PNBARTYPE;

@interface PNBar : UIView

@property (nonatomic) float grade;

@property (nonatomic,strong) CAShapeLayer * chartLine;

@property (nonatomic, strong) UIColor * barColor;

@property (nonatomic, strong) NSString* strValue;

@property (nonatomic) PNBARTYPE type;


-(void)Stopanimation;

@end
