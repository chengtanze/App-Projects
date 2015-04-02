//
//  timePick.m
//  Smartbox
//
//  Created by Mesada on 15/1/5.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "timePick.h"

@implementation timePick

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)clickConfirm:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickExitbt:)]) {
        [self.delegate didClickExitbt:NO];
    }

}

- (IBAction)clickCancel:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickExitbt:)]) {
        [self.delegate didClickExitbt:YES];
    }

}
@end
