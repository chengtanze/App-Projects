//
//  registerViewController.m
//  Smartbox
//
//  Created by Mesada on 14/11/28.
//  Copyright (c) 2014年 mesada. All rights reserved.
//
#import "PCHHeader.h"
#import "registerViewController.h"

@interface registerViewController (){
    CGFloat keyboardHeight;
    UITextField* activeField;
}
@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.NavigationBarHidden = FALSE;
    [self registerForKeyboardNotifications];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self removeRegisterForkeyboardNotifications];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    QuickMarkViewController* markviewController = segue.destinationViewController;
    markviewController.delegate = self;
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

-(IBAction)handleViewTap:(UIGestureRecognizer*)tapGr
{
    [self returnKey];
}

- (void)returnKey
{
    [activeField resignFirstResponder];
}

#pragma mark --UITextFieldDelegate
// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    [_backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
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



#pragma mark -- didAVCaptureQuickMarkdelegate
-(void)didAVCaptureQuickMark:(NSString*)code
{
    [self.SNtextFieldView setText:code];
}
@end
