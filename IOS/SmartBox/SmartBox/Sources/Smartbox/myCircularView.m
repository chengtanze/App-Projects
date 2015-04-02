//
//  myCircularView.m
//  Smartbox
//
//  Created by Mesada on 15/1/13.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "myCircularView.h"
//debug bobo
#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))

@interface myCircularView()
@property (nonatomic) CGPoint arcCenter;
@property (nonatomic) CGFloat arcRadius;
@property (nonatomic,strong) UILabel* firstTip;
@property (nonatomic,strong) UILabel* secondTip;
@end
@implementation myCircularView

@synthesize labelbackColor;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

        _arcCenter = CGPointMake(CGRectGetMidY(self.bounds), CGRectGetMidX(self.bounds));
        _arcRadius = CGRectGetMidX(self.bounds)-8;//5
        _strokeWidth = 2.0;

        //test

        
        _firstLabel = [[UILabel alloc]init];
        _firstLabel.bounds = CGRectMake(0, 0, 40, 14);
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        CGPoint anglePoint;
        anglePoint.x = _arcCenter.x + _arcRadius * cos(M_PI);
        anglePoint.y = CGRectGetMidX(self.bounds);
        _firstLabel.center = anglePoint;
        
        _firstLabel.text = @"等级";
        _firstLabel.font = [UIFont boldSystemFontOfSize:12];
        _firstLabel.textColor = [UIColor yellowColor];
        _firstLabel.backgroundColor = self.backgroundColor;
        NSLog(@"color=%@",self.backgroundColor);
        [self addSubview:_firstLabel];
        
        _secondLabel = [[UILabel alloc]init];
        _secondLabel.text = @"积分";
         _secondLabel.bounds = CGRectMake(0, 0, 40, 14);
        _secondLabel.font = [UIFont boldSystemFontOfSize:12];
        _secondLabel.textColor = [UIColor greenColor];
        _secondLabel.backgroundColor = self.backgroundColor;
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        anglePoint.x = _arcCenter.x + _arcRadius;
        _secondLabel.center = anglePoint;
         [self addSubview:_secondLabel];
        
        _firstTip = [[UILabel alloc]init];
        _firstTip.text = @"LV1";
        _firstTip.bounds = CGRectMake(0, 0, 40, 14);
        _firstTip.font = [UIFont boldSystemFontOfSize:12];
        _firstTip.textColor = [UIColor yellowColor];
        _firstTip.backgroundColor = [UIColor clearColor];
        _firstTip.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_firstTip];
        
        _secondTip = [[UILabel alloc]init];
        _secondTip.text = @"LV1";
        _secondTip.bounds = CGRectMake(0, 0, 40, 14);
        _secondTip.font = [UIFont boldSystemFontOfSize:12];
        _secondTip.textColor = [UIColor greenColor];
        _secondTip.backgroundColor = [UIColor clearColor];
        _secondTip.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_secondTip];

        _secondTip.hidden = YES;
        _firstTip.hidden = YES;
//        self.firstPercent = 0.4;
//        [self setpresentAniamtion:1];
//        self.secondPercent = 0.5;
        //动起来
    }
    
    return self;
}


-(void)setpresentAniamtion:(CGFloat)Percent
{
    NSTimer* connectionTimer=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerFired:) userInfo:[NSNumber numberWithFloat:Percent] repeats:YES];
    [connectionTimer fire];
}

-(void)timerFired:(NSTimer *)timer{
    static float presentPer= 0;
    float percent = [timer.userInfo floatValue];
    presentPer += 0.002;
    if (presentPer< percent) {
        self.firstPercent = presentPer;
    }
    else{
        self.firstPercent = percent;
        presentPer = 0;
        [timer invalidate];
    }
}

-(void)setFirstPercent:(CGFloat)firstPercent
{
    _firstPercent = firstPercent;
     CGFloat endAngle = M_PI-_firstPercent*M_PI;
    //计算题提示label的中心点坐标,label 的轨迹是椭圆
    CGFloat a = _arcRadius+_firstTip.bounds.size.width/2+2;
    CGFloat b = _arcRadius+_firstTip.bounds.size.height/2+2;
    CGFloat c = tanf(endAngle);
    CGFloat x = sqrtf(a*a*b*b/(b*b+a*a*c*c));
    CGFloat y  = 0;
    if (x<1 && x>-1) {
          y = -b;
    }
    else{
        y = c*x;
    }
    
    if (c<0) {
        x = -x;
    }
     y = fabsf(y);
    _firstTip.center = CGPointMake( _arcCenter.x+x, _arcCenter.y-y);
    NSLog(@"_firstTip.frame x=%f y =%f ",_firstTip.frame.origin.x, _firstTip.frame.origin.y);
    _firstTip.hidden = NO;
    [self setNeedsDisplay];
}



-(void)setSecondPercent:(CGFloat)secondPercent
{
    _secondPercent = secondPercent;
    CGFloat endAngle = -_secondPercent*M_PI;
    //计算题提示label的中心点坐标,label 的轨迹是椭圆
    CGFloat a = _arcRadius+_secondTip.bounds.size.width/2+2;
    CGFloat b = _arcRadius+_secondTip.bounds.size.height/2+2;
    CGFloat c = tanf(endAngle);
    CGFloat x = sqrtf(a*a*b*b/(b*b+a*a*c*c));
    CGFloat y  = 0;
    if (x<1 && x>-1) {
        y = b;
    }
    else{
        y = c*x;
    }
    
    if (c>0) {
        x = -x;
    }
    y = fabsf(y);
    _secondTip.center = CGPointMake( _arcCenter.x+x, _arcCenter.y+y);
    _secondTip.hidden = NO;
    [self setNeedsDisplay];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _arcCenter = CGPointMake(CGRectGetMidY(self.bounds), CGRectGetMidX(self.bounds));
        _arcRadius = CGRectGetMidX(self.bounds)-5;
        _strokeWidth = 2.0;
        _firstPercent = 0.5;
        _secondPercent = 0.3;
        
    }
    
    return self;
}


-(void)drawboll:(CGPoint)anglePoint Color:(UIColor *)color
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, _strokeWidth);
    CGContextBeginPath(context);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextAddArc(context, anglePoint.x, anglePoint.y, _strokeWidth*2, M_PI , -M_PI, NO);
    CGContextFillPath(context);
    CGContextStrokePath(context);
}

-(void)drawAngle:(float)startAngle endAngle:(float)endAngle Color:(UIColor *)color clockwise:(BOOL)clockwise
{
    /*
     void CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
     *x,y为圆点坐标，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
     弧度 = 角度 * PI / 180
     角度 = 弧度 * 180 / PI
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextBeginPath(context);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextAddArc(context, _arcCenter.x, _arcCenter.y, _arcRadius, startAngle , endAngle, clockwise);
    CGContextStrokePath(context);
}



- (void)drawRect:(CGRect)rect {
    [self drawAngle:M_PI endAngle:-M_PI Color:[UIColor whiteColor] clockwise:NO];
    //
      [self drawAngle:M_PI endAngle:M_PI+_firstPercent*M_PI Color:[UIColor yellowColor] clockwise:NO];
    //
       [self drawAngle:0 endAngle:_secondPercent*M_PI Color:[UIColor greenColor] clockwise:NO];
    //
    
    CGFloat endAngle = M_PI+_firstPercent*M_PI;
    CGPoint anglePoint;
    anglePoint.x = _arcCenter.x + _arcRadius * cos(endAngle);
    anglePoint.y = _arcCenter.y + _arcRadius * sin(endAngle);
    [self drawboll:anglePoint Color:[UIColor yellowColor]];
    
    endAngle = _secondPercent*M_PI;
    anglePoint.x = _arcCenter.x + _arcRadius * cos(endAngle);
    anglePoint.y = _arcCenter.y + _arcRadius * sin(endAngle);
    [self drawboll:anglePoint Color:[UIColor greenColor]];
    
}



@end
