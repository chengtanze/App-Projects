//
//  MyTabBarController.h
//  Smartbox
//
//  Created by Mesada on 14-10-16.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface MyTabBarController : UITabBarController{


    MBProgressHUD *HUD;
}

- (void)theApplicationDidBecomeActiveWithLauch;

- (void)showMessge:(NSString *)mes;
- (void)showLoadingMessage:(NSString *)message;
- (void)hideLoading;
@end
