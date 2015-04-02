//
//  PKListTotalScoreTableViewController.h
//  Smartbox
//
//  Created by wangsl-iMac on 15/3/10.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface PKListTotalScoreTableViewController : UITableViewController
{
    MBProgressHUD* HUD;
}
@property(nonatomic, strong)NSArray * userInfo;
@end
