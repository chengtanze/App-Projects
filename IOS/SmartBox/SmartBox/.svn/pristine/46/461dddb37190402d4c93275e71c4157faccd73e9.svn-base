//
//  AppDelegate.m
//  Smartbox
//
//  Created by Mesada on 14-10-16.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "AppDelegate.h"
#import "asyncCoreDataWrapper.h"
#import "MyTabBarController.h"
#import "TheUserManager.h"
#import "TheTCPClient.h"
#import "LoginViewController.h"
#import "MyTabBarController.h"

#import "discoverController.h"

#import "APIKey.h"
#import <MAMapKit/MAMapKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //用以下代码 打开沙盒目录
[MAMapServices sharedServices].apiKey = (NSString *)APIKey;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",paths[0]);
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor]}            forState:UIControlStateNormal];
    
       [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:.1 green:.75 blue:.1 alpha:1.0]}            forState:UIControlStateSelected];
    
//        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"IowanOldStyle-Italic" size:18]}            forState:UIControlStateNormal];
  
     [[CoreDataDAO instance] setupEnvModel:@"Smartbox" DbFile:@"Smartbox.sqlite"];
    
    //
    
    
    NSUserDefaults* theUserDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger lastLoginState = [theUserDefaults integerForKey:LastUserLoginState];
    BOOL savePwd = [[NSUserDefaults standardUserDefaults] boolForKey:RememberPasswdState];
    BOOL isLauch = false;
    if (lastLoginState == 1 && savePwd)
        isLauch = FALSE;
    else
        isLauch = TRUE;
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     //debug

    
    MyTabBarController *tabController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainTabBar"];

//if (isLauch)
    //debug bobo
    if(true)
    {
        UINavigationController *NavloginCtr = [mainStoryboard instantiateViewControllerWithIdentifier:@"Login"];
        NSLog(@"%@",NavloginCtr.topViewController);
        LoginViewController* loginCtr = (LoginViewController*)NavloginCtr.topViewController;
        loginCtr.toViewCtr = tabController;
        _window.rootViewController = NavloginCtr;
    }
    else{
           _window.rootViewController = tabController;     
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     theLastGotoBack = [NSDate timeIntervalSinceReferenceDate];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    MyTabBarController *rootctr = (MyTabBarController*)_window.rootViewController;
//    [rootctr theApplicationDidBecomeActiveWithLauch];
    
    
    if (theLastGotoBack > 0.0) {
        if ([NSDate timeIntervalSinceReferenceDate] - theLastGotoBack < 60.0) {
            if ([[TheTCPClient getInstance] isConnected]) {
                return;
            } else {
                NSLog(@"The TheTCPClient is disconnected.");
            }
        } else {
            NSLog(@"More than 60s in backgroud.");
        }
    }
    
    
    [[TheUserManager defaultUserManager] resetSate];
    [[TheTCPClient getInstance] reset];
    //断网重新登陆
    if ([_window.rootViewController respondsToSelector:@selector(theApplicationDidBecomeActiveWithLauch)]) {
        [_window.rootViewController performSelector:@selector(theApplicationDidBecomeActiveWithLauch) withObject:nil ];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSError *error = nil;
    if ([[CoreDataDAO instance].bgObjectContext hasChanges]) {
        [[CoreDataDAO instance].bgObjectContext save:&error];
    }
}

@end
