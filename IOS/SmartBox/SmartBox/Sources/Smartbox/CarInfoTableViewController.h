//
//  CarInfoTableViewController.h
//  Smartbox
//
//  Created by wangsl-iMac on 15/3/24.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInfoTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *carBrandLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCarDate;
@property (weak, nonatomic) IBOutlet UILabel *insuranceDataLabel;
@property(nonatomic, strong)NSDictionary * personInfo;
@end
