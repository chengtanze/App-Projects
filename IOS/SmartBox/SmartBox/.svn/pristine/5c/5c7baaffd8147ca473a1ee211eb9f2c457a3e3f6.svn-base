//
//  electronicFenceController.m
//  Smartbox
//
//  Created by Mesada on 14/12/18.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "electronicFenceController.h"
#import "FenceCharacter.h"
#import <AMapSearchKit/AMapSearchAPI.h>
#import "APIKey.h"

@interface electronicFenceController ()
@property (nonatomic, strong) AMapSearchAPI *search;
/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;
@end

@implementation electronicFenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CLLocationCoordinate2D startCoordinate={23.095093,113.652915};
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(startCoordinate, 10000, 10000);
    
    self.mapView.region = region;
    
    [self addCharacterLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)addCharacterLocation { 

    FenceCharacter *electronic = (FenceCharacter *)[FenceCharacter circleWithCenterCoordinate:CLLocationCoordinate2DMake(23.095093,113.652915)
                                                                          radius:500];
    electronic.color = [UIColor blueColor];

    [self.mapView addOverlay:electronic];
}


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:FenceCharacter.class]) {
        MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        circleView.strokeColor = [(FenceCharacter *)overlay color];
        circleView.fillColor =  [(FenceCharacter *)overlay color];
        circleView.lineWidth = 1;
      circleView.alpha = 0.1;
        return circleView;
    }
    
    return nil;
}


@end
