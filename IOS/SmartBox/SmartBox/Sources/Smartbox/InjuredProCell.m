//
//  InjuredProCell.m
//  Smartbox
//
//  Created by Mesada on 15/3/26.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "InjuredProCell.h"

@implementation InjuredProCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDescriptionTextAndTime:(NSString *)descriptionText time:(NSString*)timestr done:(BOOL)done
{
    _descriptionText.text = descriptionText;
    _timeText.text = timestr;
    
    if(done)
    {
        _descriptionText.textColor = _doneColor;
        _cycloView.backgroundColor = _doneColor;
        _verticalView.backgroundColor = _doneColor;
    }
    else
    {
        _descriptionText.textColor = _undoneColor;
        _cycloView.backgroundColor = _undoneColor;
        _verticalView.backgroundColor = _undoneColor;
    }
}
@end
