//
//  roadEndCell.h
//  Smartbox
//
//  Created by Mesada on 15/3/28.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycloView.h"

@interface roadEndCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *descriptionText;
@property (strong, nonatomic) IBOutlet UILabel *timeText;
@property (strong, nonatomic) IBOutlet UIView *verticalView;
@property (strong, nonatomic) IBOutlet CycloView *cycloView;
@property (strong, nonatomic) IBOutlet UIImageView *arrow;
@property (strong, nonatomic) IBOutlet UILabel *subDescription;

@property (strong, nonatomic) UIColor* doneColor; //完成时候字体和圈圈的颜色
@property (strong, nonatomic) UIColor* undoneColor; //未完成时候字体和圈圈的颜色
-(void)setDescriptionTextAndTime:(NSString *)descriptionText time:(NSString*)timestr done:(BOOL)done;
@end
