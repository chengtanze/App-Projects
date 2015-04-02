//
//  DaypartSettingController.m
//  Smartbox
//
//  Created by Mesada on 15/1/4.
//  Copyright (c) 2015年 mesada. All rights reserved.
//
#import "PCHHeader.h"
#import "DaypartSettingController.h"
#import "AlertViewController.h"

@interface DaypartSettingController (){
    timePick* pickView;
    NSInteger curSelectIndex;
}
@end

@implementation DaypartSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    _enTimeCell.hidden = _switchView.on;
    _beginTimeCell.hidden = _switchView.on;
    
   //for debug

        
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    UIViewController *vc = self.navigationController.topViewController;
    if ([AlertViewController class] == [vc class])
    {
        [self performSegueWithIdentifier:@"unwindDaypart" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (IBAction)switchfulltime:(id)sender {
    UISwitch* switchView = (UISwitch*)sender;
    _isAllDay = switchView.on;
    
    if (switchView.on) {
        _enTimeCell.alpha = 1.0;
        _beginTimeCell.alpha = 1.0;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
            _enTimeCell.alpha = 0.0;
            _beginTimeCell.alpha = 0.0;
        }
             completion:^(BOOL finished){
                 if (finished) {
                     _enTimeCell.hidden = TRUE;
                     _beginTimeCell.hidden = TRUE;
                 }

             }
         ];
 
    }
    else{

        _enTimeCell.hidden = FALSE;
        _beginTimeCell.hidden = FALSE;
        _enTimeCell.alpha = 0.0;
        _beginTimeCell.alpha = 0.0;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^(void){
            _enTimeCell.alpha = 1.0;
            _beginTimeCell.alpha = 1.0;

        }
                         completion:^(BOOL finished){
                             if (finished) {
                          
                             }
                             
                         }
         ];

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 1) {
        pickView = [[[NSBundle mainBundle]loadNibNamed:@"timePick" owner:self options:nil]objectAtIndex:0];
        pickView.frame = CGRectMake(0, screenHeight, pickView.frame.size.width, pickView.frame.size.height);
        pickView.delegate = self;
        pickView.datePick.datePickerMode = UIDatePickerModeTime;
        [self.view setUserInteractionEnabled:NO];
        [[UIApplication sharedApplication].keyWindow addSubview:pickView];
        [UIView animateWithDuration:0.5 animations:^(void){
            pickView.frame = CGRectMake(0, 0, pickView.frame.size.width, pickView.frame.size.height);
        }];
        curSelectIndex = indexPath.row;
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }

}


#pragma mark --timepickdelegate
-(void)didClickExitbt:(bool)isCanel
{

    if (!isCanel) {//确定
        NSDateFormatter *formattor = [[NSDateFormatter alloc] init];
        formattor.dateFormat = @"HH:mm";
        NSString *timestamp = [formattor stringFromDate:pickView.datePick.date];
        NSLog(@"%@",timestamp);
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:curSelectIndex inSection:1]];
        cell.detailTextLabel.text = timestamp;
        if (curSelectIndex == 0) {
            _startTimeStr = timestamp;
        }
        else{
            _endTimeStr = timestamp;
        }
        [self.tableView reloadData];
     }
    
    [UIView animateWithDuration:0.5 animations:^(void){
        pickView.frame = CGRectMake(0, screenHeight, pickView.frame.size.width, pickView.frame.size.height);}
     
                     completion:^(BOOL finished){
                         if (finished) {
                             [pickView removeFromSuperview];
                             [self.view setUserInteractionEnabled:YES];
                         }}];
}



@end
