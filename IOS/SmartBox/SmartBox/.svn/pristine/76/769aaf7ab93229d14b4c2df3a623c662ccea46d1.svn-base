//
//  HUBTableViewController.m
//  Smartbox
//
//  Created by Mesada on 15/3/24.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "HUBTableViewController.h"

@interface HUBTableViewController ()

@end

@implementation HUBTableViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)loadView {
    [super loadView];
}
- (void)showHUB:(NSString *)mes
{
    if (hudb) {
        [hudb removeFromSuperViewOnHide];
        hudb.hidden = YES;
        hudb = nil;
    }
    hudb = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudb.customView = [[UIImageView alloc] init];
    hudb.mode = MBProgressHUDModeCustomView;
    hudb.labelText = mes;
    [hudb hide:YES afterDelay:2];
}


-(void)showLoadingHUB:(NSString *)message
{
    if (hudb) {
        [hudb removeFromSuperViewOnHide];
        hudb = nil;
    }
    hudb = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudb.labelText = message;
}

- (void)hideHUD
{
    if (hudb) {
        hudb.hidden = YES;
        hudb = nil;
    }
}


@end
