//
//  PersonalInfoTableViewController.h
//  Smartbox
//
//  Created by wangsl-iMac on 15/3/12.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInfoTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *userSexLabel;

@property(nonatomic, strong)NSDictionary * personInfo;

@end
