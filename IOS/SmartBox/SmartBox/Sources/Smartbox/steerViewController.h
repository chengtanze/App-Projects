//
//  steerViewController.h
//  Smartbox
//
//  Created by Mesada on 14/12/23.
//  Copyright (c) 2014年 mesada. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "APIKey.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface steerViewController : UIViewController<MAMapViewDelegate,AMapSearchDelegate>
@property (strong, nonatomic) IBOutlet MAMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *carAddress;
@property (strong, nonatomic) IBOutlet UIScrollView *backScrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *timeIntervalView;
@property (strong, nonatomic) IBOutlet UILabel *mileageLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *averageSpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *overspeedCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *zoombt;
@property (strong, nonatomic) IBOutlet UILabel *timeunitLabel;

//- (IBAction)test:(id)sender;

@end