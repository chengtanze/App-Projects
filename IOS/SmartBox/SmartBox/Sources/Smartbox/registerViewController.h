//
//  registerViewController.h
//  Smartbox
//
//  Created by Mesada on 14/11/28.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickMarkViewController.h"
@interface registerViewController : UIViewController<didAVCaptureQuickMarkdelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *SNtextFieldView;
@property (strong, nonatomic) IBOutlet UIScrollView *backScrollView;
-(IBAction)handleViewTap:(UIGestureRecognizer*)tapGr;
@end
