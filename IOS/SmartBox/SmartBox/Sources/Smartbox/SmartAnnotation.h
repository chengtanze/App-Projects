//
//  SmartAnnotation.h
//  Smartbox
//
//  Created by Mesada on 15/1/21.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAAnnotation.h>

typedef NS_ENUM(NSInteger, AnnotationType) {
    DriveStart_Annotation = 0,
    DriveEnd_Annotation,
    DriveSpecial_Annotation,
    Car_Annotation,
    Person_Annotation
};

@interface SmartAnnotation : NSObject<MAAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) AnnotationType type;
@property (nonatomic) NSInteger subtype;
//@property (nonatomic) UIColor *color;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coord;

@end
