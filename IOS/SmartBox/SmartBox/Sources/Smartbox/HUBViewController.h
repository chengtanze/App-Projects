//
//  BaseViewController.h
//  inCarTime
//
//  Created by wusj on 13-7-17.
//  Copyright (c) 2013年 车友互联. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface HUBViewController : UIViewController {
    MBProgressHUD *hudb;
}

//- (void)back;
- (void)showHUB:(NSString *)mes;
- (void)showLoadingHUB:(NSString *)message;
- (void)hideHUD;

@end
