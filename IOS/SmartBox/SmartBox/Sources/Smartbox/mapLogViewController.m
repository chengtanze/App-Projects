//
//  mapLogViewController.m
//  Smartbox
//
//  Created by Mesada on 14/11/4.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "mapLogViewController.h"
//#import "MKStartEndAnnotationView.h"
#import "SmartAnnotation.h"
#import "CommonUtility.h"
#import "abnormalType.h"
#import "AFAppDotNetAPIClient.h"

@interface mapLogViewController ()

@end

@implementation mapLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mapView.delegate = self;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    _mapView.hidden = NO;
    
    [_screenFullView addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchDown];
   
    [_mapView bringSubviewToFront:_headView];
    [_mapView bringSubviewToFront:_travelDataView];
    [_mapView bringSubviewToFront:_screenFullView];
    
    //bobo
    UIView *maptemp = (UIView*)_mapView.subviews[0];
    CALayer*  layer =  maptemp.layer;
    NSLog(@"layer=frame [%f,%f,%f,%f]",layer.frame.origin.x,layer.frame.origin.y,layer.frame.size.width,layer.frame.size.height);
//   _mapView.frame = CGRectMake(_mapView.frame.origin.x, _mapView.frame.origin.y, _mapView.frame.size.width, 346);
//    [self getDateFromWeb];
    [self showLoadingHUB:@"正在加载"];
}

-(void)viewDidAppear:(BOOL)animated
{
//    [super viewDidAppear:animated];
//    _mapView.frame = CGRectMake(_mapView.frame.origin.x, _mapView.frame.origin.y, _mapView.frame.size.width, self.mapView.frame.size.height);
////    [super viewDidAppear:animated];
//    NSLog(@"----------[%f,%f,%f,%f]",self.mapView.frame.origin.x, self.mapView.frame.origin.y, self.mapView.frame.size.width,self.mapView.frame.size.height);
//    
//    
//    UIView *maptemp = (UIView*)_mapView.subviews[0];
//    CALayer*  layer =  maptemp.layer;
//    NSLog(@"layer=frame [%f,%f,%f,%f]",layer.frame.origin.x,layer.frame.origin.y,layer.frame.size.width,layer.frame.size.height);
////    [_mapView.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
////        NSLog(@"%@ H=%f", obj.class, obj.frame.size.height);
////    }];
    [self getDateFromWeb];
}
-(void)checkboxClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if(btn.selected)
    {
    //隐藏头部
    _headView.hidden = true;
    _tipView.frame = CGRectMake(_headView.frame.origin.x, _headView.frame.origin.y,_tipView.frame.size.width, _tipView.frame.size.height);
    }
    else{
    //显示头部
    _tipView.frame = CGRectMake(_headView.frame.origin.x, _headView.frame.origin.y+_headView.frame.size.height,_tipView.frame.size.width,_tipView.frame.size.height);
    _headView.hidden = false;
    }
}

-(void)getDateFromWeb
{
    if (_lastDriveRecord) {
        ///分数
        _scoreLabel.text = [_lastDriveRecord objectForKey:@"score"];
        _progressView.progress = _scoreLabel.text.floatValue/100;
        NSString* durationStr = [_lastDriveRecord objectForKey:@"duration"];
        NSInteger nduration = durationStr.integerValue;
        if (nduration >= 60) {
            _durationLabel.text = [NSString stringWithFormat:@"%dh%dmin",nduration/60,nduration%60];
        }
        else
        {
            _durationLabel.text = [NSString stringWithFormat:@"%dmin",nduration];
        }
        
        _mileageLabel.text = [NSString stringWithFormat:@"%.1fkm",[[_lastDriveRecord objectForKey:@"mileage"] floatValue]];
        _speedAvgLabel.text = [NSString stringWithFormat:@"%.1fkm",[[_lastDriveRecord objectForKey:@"speedAvg"] floatValue]];
        
        NSRange rang = {11,5};
        NSString* startTime = [[_lastDriveRecord objectForKey:@"startTimeConvert"] substringWithRange:rang];
        NSString* endTime = [[_lastDriveRecord objectForKey:@"endTimeConvert"] substringWithRange:rang];
        //
        self.title = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
        
        if (_lastAbnormal) {
            [self abnormalPins:[_lastAbnormal objectForKey:@"data"]];
            [self updateAbnormalCount:_lastAbnormal]; //有异常数值
        }
        if (_lasttrackList) {
            [self addRouteAndPins:_lasttrackList];
        }
        [self hideHUD];
    }
    else if(_dataSouce){
        [self getDataWithIndex:_dataIndex];
    }
    else
    {
        [self hideHUD];
    }
}


-(void) getDataWithIndex:(NSInteger) index{
    NSDictionary * DriveRecord =[_dataSouce objectAtIndex:index];
    if (DriveRecord) {
        ///分数
        _scoreLabel.text = [DriveRecord objectForKey:@"score"];
        _progressView.progress = _scoreLabel.text.floatValue/100;
        NSString* durationStr = [DriveRecord objectForKey:@"duration"];
        NSInteger nduration = durationStr.integerValue;
        if (nduration >= 60) {
            _durationLabel.text = [NSString stringWithFormat:@"%dh%dmin",nduration/60,nduration%60];
        }
        else
        {
            _durationLabel.text = [NSString stringWithFormat:@"%dmin",nduration];
        }
        
        _mileageLabel.text = [NSString stringWithFormat:@"%.1fkm",[[DriveRecord objectForKey:@"mileage"] floatValue]];
        _speedAvgLabel.text = [NSString stringWithFormat:@"%.1fkm",[[DriveRecord objectForKey:@"speedAvg"] floatValue]];
        
        
        NSRange rang = {11,5};
        NSString* startTime = [[DriveRecord objectForKey:@"startTimeConvert"] substringWithRange:rang];
        NSString* endTime = [[DriveRecord objectForKey:@"endTimeConvert"] substringWithRange:rang];
        //
        self.title = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
        
        NSString* RecordId = [DriveRecord objectForKey:@"id"];
        //发送协议
        
        //获取单次异常
        [[AFAppDotNetAPIClient sharedClient] findDriveRecordAbnormalList:RecordId  complete: ^(NSDictionary *repondDate, NSError *error)
         {
             if(nil == error)
             {
                 NSLog(@"findDriveRecordAbnormalList =%@",repondDate);
                 NSArray* arr = [repondDate objectForKey:@"data"];
                 _lastAbnormal = repondDate;
                 [self abnormalPins:arr];
             }
             else{//错误
                 
             }
         }];
        // 获取轨迹
        [[AFAppDotNetAPIClient sharedClient] getCarTrackData:[[DriveRecord objectForKey:@"startTimeConvert"]substringToIndex:18] endDate:[[DriveRecord objectForKey:@"endTimeConvert"]substringToIndex:18] complete:^(NSDictionary *repondData, NSError *error)
         {
             NSArray* arr = [repondData objectForKey:@"trackList"];
             NSLog(@"%@",arr);
             _lasttrackList = arr;
             [self hideHUD];
             [self addRouteAndPins:arr];
         }];
    }
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
-(void)updateAbnormalCount:(NSDictionary*)lastAbnormal
{
   _overspeedCountLabel.text = [_lastAbnormal objectForKey:@"exceedSpeedCount"];
   _ACCCountLabel.text  = [_lastAbnormal objectForKey:@"rapeAcceCount"];
   _brakesCountLabel.text  = [_lastAbnormal objectForKey:@"reduceCount"];
   _sharpturnCountLabel.text  = [_lastAbnormal objectForKey:@"slamBreakeCount"];
   _idleCountLabel.text  = [_lastAbnormal objectForKey:@"idleCount"];
   _fatigueCountLabel.text  = [_lastAbnormal objectForKey:@"fatigueCount"];
}

-(void)abnormalPins:(NSArray*) gpsArr
{
    if(!gpsArr)
        return;
   
    for(int i=0; i<[gpsArr count]; i++){
        NSDictionary* gpsDic = [gpsArr objectAtIndex:i];
        double latitude = [[gpsDic objectForKey:@"lat"] doubleValue];
        double longitude =[[gpsDic objectForKey:@"lng"] doubleValue];
        
        SmartAnnotation *annotation = [[SmartAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude,longitude)];
        annotation.type = DriveSpecial_Annotation;
        annotation.subtype = [[gpsDic objectForKey:@"type"] integerValue];
        [self.mapView addAnnotation:annotation];
        
    }
}

- (void)addRouteAndPins:(NSArray*) gpsArr {
    
    if(gpsArr == nil)
    {
        return;
    }
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    NSDictionary* gpsDic =  [gpsArr firstObject];
    if (gpsDic) {
        double latitude = [[gpsDic objectForKey:@"lat"] doubleValue];
        double longitude =[[gpsDic objectForKey:@"lng"] doubleValue];
        SmartAnnotation *annotation = [[SmartAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude,longitude)];
        annotation.type = DriveStart_Annotation;
        [self.mapView addAnnotation:annotation];
    }
    gpsDic =  [gpsArr lastObject];
    if (gpsDic) {
        double latitude = [[gpsDic objectForKey:@"lat"] doubleValue];
        double longitude =[[gpsDic objectForKey:@"lng"] doubleValue];
        SmartAnnotation *endannotation = [[SmartAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude,longitude)];
        endannotation.type = DriveEnd_Annotation;
        [self.mapView addAnnotation:endannotation];
    }
    
    CLLocationCoordinate2D polylineCoords[gpsArr.count];
    
    for(int i=0; i<[gpsArr count]; i++){
        NSDictionary* gpsDic = [gpsArr objectAtIndex:i];
        double latitude = [[gpsDic objectForKey:@"lat"] doubleValue];
        double longitude =[[gpsDic objectForKey:@"lng"] doubleValue];
        
        polylineCoords[i].latitude = latitude;
        polylineCoords[i].longitude = longitude;
    }
    
    MAPolyline *myPolyline = [MAPolyline polylineWithCoordinates:polylineCoords count:gpsArr.count];
    
    [self.mapView addOverlay:myPolyline];
    
//    MACoordinateRegion region = MACoordinateRegionMakeWithDistance(polylineCoords[0], 1000, 1000);
//    MACoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
//    
//    [self.mapView setRegion:adjustedRegion animated:YES];
    
  
    /* 如果只有一个结果，设置其为中心点. */
    
    ////   self.mapView.centerCoordinate = polylineCoords[0];
    //    //异常点测试
    //    [self addCharacterLocation:polylineCoords[gpsArr.count/2]];
    
    
    //设置显示区域
    self.mapView.visibleMapRect = myPolyline.boundingMapRect;
    [self.mapView setVisibleMapRect:myPolyline.boundingMapRect edgePadding:UIEdgeInsetsMake(20,13,20,13) animated:YES];
    
//    MAMapRect *buffer = (MAMapRect*)malloc(overlays.count * sizeof(MAMapRect));
//    [overlays enumerateObjectsUsingBlock:^(id<MAOverlay> obj, NSUInteger idx, BOOL *stop) {
//        buffer[idx] = [obj boundingMapRect];
//    }];
//    
//    mapRect = [self mapRectUnion:buffer count:overlays.count];
    
//     self.mapView.visibleMapRect = myPolyline.boundingMapRect;
//     [CommonUtility zoomMapViewToFitAnnotations:self.mapView animated:YES];
}


//- (void)addCharacterLocation:(CLLocationCoordinate2D)coordinate {
//    SmartAnnotation *annotation = [[SmartAnnotation alloc] initWithCoordinate:coordinate];
//    annotation.type = DriveSpecial_Annotation;
//    annotation.color = [UIColor blueColor];
//    [self.mapView addAnnotation:annotation];
//
//}
//


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[SmartAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        
        SmartAnnotation* smartannotation = annotation;
        switch (smartannotation.type) {
            case DriveStart_Annotation:
                annotationView.image = [UIImage imageNamed:@"startAnnotation"];
                annotationView.layer.anchorPoint = CGPointMake(0.5, 1);
                break;
            case DriveEnd_Annotation:
                annotationView.image = [UIImage imageNamed:@"endAnnotation"];
                annotationView.layer.anchorPoint = CGPointMake(0.5, 1);
                break;
            case DriveSpecial_Annotation:
            {
                //
                //                overspeed_travel =0,//超速
                //                ACC_travel,//加速
                //                brakes_travel, //急刹车
                //                sharpturn_travel, //急转弯
                //                idle_travel,//长怠速
                //                collision_travel,//碰撞
                //                fatigue_travel,//疲劳
                switch (smartannotation.subtype) {
                    case overspeed_travel:
                        annotationView.image = [UIImage imageNamed:@"超速"];
                        break;
                    case ACC_travel:
                        annotationView.image = [UIImage imageNamed:@"急加速"];
                        break;
                    case brakes_travel:
                        annotationView.image = [UIImage imageNamed:@"急刹车"];
                        break;
                    case sharpturn_travel:
                        annotationView.image = [UIImage imageNamed:@"急转弯"];
                    case idle_travel:
                        annotationView.image = [UIImage imageNamed:@"长怠速"];
                        break;
                    case collision_travel:
                        return  nil;
                        break;
                    case fatigue_travel:
                        return  nil;
                        break;
                    default:
                        break;
                }
            }
                break;
            default:
                return  nil;
                break;
        }
        
        return annotationView;
    }
    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth   = 4.f;
        polylineRenderer.strokeColor = [UIColor magentaColor];
        
        return polylineRenderer;
    }
    
    return nil;
}

- (IBAction)preLogClick:(id)sender {
    if (_dataIndex-1>=0) {
        _dataIndex = _dataIndex-1;
        [self showLoadingHUB:@"正在加载"];
        [self getDataWithIndex:_dataIndex];
    }
}

- (IBAction)NextLogClick:(id)sender {
    if (_dataIndex+1<_dataSouce.count) {
        _dataIndex = _dataIndex+1;
        [self showLoadingHUB:@"正在加载"];
        [self getDataWithIndex:_dataIndex];
    }
}
@end
