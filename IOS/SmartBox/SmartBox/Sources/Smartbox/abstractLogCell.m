//
//  abstractLogCell.m
//  Smartbox
//
//  Created by Mesada on 14/12/11.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "abstractLogCell.h"
#import "PublicFunction.h"
@implementation abstractLog_Cell

- (void)awakeFromNib {
    // Initialization code
    UIImage* backImage = [PublicFunction  imageWithColor:[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1] andSize:_backBt.frame.size];
   [_backBt setBackgroundImage:backImage forState:UIControlStateHighlighted];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
