//
//  ServiceViewController.h
//  Smartbox
//
//  Created by Mesada on 15/3/25.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *serviceStatusText;
@property (strong, nonatomic) IBOutlet UIImageView *BkImage;
@property (strong, nonatomic) IBOutlet UIButton *experienceBtn;
@property (strong, nonatomic) NSString* statueCode;
@property (strong, nonatomic) NSString* serviceId;
- (IBAction)goExperience:(id)sender;
@end
