//
//  dateCellChoice.m
//  Smartbox
//
//  Created by Mesada on 15/1/4.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "dateModeCell.h"

@implementation dateModeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSelectIndex:(int)selectIndex
{
    for (UIButton* bt in _dateBts) {
        bt.backgroundColor = [UIColor whiteColor];
        bt.titleLabel.textColor = [UIColor blackColor];
    }
    if (selectIndex<3) {
        UIButton* selectbt = _dateBts[selectIndex];
        if (selectbt) {
            selectbt.backgroundColor = [UIColor colorWithRed:0.32 green:0.675 blue:0.047 alpha:1];
            selectbt.titleLabel.textColor = [UIColor whiteColor];
        }
    }
}
-(void)setSelectBt:(UIButton*)selectbt
{
    for (UIButton* bt in _dateBts) {
        bt.backgroundColor = [UIColor whiteColor];
        bt.titleLabel.textColor = [UIColor blackColor];
    }

    if (selectbt) {
        selectbt.backgroundColor = [UIColor colorWithRed:0.32 green:0.675 blue:0.047 alpha:1];
        selectbt.titleLabel.textColor = [UIColor whiteColor];
    }
}

- (IBAction)dd:(id)sender {
}

- (IBAction)dochoiceDateType:(id)sender {

    [self setSelectBt:sender];
    
}
@end
