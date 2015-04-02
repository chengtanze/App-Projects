//
//  mapLogViewController.h
//  Smartbox
//
//  Created by Mesada on 14/11/4.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PVCharacter.h"
#import <MAMapKit/MAMapKit.h>
#import "DACircularProgressView.h"
#import "HUBViewController.h"
@interface mapLogViewController : HUBViewController <MAMapViewDelegate>

@property (strong, nonatomic) IBOutlet MAMapView *mapView;


@property (strong, nonatomic) IBOutlet UIView *tipView;
@property (strong, nonatomic) IBOutlet UILabel *overspeedCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *ACCCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *brakesCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *sharpturnCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *idleCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *fatigueCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *mileageLabel;
@property (strong, nonatomic) IBOutlet UILabel *speedAvgLabel;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet DACircularProgressView *progressView;

@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIView *travelDataView;
@property (strong, nonatomic) IBOutlet UIButton *screenFullView;
- (IBAction)preLogClick:(id)sender;
- (IBAction)NextLogClick:(id)sender;


//data
@property (nonatomic, strong) NSDictionary *lastDriveRecord;//最后一次驾驶记录
@property (nonatomic, strong) NSDictionary *lastAbnormal;
@property (nonatomic, strong) NSArray *lasttrackList;
//data 针对log
@property(strong, nonatomic)  NSArray *dataSouce;
@property(nonatomic)  int dataIndex;
@end
