//
//  RetrievePwdViewController.m
//  Smartbox
//
//  Created by Mesada on 14/11/17.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "RetrievePwdViewController.h"
#import "PublicFunction.h"
#import "AFAppDotNetAPIClient.h"
#import "ChangePwdSucessController.h"

@interface RetrievePwdViewController (){
    UITextField* activeField;
    CGFloat keyboardHeight;
}

@end

@implementation RetrievePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.phoneNumView.text = _phontNumber;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self removeRegisterForkeyboardNotifications];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)returnKey
{
    [activeField resignFirstResponder];
}

- (IBAction)finishClick:(id)sender {
//
    [self performSegueWithIdentifier:@"changePwdsucess" sender:self];
    return;
//
    [self returnKey];
    NSString *strValidCode = [_securityCodeView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *strPassword=[_pwdView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"validCode = [%@],pwd = [%@]",strValidCode,strPassword);
    if (strValidCode.length>0) {
        
            if ((strPassword.length<6||strPassword.length>16)) {
                [PublicFunction showMessage:@"密码请输入6-16位数字或字母."];
                return;
            }
            
            if (![PublicFunction isAlphaNumeric:strPassword]) {
                [PublicFunction showMessage:@"密码请输入6-15位数字或字母"];
                return;
            }
        
        
            [[AFAppDotNetAPIClient sharedClient]getNowPwd:strPassword validcode:strValidCode phoneNum:_phontNumber complete:^(NSString *xmlstring, NSError *error) {
                if (error) {
                    [PublicFunction showMessage:error.domain];

                }
                else{
                   [self performSegueWithIdentifier:@"changePwdsucess" sender:self];
                }
            }];
        
    } else {
        [PublicFunction showMessage:@"请输入验证码."];
    }
    
}


- (void)dealloc {
    NSLog(@"RetrievePwdViewController  dealloc");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ChangePwdSucessController* sucessController = segue.destinationViewController;
    sucessController.phoneNum = _phontNumber;
    sucessController.pwdNum   = _pwdView.text;
}

-(IBAction)handleViewTap:(UIGestureRecognizer*)tapGr
{
    [self returnKey];
}


- (void)registerForKeyboardNotifications

{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)removeRegisterForkeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardWasShown:(NSNotification*)aNotification

{
    
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    _backScrollView.contentInset = contentInsets;
    
    _backScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    
    // Your application might not need or want this behavior.
    
    CGRect aRect = self.view.frame;
    
    keyboardHeight = kbSize.height;
//    NSLog(@"keyboardHeight = [%f]",keyboardHeight);
    aRect.size.height -= kbSize.height;

    
    CGPoint absolutePoint = [activeField convertPoint:CGPointMake(0, activeField.frame.size.height) toView:self.view];
//    NSLog(@"x=%f，y=%f offset=%f", absolutePoint.x,absolutePoint.y,_backScrollView.contentOffset.y);

    if (!CGRectContainsPoint(aRect, absolutePoint/*activeField.frame.origin*/) ) {
        
        CGFloat BottomPointY  = absolutePoint.y-(screenHeight - kbSize.height)+10;
        
        CGPoint scrollPoint = CGPointMake(0.0, BottomPointY);
         NSLog(@"offset=%f", BottomPointY);
        [_backScrollView setContentOffset:scrollPoint animated:YES];
        
    }
    
}

// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    [_backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    CGPoint scrollPoint = CGPointMake(0.0, -_backScrollView.contentOffset.y);
//    
//    [_backScrollView setContentOffset:scrollPoint animated:YES];
//     NSLog(@"offset=%f", _backScrollView.contentOffset.y);
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    
//    _backScrollView.contentInset = contentInsets;
//    
//    _backScrollView.scrollIndicatorInsets = contentInsets;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _securityCodeView) {
        [_pwdView becomeFirstResponder];
        [self performSelector:@selector(moveUp) withObject:nil afterDelay:0.1];
        return NO;
    }

    return [activeField resignFirstResponder];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    activeField = textField;
    NSLog(@"activeField=%@",activeField);
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField

{
    
    activeField = nil;
    
}

- (IBAction)displayPwd:(UISwitch*)sender {
    if (sender.on) {
        _pwdView.secureTextEntry = FALSE;
    }
    else
    {
        _pwdView.secureTextEntry = TRUE;

    }
}

//点击键盘next按钮的时候scrollview向上移动，避免遮挡
-(void) moveUp
{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0);
    
    _backScrollView.contentInset = contentInsets;
    
    _backScrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    
    aRect.size.height -= keyboardHeight;
    
    CGPoint absolutePoint = [activeField convertPoint:CGPointMake(0, activeField.frame.size.height) toView:self.view];
    NSLog(@"x=%f，y=%f offset=%f", absolutePoint.x,absolutePoint.y,_backScrollView.contentOffset.y);
    
    if (!CGRectContainsPoint(aRect, absolutePoint/*activeField.frame.origin*/) ) {
        
        CGFloat BottomPointY  = absolutePoint.y-(screenHeight - keyboardHeight)+10;
        
        CGPoint scrollPoint = CGPointMake(0.0, BottomPointY);
        NSLog(@"offset=%f", BottomPointY);
        [_backScrollView setContentOffset:scrollPoint animated:YES];
        
    }
}
@end
