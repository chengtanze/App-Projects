//
//  timePick.h
//  Smartbox
//
//  Created by Mesada on 15/1/5.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol timePickdelegate <NSObject>

@optional
-(void)didClickExitbt:(bool)isCanel;
@end

@interface timePick : UIView

- (IBAction)clickConfirm:(id)sender;
- (IBAction)clickCancel:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePick;
@property(nonatomic,weak)id<timePickdelegate>delegate;
@end

