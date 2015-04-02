//
//  CircularLayer.m
//  Smartbox
//
//  Created by Mesada on 15/1/13.
//  Copyright (c) 2015年 mesada. All rights reserved.
//
#import "PCHHeader.h"
#import "CircularLayer.h"

#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))


@interface CircularLayer()
{
    CAShapeLayer* backgroundLayer2;
}
@property (nonatomic) float angle;
@property (nonatomic,strong) CATextLayer* firstTextLayer;

@end

@implementation CircularLayer


- (instancetype)init
{
    self = [super init];
    if (self) {

        
//       self.lineCap = kCALineCapButt;
//        self.lineJoin = kCALineJoinBevel;
//        self.fillColor   = [UIColor blackColor].CGColor;
//        self.lineWidth   = 4.0;
//         self.strokeEnd   = 0;
//        self.strokeColor = [[UIColor yellowColor]CGColor];
//        self.backgroundColor = [UIColor blueColor].CGColor;
        _firstTextLayer = [CATextLayer layer];
        _firstTextLayer.string = @"111";
//        self.shouldRasterize = YES;
        //
         backgroundLayer2 = [CAShapeLayer layer];
         [self addSublayer:backgroundLayer2];
        
    }
    return self;
}


+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if([key isEqualToString:@"endAngle"])
    {
        return YES;
    }
    else {
        return [super needsDisplayForKey:key];
    }
        
}

//- (CGMutablePathRef) refreshPath {
//    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
//    CGMutablePathRef path = CGPathCreateMutable();
//    
//    //       CGPathCloseSubpath(path);
////    CGPathAddRelativeArc(path, &_currentMatrix, center.x, center.y, _innerRadius, _startAngle, _angle);
////    CGPathAddRelativeArc(path, &_currentMatrix, center.x, center.y, _outerRadius, _startAngle+_angle , -_angle);
//  CGPathCloseSubpath(path);
//    return path;
//}

//- (void) setPath:(CGPathRef)path {
//    [super setPath:path];
//    
//    if (_showLabel) {
//        CGRect rect = CGPathGetPathBoundingBox(path);
//        CGSize size = self.frame.size;
//        CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//        center = CGPointMake(center.x+_accentVector.x*size.width/4+_accentValue, center.y+_accentVector.y*size.height/4+_accentValue);
//        
//        [CATransaction begin];
//        [CATransaction setDisableActions:YES];
//        if (CGRectContainsPoint(rect, center)) {
//            [self.label setPosition:center];
//            [self.label setHidden:NO];
//        } else {
//            [self.label setHidden:YES];
//        }
//        [CATransaction commit];
//    }
//}


//- (void) __angle:(float)angle {
//    _angle = angle;
//    CGPathRef path = [self refreshPath];
//    self.path = path;
//    CGPathRelease(path);
//}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
//    [_firstTextLayer setFrame:CGRectMake(0, 0, 20, 20)];
//    _firstTextLayer.fontSize = 14;
//    [self addSublayer:_firstTextLayer];
}

-(void)setLevel:(int)nlevel
{
    _angle = DEGREES_2_RADIANS(nlevel);
    NSLog(@"_angle = %f",_angle);
    _endAngle = _angle;
   [self _animate];
    
    [self setNeedsDisplay];
}


- (void) _animate {
    
    CABasicAnimation *arcAnimation = [CABasicAnimation animationWithKeyPath:@"endAngle"];
    [arcAnimation setFromValue:[NSNumber numberWithFloat:0]];
    [arcAnimation setToValue:[NSNumber numberWithFloat:_angle]];
    [arcAnimation setDuration:1.0];
    [arcAnimation setDelegate:self];
    [arcAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [self addAnimation:arcAnimation forKey:@"endAngleAnimation"];
    
    [self setHidden:NO];
}

-(void)display
{
    NSLog(@"_angle = %f",_endAngle);
 
    [super display];
}


- (void)drawInContext:(CGContextRef)ctx
{
   

    
    
   UIGraphicsPushContext(ctx);
//   CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//
//
       CGPoint anglePoint;
        anglePoint.x = _arcCenter.x + _radius * cos(_endAngle);
        anglePoint.y = _arcCenter.y + _radius * sin(_endAngle);
    
    UIBezierPath *bpath = [[UIBezierPath alloc] init];
    [bpath addArcWithCenter:_arcCenter
                     radius:self.frame.size.width/3
                 startAngle:DEGREES_2_RADIANS(0)
                   endAngle:_endAngle
                  clockwise:YES];
    backgroundLayer2.path = bpath.CGPath;
    backgroundLayer2.strokeColor = [[UIColor lightGrayColor] CGColor];
    backgroundLayer2.fillColor = [[UIColor clearColor] CGColor];
    backgroundLayer2.lineWidth = 4;
    backgroundLayer2.strokeEnd = 1;
    [backgroundLayer2 renderInContext:ctx];
//
//    _firstTextLayer.position = anglePoint;
    
//    CGContextMoveToPoint(ctx, _arcCenter.x, _arcCenter.y);
//    CGContextAddEllipseInRect(ctx,CGRectMake(_arcCenter.x,  _arcCenter.y, 20, 20));
//    CGContextAddQuadCurveToPoint(ctx, anglePoint.x, anglePoint.y, _arcCenter.x, _arcCenter.y);
//    CGContextSetLineCap(ctx, kCGLineCapRound);
//    CGContextSetLineWidth(ctx, 2);
//    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
//    CGContextSetInterpolationQuality(ctx,kCGInterpolationHigh);
//    CGContextStrokePath(ctx);
    
    
    

//        [[UIColor blackColor] set];
//        bpath.lineWidth = 5;
//        bpath.lineJoinStyle = kCGLineJoinBevel; //拐角的处理
//        bpath.lineCapStyle = kCGLineCapButt; //最后点的处理
//        backgroundLayer2.path = bpath.CGPath;
    
//    UIBezierPath* circlePath2 = [UIBezierPath bezierPathWithArcCenter:_arcCenter
//                                                               radius:_radius-6
//                                                           startAngle:M_PI
//                                                             endAngle:-M_PI
//                                                            clockwise:NO];
//    

    
    
//    UIBezierPath *bpath = [[UIBezierPath alloc] init];
//    [bpath addArcWithCenter:_arcCenter
//                    radius:self.frame.size.width/3
//                startAngle:DEGREES_2_RADIANS(0)
//                  endAngle:DEGREES_2_RADIANS(360)
//                 clockwise:YES];
//    [[UIColor blackColor] set];
//    bpath.lineWidth = 3;
//    bpath.lineJoinStyle = kCGLineJoinBevel; //拐角的处理
//    bpath.lineCapStyle = kCGLineCapButt; //最后点的处理
//    [bpath stroke];
    
//    CGPoint anglePoint;
//    anglePoint.x = _arcCenter.x + _radius * cos(_endAngle);
//    anglePoint.y = _arcCenter.y + _radius * sin(_endAngle);
//    
//      UIBezierPath *bpath2 = [[UIBezierPath alloc] init];
//    
//    [bpath2 addArcWithCenter:_arcCenter
//                    radius:self.frame.size.width/3
//                startAngle:DEGREES_2_RADIANS(0)
//                  endAngle:_endAngle
//                 clockwise:YES];
//    [[UIColor yellowColor] set];
//    [bpath2 setLineWidth:4];
//    
//    [bpath2 addArcWithCenter:anglePoint radius:_radius startAngle:0 endAngle:2*M_PI clockwise:TRUE];
//     self.path = bpath2.CGPath;
//    [bpath2 stroke];
    NSLog(@"_endAngle  = %f  ", _endAngle);

    
//    
//    anglePoint.x = center.x + radius * cos(_endAngle);
//    anglePoint.y = center.y + radius * sin(_endAngle);
    
//  [self drawText:@"fuc" point:anglePoint];

   UIGraphicsPopContext();
//
}

-(void)drawText:(NSString *)string point:(CGPoint)point{
    
    
        UIColor *stringColor = [UIColor yellowColor];  //设置文本的颜色
    
        NSDictionary* attrs =@{NSForegroundColorAttributeName:stringColor,
                               NSFontAttributeName:[UIFont systemFontOfSize:18]
                               }; //在词典中加入文本的颜色 字体 大小
      [string drawInRect:CGRectMake(point.x, point.y, 50, 50) withAttributes:attrs];
//    [string drawInRect:CGRectMake(0, 0, 119, 116) withAttributes:[self setAttributesWithFontSize:14 WithTextColor:[UIColor blueColor] WithAlignment:NSTextAlignmentLeft]];
    
    
    
}
    
-(NSDictionary *)setAttributesWithFontSize:(NSInteger)size WithTextColor:(UIColor *)color WithAlignment:(NSTextAlignment)alignment

{
    
    NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    paragraphStyle.alignment = alignment;
    
    NSDictionary *attributes= [NSDictionary dictionaryWithObjectsAndKeys:
                               
                               [UIFont systemFontOfSize:size], NSFontAttributeName,
                               
                               paragraphStyle,NSParagraphStyleAttributeName,color,NSForegroundColorAttributeName,[UIColor blackColor],NSStrokeColorAttributeName,[NSNumber numberWithFloat:2.0],NSStrokeWidthAttributeName,nil];
    
    return attributes;
}

@end
