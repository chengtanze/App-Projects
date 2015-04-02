//
//  Alert_dataSettingController.m
//  Smartbox
//
//  Created by Mesada on 15/1/4.
//  Copyright (c) 2015年 mesada. All rights reserved.
//
#import "PCHHeader.h"
#import "Alert_dataSettingController.h"
#import "choiceCell.h"
#import "dateModeCell.h"
#import "timePick.h"
#import "AlertViewController.h"

#define REPEATCELL @"repeatCell"
#define WEEKDAYSCELL @"weekdaysCell"
#define DATECELL @"dateCell"
#define TIMECELL @"timeCell"
#define DAYCELL @"dayCell"


#define NBEGINTIME 0
#define NENDTIME   1
#define TIMESCETION 1
#define DATESECTION 2
#define DATEMODE    1
@interface Alert_dataSettingController ()
{
    NSArray* weekdateStrs;
    timePick* pickView;
    NSInteger curSelectIndex;
}

@end

@implementation Alert_dataSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _isRepeat = true;
    weekdateStrs = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    _selectWeekdays = [[NSMutableArray alloc]init];
    _dateMode = DateEveryDayMode;//debug bobo
    [self setSelectWeekdaysByMode:_dateMode];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    UIViewController *vc = self.navigationController.topViewController;
    if ([AlertViewController class] == [vc class])
    {
        [self performSegueWithIdentifier:@"unwindDate" sender:self];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (_isRepeat) {
        return 3;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (_isRepeat) {
        switch (section) {
            case 0:
                return 1; break;
            case 1:
                return 1; break;
            case 2:
                return 7; break;
        }
    }
    else{
         switch (section) {
            case 0:
                return 1; break;
            case 1:
                return 2; break;
         }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    UITableViewCell *cell;
    if (_isRepeat) {
        switch (indexPath.section) {
            case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:REPEATCELL forIndexPath:indexPath];
            }
                break;
            case 1:
            {
              dateModeCell *cell = (dateModeCell*)[tableView dequeueReusableCellWithIdentifier:DATECELL];
                cell.selectIndex = _dateMode;//debug bobo 后期修改
              return cell;
            }
                break;
            case 2:
            {
                choiceCell* daycell = (choiceCell*)[tableView dequeueReusableCellWithIdentifier:WEEKDAYSCELL forIndexPath:indexPath];
                daycell.dayView.text = weekdateStrs[indexPath.row];
                
                BOOL bselect = [_selectWeekdays containsObject:[NSNumber numberWithInteger:indexPath.row]];
                daycell.checkView.selected = bselect;
                
                return  daycell;
                
            }
                break;
            default:
               break;
        }
    }
    else{
        switch (indexPath.section) {
            case 0:
            {
//                  static NSString* cellIdentifier = @"repeatCell";
                cell = [tableView dequeueReusableCellWithIdentifier:REPEATCELL];
            }
                break;
            case 1:
            {
                 cell = [tableView dequeueReusableCellWithIdentifier:TIMECELL forIndexPath:indexPath];
                if (indexPath.row == 0) {
                      cell.textLabel.text = @"开始时间";
                }
                else{
                    cell.textLabel.text = @"结束时间";
                }
               
            }
                 break;
            default:
               break;
        }
    }
   
    
    return cell;
}

- (IBAction)doRepeat:(id)sender {
    self.isRepeat = !self.isRepeat;
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (!_isRepeat) {
         if (indexPath.section == 1) {
//             UIView* maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
//             maskView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:.5];
             pickView = [[[NSBundle mainBundle]loadNibNamed:@"timePick" owner:self options:nil]objectAtIndex:0];
             pickView.frame = CGRectMake(0, screenHeight, pickView.frame.size.width, pickView.frame.size.height);
             pickView.delegate = self;
             pickView.datePick.datePickerMode = UIDatePickerModeDate;
//             [maskView addSubview:pickView];
             [self.view setUserInteractionEnabled:NO];
             [[UIApplication sharedApplication].keyWindow addSubview:pickView];
             [UIView animateWithDuration:0.5 animations:^(void){
                 pickView.frame = CGRectMake(0, 0, pickView.frame.size.width, pickView.frame.size.height);
             }];
             curSelectIndex = indexPath.row;
         }
    }
     else if (indexPath.section == DATESECTION)
    {
        NSNumber* weekNumber = [NSNumber numberWithInteger:indexPath.row];
        BOOL bSelect = [_selectWeekdays containsObject:weekNumber];
        if (bSelect)
        {
            [_selectWeekdays removeObject:weekNumber];
        }
        else
        {
            
            [_selectWeekdays addObject:weekNumber];
            //排序是为了后面refleshDateMode 比较的方便
            [_selectWeekdays sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                if ([obj1  integerValue] > [obj2 integerValue]) {
                    return NSOrderedDescending;
                }
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return  NSOrderedAscending;
                }
                return NSOrderedSame;
            }];
        }
        [self refleshDateMode];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)refleshDateMode
{
    if (_selectWeekdays.count == 7) {
        _dateMode = DateEveryDayMode;
    }
    else if ([_selectWeekdays isEqualToArray:@[[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:2],[NSNumber numberWithInteger:3],[NSNumber numberWithInteger:4]]]) {
        _dateMode = DateWordDayMode;
    }
    else if ([_selectWeekdays isEqualToArray:@[[NSNumber numberWithInteger:5],[NSNumber numberWithInteger:6]]])
    {
        _dateMode = DateWeekenMode;
    }
    else
    {
        _dateMode = DateDefaultMode;
    }

//    if (_dateMode != DateDefaultMode) {
//        UIButton* bt =  [_DateTypeBts objectAtIndex:_dateMode];
//        bt.selected = YES;
        dateModeCell* cell = (dateModeCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:DATEMODE]];
        if (cell) {
            [cell setSelectIndex:_dateMode];
        }
//    }
}

- (IBAction)selectDateType:(id)sender {
    // sender.tag
    UIButton* bt = (UIButton*)sender;
    NSInteger index = bt.tag- 2000;
    [self setSelectWeekdaysByMode:index];
}

-(void)setSelectWeekdaysByMode:(DateMode)mode{
    _dateMode = mode;
    switch (mode) {
        case DateEveryDayMode://每天
        {
            [self setSelectDate:@[[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:2],[NSNumber numberWithInteger:3],[NSNumber numberWithInteger:4],[NSNumber numberWithInteger:5],[NSNumber numberWithInteger:6]]];
        }
            break;
        case DateWordDayMode://工作日
            [self setSelectDate:@[[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:2],[NSNumber numberWithInteger:3],[NSNumber numberWithInteger:4]]];
            
            break;
        case DateWeekenMode://周末
            [self setSelectDate:@[[NSNumber numberWithInteger:5],[NSNumber numberWithInteger:6]]];
            break;
        default:
            break;
    }
}

//选择日期
-(void)setSelectDate:(NSArray*)weekDays
{
    _selectWeekdays = [NSMutableArray arrayWithArray:weekDays];
    for (int i=0; i<7; ++i) {
        NSIndexPath* indexpath = [NSIndexPath
                                  indexPathForRow:i inSection: DATESECTION];
        choiceCell* cell = (choiceCell*)[self.tableView cellForRowAtIndexPath:indexpath];
        cell.checkView.selected = FALSE;
    }
    
    for (NSNumber* indexNum in weekDays) {
        NSIndexPath* indexpath = [NSIndexPath
                                  indexPathForRow:indexNum.integerValue inSection: DATESECTION];
       choiceCell* cell = (choiceCell*)[self.tableView cellForRowAtIndexPath:indexpath];
        cell.checkView.selected = TRUE;
    }

}


- (BOOL) navigationBar: (UINavigationBar * ) navigationBar
         shouldPopItem: (UINavigationItem * ) item {
    //在此处添加点击back按钮之后的操作代码
     NSLog(@"11111111111");
    return NO;
}

#pragma mark -- timePickdelegate
-(void)didClickExitbt:(bool)isCanel
{
    if(!_isRepeat)
    {
        if (!isCanel) {//确定
            NSDateFormatter *formattor = [[NSDateFormatter alloc] init];
            formattor.dateFormat = @"yyyy.MM.dd";
            NSString *timestamp = [formattor stringFromDate:pickView.datePick.date];
            NSLog(@"%@",timestamp);
            UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:curSelectIndex inSection:TIMESCETION]];
            cell.detailTextLabel.text =timestamp;
            if (curSelectIndex == 0) {
                self.startDateStr = timestamp;
            }
            else{
                 self.endDateStr = timestamp;
            }
        }
        
    }

    [UIView animateWithDuration:0.5 animations:^(void){
        pickView.frame = CGRectMake(0, screenHeight, pickView.frame.size.width, pickView.frame.size.height);}
  
     completion:^(BOOL finished){
                               if (finished) {
                                   [self.view setUserInteractionEnabled:YES];
                                   [pickView removeFromSuperview];
                               }}];
}

@end
