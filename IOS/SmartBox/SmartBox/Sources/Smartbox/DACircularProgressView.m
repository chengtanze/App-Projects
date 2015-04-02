//
//  DACircularProgressView.m
//  DACircularProgress
//
//  Created by Daniel Amitay on 2/6/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "DACircularProgressView.h"

#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))

@implementation DACircularProgressView

@synthesize trackTintColor = _trackTintColor;
@synthesize progressTintColor =_progressTintColor;
@synthesize progress = _progress;
@synthesize fpathWidth = _fpathWidth;

- (id)init
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        _fpathWidth = 0.3;
        _trackTintColor = [UIColor colorWithRed:65.0 green:112.0 blue:165.0 alpha:1.0];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
       
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGPoint centerPoint = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = MIN(rect.size.height, rect.size.width) / 2;
    
    CGFloat pathWidth = radius * _fpathWidth;//进度条宽度
    
    CGFloat radians = DEGREES_2_RADIANS((self.progress*359.9)-90);
    float multiplier = 1-_fpathWidth*0.5;
    CGFloat xOffset = radius*(1 + multiplier*cosf(radians));//0.85是1-0.3/2计算出来的
    CGFloat yOffset = radius*(1 + multiplier*sinf(radians));
    CGPoint endPoint = CGPointMake(xOffset, yOffset);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.trackTintColor setFill];
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(0), DEGREES_2_RADIANS(360), NO);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(context, trackPath);
    CGContextFillPath(context);
    CGPathRelease(trackPath);
    
    [self.progressTintColor setFill];
    CGMutablePathRef progressPath = CGPathCreateMutable();
    CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), radians, NO);
    CGPathCloseSubpath(progressPath);
    CGContextAddPath(context, progressPath);
    CGContextFillPath(context);
    CGPathRelease(progressPath);
    
    CGFloat Xoffset = rect.size.width*0.5 -radius;
    CGFloat Yoffset = rect.size.height*0.5- radius;
    
    CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x - pathWidth/2, Yoffset, pathWidth, pathWidth));
    CGContextFillPath(context);
    

    
    CGContextAddEllipseInRect(context, CGRectMake(endPoint.x- pathWidth/2+Xoffset, endPoint.y - pathWidth/2+Yoffset, pathWidth, pathWidth));
    CGContextFillPath(context);
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
    float innerRadiusMultiplier = 1-_fpathWidth;
    CGFloat innerRadius = radius * innerRadiusMultiplier; //内圆半斤是半径-进度条宽度
	CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);    
	CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius*2, innerRadius*2));
	CGContextFillPath(context);
}

#pragma mark - Property Methods

//- (UIColor *)trackTintColor
//{
//    if (!_trackTintColor)
//    {
//        _trackTintColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.3f];
//    }
//    return _trackTintColor;
//}
//
//- (UIColor *)progressTintColor
//{
//    if (!_progressTintColor)
//    {
//        _progressTintColor = [UIColor whiteColor];
//    }
//    return _progressTintColor;
//}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

@end
