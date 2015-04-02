//
//  dateCellChoice.h
//  Smartbox
//
//  Created by Mesada on 15/1/4.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dateModeCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *dateBts;
@property (nonatomic) int selectIndex;
-(void)setSelectBt:(UIButton*)selectbt;
- (IBAction)dochoiceDateType:(id)sender;
@end
