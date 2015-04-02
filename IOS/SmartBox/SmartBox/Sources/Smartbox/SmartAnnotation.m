//
//  SmartAnnotation.m
//  Smartbox
//
//  Created by Mesada on 15/1/21.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "SmartAnnotation.h"

@implementation SmartAnnotation

@synthesize coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D) coord
{
    coordinate.latitude = coord.latitude;
    coordinate.longitude = coord.longitude;
    return self;
}

@end
