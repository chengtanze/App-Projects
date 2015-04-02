//
//  LoginViewController.h
//  Smartbox
//
//  Created by Mesada on 14/11/12.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "LoginManager.h"
@interface LoginViewController : UIViewController<LoginManagerDelegate>{
  MBProgressHUD *HUD;
  BOOL          isSavePwd;

}

- (IBAction)loginClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *backScrollView;
@property (strong, nonatomic) IBOutlet UITextField *txtUserNameView;
@property (strong, nonatomic) IBOutlet UITextField *txtPwdView;
@property (strong,nonatomic) UIViewController* toViewCtr;
- (IBAction)saverPwd:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *savePwdView;
@property (strong, nonatomic) IBOutlet UIView *staticView1;
@property (strong, nonatomic) IBOutlet UIView *staticView2;
- (IBAction)handelTap:(UITapGestureRecognizer *)sender;
@end
