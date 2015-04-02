//
//  SecurityCodeViewController.h
//  Smartbox
//
//  Created by Mesada on 14/11/17.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SecurityCodeViewController : UIViewController
{
    MBProgressHUD* HUD;
}
@property (strong, nonatomic) IBOutlet UITextField *phoneNumView;
- (IBAction)getSecruityCode:(id)sender;
- (IBAction)textChangeAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *securityBtn;
@property (strong,nonatomic) UIColor* disableColor;
@property (strong,nonatomic) UIColor* activeColor;
@end
