//
//  AlertViewController.h
//  Smartbox
//
//  Created by Mesada on 15/1/5.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertViewController : UITableViewController
{
    NSString*timeStr;
    NSString*dateStr;
    NSString*phoneNOStr;
    BOOL OnOff;
    BOOL isAllDay;
    BOOL timeFlag; //1为周期　０　为日期；
}
@property (strong, nonatomic) IBOutlet UISwitch *switchView;
- (IBAction)switchAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableViewCell *daypartCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *dateCell;

//
@property (nonatomic,retain)NSString * timeStr;
@property (nonatomic,retain)NSString * dateStr;
@property (nonatomic,retain)NSString * phoneNOStr;


@property (nonatomic,retain)NSString*startDateStr;
@property (nonatomic,retain)NSString*endDateStr;
@property (nonatomic,retain)NSDate *startDate;
@property (nonatomic,retain)NSDate *endDate;

@end
