//
//  RoadRescueController.h
//  Smartbox
//
//  Created by Mesada on 14/12/26.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "checkButton.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "phoneNumController.h"

@interface RoadRescueController : UITableViewController<AMapSearchDelegate,SetphoneDelegate>
@property (strong, nonatomic) IBOutletCollection(checkButton) NSArray *rescueBts;
- (IBAction)selectRescueType:(id)sender;
@property (strong, nonatomic) IBOutlet UITableViewCell *CurrentDateTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *CarNumberCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *phoneNumberCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *addressCell;

@property (nonatomic)  CLLocationCoordinate2D carCoordinate;
- (IBAction)requsetHelp:(id)sender;

@end
