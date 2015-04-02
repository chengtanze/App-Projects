//
//  messageCell.h
//  Smartbox
//
//  Created by Mesada on 14/12/27.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "message.h"

@interface messageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *timeLable;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UIButton *contentBtn;
@property (strong,nonatomic) Message* message;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btheightConstraint;
@property (readonly) CGFloat cellHeight;
@end
