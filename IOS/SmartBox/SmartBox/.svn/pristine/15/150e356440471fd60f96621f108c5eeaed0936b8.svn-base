//
//  ChangePwdSucessController.m
//  Smartbox
//
//  Created by Mesada on 14/12/2.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "ChangePwdSucessController.h"
#import "LoginViewController.h"

@interface ChangePwdSucessController ()

@end

@implementation ChangePwdSucessController
@synthesize  pwdNum;
@synthesize  phoneNum;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:TRUE];
    LoginViewController* loginController = (LoginViewController*)self.navigationController.viewControllers[0];
    if (loginController) {
        loginController.txtUserNameView.text = phoneNum;
        loginController.txtPwdView.text      = pwdNum;
    }
    [loginController loginClick:nil];
   ;
}
@end
