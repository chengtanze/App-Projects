//
//  SecurityCodeViewController.m
//  Smartbox
//
//  Created by Mesada on 14/11/17.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "SecurityCodeViewController.h"
#import "RetrievePwdViewController.h"
#import "PublicFunction.h"
#import "AFAppDotNetAPIClient.h"
#import "GDataXMLNode.h"

@interface SecurityCodeViewController ()

@end

@implementation SecurityCodeViewController

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
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RetrievePwdViewController * pwdController = segue.destinationViewController;
    pwdController.phontNumber = self.phoneNumView.text;
}

- (IBAction)getSecruityCode:(id)sender {

    
//    测试键盘debug bobo
      [self performSegueWithIdentifier:@"Segue_RetrievePwd" sender:self];
    return;
    
    if (_phoneNumView.text.length>0) {
        if ([PublicFunction isPhoneNum:_phoneNumView.text]) {
            [_phoneNumView resignFirstResponder];
            
            if (HUD) {
                [HUD removeFromSuperview];
                HUD = nil;
            }
            HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUD.labelText = @"获取验证码中...";
            [HUD show:YES];
            //发送请求
            [[AFAppDotNetAPIClient sharedClient] getValiateCodeRequest:_phoneNumView.text complete:^(NSString *responseString, NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (error) {
                    
                    [PublicFunction showMessage:@"网络错误，请稍后重试"];
                }
                else{
                    
                    NSError *error;
                    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
                    if (doc != nil)
                    {
                        NSArray *arr = [doc nodesForXPath:@"//resultCode" error:nil];
                        GDataXMLElement *firstName;
                        if ([arr count] == 1)
                        {
                            firstName = (GDataXMLElement *) [arr objectAtIndex:0];
                            if ([[firstName stringValue] isEqual:@"0"]) {
                                arr = [doc nodesForXPath:@"//mobileNo" error:nil];
                                if ([arr count] == 1) {
                                    firstName = (GDataXMLElement *) [arr objectAtIndex:0];
                                    if ([[firstName stringValue] isEqualToString:@"true"]) {
//                                        [self getValidCode]; //不知道为obd里面为什么要调用这个，感觉会递归（bobo）
                                        return;
                                    } else {
                                        arr = [doc nodesForXPath:@"//msg" error:nil];
                                        NSString *msgStr = @"该号码不可用.";
                                        if ([arr count]==1) {
                                            firstName = (GDataXMLElement *) [arr objectAtIndex:0];
                                            if ([firstName stringValue].length>0) {
                                                msgStr = [firstName stringValue];
                                            }
                                        }
                                        [PublicFunction showMessage:msgStr];
                                        return;
                                    }
                                }
                                [self performSegueWithIdentifier:@"Segue_RetrievePwd" sender:self];
                            } else if ([[firstName stringValue] isEqual:@"9006"]) {
                                [PublicFunction showMessage:@"请求过于频繁,请稍后再试."];
                            } else if ([[firstName stringValue] isEqual:@"9009"]) {
                                [PublicFunction showMessage:@"系统异常"];
                            }
                        }
                    }
                   
                }
            }];
        } else {
            [PublicFunction showMessage:@"手机号码格式不正确!"];
        }
    } else {
        [PublicFunction showMessage:@"请填写手机号码!"];
    }
}


@end
