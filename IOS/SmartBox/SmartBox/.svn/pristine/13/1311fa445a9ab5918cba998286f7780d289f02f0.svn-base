//
//  PNBar.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNBar.h"
//#import "PNColor.h"
//额外的像素点，方式0的时候柱状图没有任何显示
#define EXTRAPOINT 1
@implementation PNBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _type = NORMALTYPE;
		_chartLine = [CAShapeLayer layer];
		_chartLine.lineCap = kCALineCapButt;
		_chartLine.fillColor   = [[UIColor clearColor] CGColor];
        _chartLine.backgroundColor = [[UIColor clearColor]CGColor];
        _chartLine.lineWidth   = self.frame.size.width;
		_chartLine.strokeEnd   = 0.0;
		self.clipsToBounds = NO;
		[self.layer addSublayer:_chartLine];
		self.layer.cornerRadius = 2.0;
    }
    return self;
}

-(void)dealloc
{
//    NSLog(@"PNBar dealloc");
    [self Stopanimation];
}

-(void)setGrade:(float)grade
{
	_grade = grade;
	UIBezierPath *progressline = [UIBezierPath bezierPath];
    CGFloat pointx = self.frame.size.width/2.0;
    CGFloat pointy = self.frame.size.height;
    
    if(_type == DWONTYPE)
    {
        [progressline moveToPoint:CGPointMake(pointx, 0)];
        [progressline addLineToPoint:CGPointMake(pointx,  grade * pointy+EXTRAPOINT)];
    }
    else
    {
            [progressline moveToPoint:CGPointMake(pointx, pointy)];
            [progressline addLineToPoint:CGPointMake(pointx, (1 - grade) * pointy-EXTRAPOINT)];
    }
    _chartLine.path = progressline.CGPath;
    
    if (_barColor) {
        _chartLine.strokeColor = [_barColor CGColor];
    }else{
        _chartLine.strokeColor = [[UIColor greenColor]CGColor];
    }
    
    if (_grade>0) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.delegate = self;
        pathAnimation.duration = 1.0;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
    else
    {
        [self addtipLabel];
    }

//
    _chartLine.strokeEnd = 1.0;
    

}

-(void)Stopanimation
{
     [_chartLine removeAllAnimations];
}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(!flag)
    {
//        NSLog(@"animationDidStop FLAG");
        return;
    }
    [self addtipLabel];
}

-(void)addtipLabel
{
    CGFloat pointy = self.frame.size.height;
    switch (_type) {
        case NORMALTYPE:
            case UPTYPE:
        {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, (1 - _grade) * pointy-20, self.frame.size.width, 20)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            label.textColor = [UIColor darkGrayColor];
            label.text = _strValue;
            [self addSubview:label];
        }
            break;
//        case UPTYPE:
//        {
//            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, (1 - _grade) * pointy, self.frame.size.width, 30)];
//            [label setTextAlignment:NSTextAlignmentCenter];
//            [label setFont:[UIFont systemFontOfSize:10.0f]];
//            label.textColor = [UIColor darkGrayColor];
//            label.numberOfLines = 0;
//            label.text = _strValue;
//            [self addSubview:label];
//        }
//            break;
        case DWONTYPE:
        {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, _grade * pointy, self.frame.size.width, 20)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:[UIFont systemFontOfSize:10.0f]];
            label.textColor = [UIColor darkGrayColor];
            label.numberOfLines = 0;
            label.text = _strValue;
            [self addSubview:label];
        }
            break;
        default:
            break;
    }

}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//	//Draw BG
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0].CGColor);
//	CGContextFillRect(context, rect);
//    
//}


@end
