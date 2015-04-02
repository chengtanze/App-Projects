//
//  phoneNumController.h
//  Smartbox
//
//  Created by Mesada on 14/12/26.
//  Copyright (c) 2014年 mesada. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol SetphoneDelegate <NSObject>
@optional
- (void)Setphone:(NSString*)phonenum userIdentifier:(NSString*)Identifier;
@end

@interface phoneNumController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (weak,nonatomic) id<SetphoneDelegate> delegate;
@property (strong, nonatomic) NSString* userIdentifier;
- (IBAction)save:(id)sender;
@end
