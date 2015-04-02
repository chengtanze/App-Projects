//
//  HUBTableViewController.h
//  Smartbox
//
//  Created by Mesada on 15/3/24.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface HUBTableViewController : UITableViewController
{
    MBProgressHUD *hudb;
}

- (void)showHUB:(NSString *)mes;
- (void)showLoadingHUB:(NSString *)message;
- (void)hideHUD;


@end
