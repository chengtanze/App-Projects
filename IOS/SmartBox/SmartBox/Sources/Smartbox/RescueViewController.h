//
//  RescueViewController.h
//  Smartbox
//
//  Created by Mesada on 14/12/22.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIKey.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "HUBViewController.h"
@interface RescueViewController : HUBViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,MAMapViewDelegate,AMapSearchDelegate>
@property (strong, nonatomic) IBOutlet MAMapView *mapView;
@property (strong, nonatomic) IBOutlet UITableView *tabView;
@property (nonatomic)  CLLocationCoordinate2D carCoordinate;
@property (nonatomic)  CLLocationCoordinate2D personCoordinate;
@property (strong, nonatomic) IBOutlet UIButton *carBtn;
@property (strong, nonatomic) IBOutlet UIButton *personBtn;
@property (strong, nonatomic) IBOutlet UILabel *carAddressLabel;

- (IBAction)MoveToCarplace:(id)sender;
- (IBAction)MoveToMyPlace:(id)sender;

@end
