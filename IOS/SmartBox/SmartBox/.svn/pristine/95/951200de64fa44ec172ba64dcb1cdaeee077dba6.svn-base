//
//  AlertViewController.m
//  Smartbox
//
//  Created by Mesada on 15/1/5.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "AlertViewController.h"
#import "Alert_dataSettingController.h"
#import "DaypartSettingController.h"
@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dateCell.hidden = !_switchView.on;
    _daypartCell.hidden = !_switchView.on;
    
    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}


- (IBAction)switchAction:(id)sender {
    UISwitch* switchView = (UISwitch*)sender;
    if (!switchView.on) {
        _daypartCell.alpha = 1.0;
        _dateCell.alpha = 1.0;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
            _daypartCell.alpha = 0.0;
            _dateCell.alpha = 0.0;
        }
                         completion:^(BOOL finished){
                             if (finished) {
                                 _daypartCell.hidden = TRUE;
                                 _dateCell.hidden = TRUE;
                             }
                             
                         }
         ];
        
    }
    else{
        
        _daypartCell.hidden = FALSE;
        _dateCell.hidden = FALSE;
        _daypartCell.alpha = 0.0;
        _dateCell.alpha = 0.0;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^(void){
            _daypartCell.alpha = 1.0;
            _dateCell.alpha = 1.0;
            
        }
                         completion:^(BOOL finished){
                             if (finished) {
                                 
                             }
                             
                         }
         ];
        
    }
}

- (IBAction)unwindSegueToAlertViewController:(UIStoryboardSegue *)segue {
    
    if ([segue.identifier  isEqual: @"unwindDate"]) {
        Alert_dataSettingController* vc =   (Alert_dataSettingController*)segue.sourceViewController;
        
        timeFlag = vc.isRepeat;
//        
        if(vc.isRepeat)
        {
           if(vc.dateMode == DateDefaultMode)
            {
                NSString* str = [[NSString alloc]init];
                NSArray* weekdateStrs = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
                int i = 1;
                int maxIndex = vc.selectWeekdays.count;
                for (NSNumber* weekday in vc.selectWeekdays) {
                     str = [str stringByAppendingString:weekdateStrs[weekday.integerValue]];
                    if (i < maxIndex) {
                        str = [str stringByAppendingString:@","];
                    }
                    i++;
                }
                self.dateStr = str;
            }
           else if(vc.dateMode == DateEveryDayMode)
               self.dateStr = @"每天";
            else if(vc.dateMode == DateWordDayMode)
                self.dateStr = @"工作日";
            else
                self.dateStr = @"周末";
            //
            _dateCell.detailTextLabel.text = self.dateStr;

        }
        else
        {
            self.startDateStr = vc.startDateStr;
            self.endDateStr = vc.endDateStr;
            _dateCell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@",vc.startDateStr,vc.endDateStr];
            
            
            self.startDate = [self getDateByString:vc.startDateStr];
            self.endDate = [self getDateByString:vc.endDateStr];
        }
        
    }
    else if ([segue.identifier  isEqual: @"unwindDaypart"])
    {
        DaypartSettingController* vc =   (DaypartSettingController*)segue.sourceViewController;
        if (vc.isAllDay) {
            _daypartCell.detailTextLabel.text = @"全部";
        }
        else
        {
             _daypartCell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@",vc.startTimeStr,vc.endTimeStr];
        }
    }
    [self.tableView reloadData];
    NSLog(@"from yellow vc %@",segue.sourceViewController);


}

- (NSDate*)getDateByString:(NSString*)str
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy.MM.dd"];
    NSDate* inputDate = [inputFormatter dateFromString:str];

    return inputDate;
}
- (NSString*)getStringByDate:(NSDate*)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *str = [outputFormatter stringFromDate:date];

    return str;
}

@end
