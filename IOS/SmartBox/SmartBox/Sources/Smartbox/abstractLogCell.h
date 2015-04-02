//
//  abstractLogCell.h
//  Smartbox
//
//  Created by Mesada on 14/12/11.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycloView.h"
@interface abstractLog_Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *LsplitLine;
@property (strong, nonatomic) IBOutlet UIView *RsplitLine;
@property (strong, nonatomic) IBOutlet UILabel *weekDateView;
@property (strong, nonatomic) IBOutlet UILabel *dateView;
@property (strong, nonatomic) IBOutletCollection(CycloView) NSArray *cycloLogView;
@property (strong, nonatomic) IBOutlet UIButton *backBt;

@end
