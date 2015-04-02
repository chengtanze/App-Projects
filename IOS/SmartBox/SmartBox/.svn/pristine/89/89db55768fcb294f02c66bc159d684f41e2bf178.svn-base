//
//  CycloLabel.m
//  Smartbox
//
//  Created by Mesada on 14/11/3.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "CycloLabel.h"

@implementation CycloLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = self.frame.size.width*0.5;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.frame.size.width*0.5;
    }
    return self;
}
@end
