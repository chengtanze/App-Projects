//
//  Alert_dataSettingController.h
//  Smartbox
//
//  Created by Mesada on 15/1/4.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "timePick.h"

typedef enum{
    DateEveryDayMode = 0,
    DateWordDayMode ,
    DateWeekenMode,
    DateDefaultMode,
} DateMode;

@interface Alert_dataSettingController : UITableViewController<timePickdelegate>


@property (nonatomic) BOOL isRepeat;
@property (nonatomic,retain)NSString*startDateStr;
@property (nonatomic,retain)NSString*endDateStr;

@property (nonatomic,strong) NSMutableArray* selectWeekdays;
@property DateMode dateMode;
- (IBAction)doRepeat:(id)sender;
@end
