//
//  PNBarChart.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNBarChart.h"
//#import "PNColor.h"
//#import "PNChartLabel.h"
#import "PNBar.h"

#define TOPEDGE     20.0
#define BOTTOMEDGE  5.0
#define EDGE        0.0
#define CHARDIALHEIGHT 40.0
#define BARWIDTHSCALE 0.75

@implementation PNBarChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor greenColor];
        self.clipsToBounds = YES;
        _valueMax= 100;
        
        _chardial = [CAShapeLayer layer];
        _chardial.backgroundColor = [[UIColor clearColor]CGColor];
        _chardial.lineCap = kCALineCapSquare;
        _chardial.fillColor = [[UIColor grayColor] CGColor];
        _chardial.strokeColor = [[UIColor greenColor] CGColor];
        
        _chardial.lineWidth   = 0.5;
        _chardial.strokeEnd   = 0.0;
        _chardial.lineJoin    = kCALineJoinBevel;
        _chardial.frame       = self.bounds;
        [self.layer addSublayer:_chardial];
        
    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        _valueMax= 100;
        
        _chardial = [CAShapeLayer layer];
        _chardial.backgroundColor = [[UIColor clearColor]CGColor];
        _chardial.lineCap = kCALineCapSquare;
        _chardial.fillColor = [[UIColor grayColor] CGColor];
        _chardial.strokeColor = [[UIColor grayColor] CGColor];
        
        _chardial.lineWidth   = 0.5;
        _chardial.strokeEnd   = 0.0;
        _chardial.lineJoin    = kCALineJoinBevel;
        _chardial.frame       = self.bounds;
        [self.layer addSublayer:_chardial];
        
    }
    return self;
}

-(void)setChardata:(NSArray *)data
{
    _chardata = data;
    [self strokeChardial];
    [self strokeChart];
}


-(void)setStrokeColor:(UIColor *)strokeColor
{
	_strokeColor = strokeColor;
}

-(void)strokeChart
{
    NSInteger count =  _chardata.count;
    CGFloat  spacing = self.frame.size.width/(count+.25);
    
    CGFloat ptx = 0;
    int index = 0;
    CGFloat chartCavanHeight = self.frame.size.height -TOPEDGE - BOTTOMEDGE - CHARDIALHEIGHT-8;
    CGFloat pty = TOPEDGE;

    for (NSDictionary * valuedic in _chardata) {
        NSNumber* value = [valuedic objectForKey:@"value"];
        
        float grade = (float)[value integerValue] /_valueMax;
        if (index== 0) {
            ptx = spacing*.6;
        }
        else{
            ptx += spacing; //中间点
        }
        
        PNBar * bar= [[PNBar alloc] initWithFrame:CGRectMake(ptx-spacing*BARWIDTHSCALE*.5,pty,spacing*.75,chartCavanHeight)];;
     
        UIColor* colorvalue = [valuedic objectForKey:@"color"];
		bar.barColor = colorvalue;
        bar.strValue = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
		bar.grade = grade;
 
		[self addSubview:bar];
        
        index += 1;
    }
}

-(void) strokeChardial
{
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    CGFloat ypt = self.frame.size.height-CHARDIALHEIGHT - BOTTOMEDGE;
    CGFloat xrpt = self.frame.size.width - 2*EDGE;
    [progressline moveToPoint:CGPointMake(EDGE, ypt)];
    [progressline addLineToPoint:CGPointMake(xrpt, ypt)];


    NSInteger count =  _chardata.count;
    CGFloat  spacing = self.frame.size.width/(count+.25);
        //n端竖线
    
    CGFloat ptx =0 ;
    CGFloat pty =0;
    for (int index = 0; index < count; index++) {

         pty = ypt+8;
        if (index== 0) {
           ptx = spacing*.6;
        }
        else{
            ptx += spacing;
        }
        [progressline moveToPoint:CGPointMake(ptx, ypt)];
        [progressline addLineToPoint:CGPointMake(ptx, pty)];
        //加上xlabel

        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(ptx-spacing, pty,spacing,14.0)];
       
        [label setFont:[UIFont systemFontOfSize:10]];
        [label setTextAlignment:NSTextAlignmentRight];
       
        label.text = [[_chardata objectAtIndex:index]objectForKey:@"desc"];;
        CGRect oldframe = label.frame;
        [label.layer setAnchorPoint:CGPointMake(1, 0)];
        label.textColor = [UIColor darkGrayColor];
        label.frame = oldframe;
        label.transform = CGAffineTransformMakeRotation((-30.0f * M_PI) / 180.0f);
//        [label.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
       
        [self addSubview:label];
    }
    
    _chardial.path = progressline.CGPath;
    _chardial.strokeEnd   = 1.0;
    
}

-(void)endstrokeChart
{
//    [self.layer removeAllAnimations];
    
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[UIView class]])
        {
            NSLog(@"%@",[view class]);
            if ([view isKindOfClass:[PNBar class]]) {
                PNBar* bar = (PNBar* )view;
                [bar Stopanimation];
//                [view performSelector:@selector(Stopanimation) withObject:nil];
            }
            [view removeFromSuperview];
        }
    }
    
}


-(void)dealloc
{
//    [_chardial removeAllAnimations];
    [self endstrokeChart];
    NSLog(@"PNBarChart dealloc");
}
@end
