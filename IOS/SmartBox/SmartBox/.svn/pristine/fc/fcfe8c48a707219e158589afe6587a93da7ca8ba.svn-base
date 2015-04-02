//
//  InjuredRescueLog.h
//  Smartbox
//
//  Created by Mesada on 15/3/26.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUBViewController.h"

@interface InjuredCellData : NSObject
@property(strong,nonatomic) NSString* desc;
@property(strong,nonatomic) NSString* timestr;
@property  BOOL done;
@end


@interface InjuredRescueLog : HUBViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) NSArray* rescueLogSource;
@property(strong,nonatomic) NSArray* dataSource;//里面放InjuredCellData
@property int rescueId;
- (IBAction)handelGestureRecognizers:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *commentImageViews;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *commentLabels;

@end
