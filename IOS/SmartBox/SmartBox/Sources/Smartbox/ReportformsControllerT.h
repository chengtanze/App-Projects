//
//  ReportformsControllerT.h
//  Smartbox
//
//  Created by Mesada on 14/12/15.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNLineChart.h"
#import "PNDbarChart.h"
#import "PNbarChart.h"
#import "HUBViewController.h"
@interface ReportformsControllerT : HUBViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *dataView;
- (IBAction)preLogClick:(id)sender;
- (IBAction)nextLogClick:(id)sender;


@end
