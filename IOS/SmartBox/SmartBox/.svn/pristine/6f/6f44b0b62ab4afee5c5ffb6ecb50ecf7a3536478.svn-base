//
//  RetrievePwdViewController.h
//  Smartbox
//
//  Created by Mesada on 14/11/17.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RetrievePwdViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *phoneNumView;
@property (strong, nonatomic) IBOutlet UITextField *pwdView;
@property (strong, nonatomic) IBOutlet UITextField *securityCodeView;
@property (strong,nonatomic) NSString* phontNumber;

- (IBAction)finishClick:(id)sender;
- (void)returnKey;
-(IBAction)handleViewTap:(UIGestureRecognizer*)tapGr;
@property (strong, nonatomic) IBOutlet UIScrollView *backScrollView;
- (void)textFieldDidBeginEditing:(UITextField *)textField;

- (void)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)displayPwd:(UISwitch*)sender;
@end
