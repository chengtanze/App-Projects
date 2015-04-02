//
//  SecondViewController.h
//  Smartbox
//
//  Created by Mesada on 14-10-16.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface TravelViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,AMapSearchDelegate>
@property (strong, nonatomic) IBOutlet UILabel *mileageView;
@property (strong, nonatomic) IBOutlet UILabel *cumulativeTimeView;
@property (strong, nonatomic) IBOutlet UILabel *maxSpeedView;
//
@property(strong, nonatomic)  NSString *startDate;
@property (strong, nonatomic) IBOutlet UIView *headView;




@end

