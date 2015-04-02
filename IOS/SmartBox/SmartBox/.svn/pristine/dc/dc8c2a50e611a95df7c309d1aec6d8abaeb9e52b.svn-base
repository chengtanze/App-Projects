//
//  phoneNumController.m
//  Smartbox
//
//  Created by Mesada on 14/12/26.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "phoneNumController.h"
#import "PublicFunction.h"
@interface phoneNumController ()

@end

@implementation phoneNumController

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
    [self.textField becomeFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)save:(id)sender {
    
    if ([PublicFunction isPhoneNum:self.textField.text]) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(Setphone:userIdentifier:)])
        {
            [self.delegate Setphone:self.textField.text userIdentifier:_userIdentifier];
        }
    }
    else{
        [PublicFunction showMessage:@"请输入正确的电话号码"];
    }
        
}
@end
