//
//  choiceCell.m
//  Smartbox
//
//  Created by Mesada on 15/1/4.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "choiceCell.h"

@implementation choiceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
//    if (selected) {
//            [_checkview setBackgroundImage:<#(UIImage *)#> forState:UIControlStateSelected];
//    }
//    else{
//        
//    }
    if(selected)
    {
      _checkView.selected = !_checkView.selected;
    }
}

@end
