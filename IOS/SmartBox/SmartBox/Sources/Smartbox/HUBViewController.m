//
//  BaseViewController.m
//  inCarTime
//
//  Created by wusj on 13-7-17.
//  Copyright (c) 2013年 车友互联. All rights reserved.
//

#import "HUBViewController.h"

@interface HUBViewController ()

@end

@implementation HUBViewController

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
