//
//  RescueViewController.m
//  Smartbox
//
//  Created by Mesada on 14/12/22.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "RescueViewController.h"
#import "RescueCell.h"
#import "SmartAnnotation.h"
#import "AFAppDotNetAPIClient.h"
#import "AFJsonAPIClient.h"
#import "ServiceViewController.h"
#import "InjuredRescueController.h"
#import "AFJsonAPIClient.h"
#import "InjuredRescueLog.h"
#import "roadRescuelLogController.h"

#define  SERVICESTATUESEG @"ServiceStatue"
@interface RescueViewController ()
{
    SmartAnnotation *carAnnotation ;
    
}

@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic,strong) NSString* serviceId;
@end

@implementation RescueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.

    _mapView.delegate = self;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    
    self.mapView.showsUserLocation = YES;
    [_mapView bringSubviewToFront:_carBtn];
    [_mapView bringSubviewToFront:_personBtn];
    [self getCarLocation];
     _search = [[AMapSearchAPI alloc] initWithSearchKey:(NSString*)APIKey Delegate:self];
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
- (void)addCarPins {
    carAnnotation = [[SmartAnnotation alloc] initWithCoordinate:_carCoordinate];
    carAnnotation.type = Car_Annotation;
    [self.mapView addAnnotation:carAnnotation];
}

-(void)SetMapRegion:(CLLocationCoordinate2D)coordinate
{
    MACoordinateRegion region = MACoordinateRegionMakeWithDistance(coordinate, 200, 200);
    MACoordinateRegion adjustedRegion = [_mapView regionThatFits:region];

    [self.mapView setRegion:adjustedRegion animated:YES];
    [self.mapView setRegion:region animated:YES];
    
}


#pragma mark --MKMapViewDelegate
////

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[SmartAnnotation class]] || [annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *reuseIndetifier = @"CPReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        
        if ([annotation isKindOfClass:[MAUserLocation class]]) {
            annotationView.image = [UIImage imageNamed:@"救援_人位置图标"];
            annotationView.layer.anchorPoint = CGPointMake(0.5, 1);
        }
        else
        {
            SmartAnnotation* smartannotation = annotation;
            switch (smartannotation.type) {
                case Car_Annotation:
                    annotationView.image = [UIImage imageNamed:@"startAnnotation"];
                    annotationView.layer.anchorPoint = CGPointMake(0.5, 1);
                    break;
                default:
                    return  nil;
                    break;
            }
        }
        
        return annotationView;
    }

    return nil;
}
///定位成功

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
    _personCoordinate.latitude = userLocation.location.coordinate.latitude;
    _personCoordinate.longitude = userLocation.location.coordinate.longitude;
    
//    [self SetMapRegion:_personCoordinate];
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RescueCell*  cell = [tableView dequeueReusableCellWithIdentifier:@"rescueCell"];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"rescueCell" owner:self options:nil]objectAtIndex:0];
//    }
    switch (indexPath.row) {
        case 0:
            cell.NameLabel.text = @"人伤救援";
            cell.detailLabel.text = @"动手请求，可调配附近的120前来";
            cell.iconimage.image =  [UIImage imageNamed:@"救援_人伤救援图标"];
            break;
        case 1:
            cell.NameLabel.text = @"道路救援";
            cell.detailLabel.text = @"拖车、无油、抛锚、爆胎、泵电...";
            cell.iconimage.image =  [UIImage imageNamed:@"救援_道路救援图标"];
            break;
        case 2:
            cell.NameLabel.text = @"一键报险";
            cell.detailLabel.text = @"直接拨打报险公司电话，快速报险";
            cell.iconimage.image =  [UIImage imageNamed:@"救援_一键报险图标"];
        default:
            break;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
           [self showLoadingHUB:@"正在检查权限"];
            [ [AFJsonAPIClient sharedClient] queryUserSerrvice:@"10" appTypeNumber:@"03" complete:^(NSDictionary *repondData, NSError *error) {
                [self hideHUD];
                if(!error)
                {
                  NSString* enableStatue = [repondData valueForKeyPath:@"retval.enableStatu"];
                    if([enableStatue isEqualToString:@"i2001"])
                    {
                        [self performSegueWithIdentifier:SERVICESTATUESEG sender:[enableStatue copy]];
                    }else if ([enableStatue isEqualToString:@"i3001"])
                    {
                        [self performSegueWithIdentifier:SERVICESTATUESEG sender:[enableStatue copy]];
                    }
                    else if ([enableStatue isEqualToString:@"i3002"])
                    {
                        [self performSegueWithIdentifier:SERVICESTATUESEG sender:[enableStatue copy]];
                    }
                    else if ([enableStatue isEqualToString:@"i3003"])
                    {
                        [self showLoadingHUB:@"正在查看救援记录"];
                        [[AFJsonAPIClient sharedClient] getRescue:YES complete:^(NSArray *repondData, NSError *error) {
                            [self hideHUD];
                            if (!error) {
                                //处理道路救援信息
                                [self handelInjureRescue:repondData];
                            }
                            else
                            {
                                _serviceId = [repondData valueForKeyPath:@"retval.serviceId"];
                                NSUserDefaults* settingInfo =  [NSUserDefaults standardUserDefaults];
                                bool bruned = [settingInfo boolForKey:@"runedUseInjured"];
                                if (bruned) {
                                    [self performSegueWithIdentifier:@"InjuredSegue" sender:self];
                                }
                                else
                                {
                                    [self performSegueWithIdentifier:SERVICESTATUESEG sender:[enableStatue copy]];
                                }
                            }
                        }];
                        

                    }
                    else
                    {
                        [self showHUB:@"验证权限失败"];
                    }
                   
                }
                else
                {
                    [self showHUB:@"验证权限失败"];
                }
            }];
            
        }
            break;
        case 1:
        {
            [[AFJsonAPIClient sharedClient]queryRoadRescueDetailInfo:0  complete:^(NSDictionary *repondData, NSError *error) {
                if (!error) {
                    NSArray*  rescueSteps =  [repondData objectForKey:@"detail"];
                    if(rescueSteps)
                    {
                        [self performSegueWithIdentifier:@"RoadRescueDLog" sender:rescueSteps];
                    }
                    else
                    {
                        [self performSegueWithIdentifier:@"RoadHelpSegue" sender:self];
                    }
                }
                else{
                    [self performSegueWithIdentifier:@"RoadHelpSegue" sender:self];
                }
            }];
        }
            break;
        case 2:
        {
            UIActionSheet *showSheet = [[UIActionSheet alloc] initWithTitle:@"提示信息" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确认" otherButtonTitles:nil];
            [showSheet showInView:[UIApplication sharedApplication].keyWindow];

        }
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//如果有人伤救援就显示界面，没有正在进行的人伤救援就显示 有发送按钮的界面
-(void)handelInjureRescue:(NSArray*)data
{
    NSLog(@"%@",data);
    [self performSegueWithIdentifier:@"InjuRerescueLog" sender:data];
}



- (IBAction)MoveToCarplace:(id)sender {
    if(_carCoordinate.longitude>0)
    {
        [self SetMapRegion:_carCoordinate];
    }
}

- (IBAction)MoveToMyPlace:(id)sender {
    
    if(_personCoordinate.longitude>0)
    {
        [self SetMapRegion:_personCoordinate];
    }

}

- (void) actionSheet: (UIActionSheet *) actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *msg = nil;
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"10086"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else {
       
    }
    
}

-(void)getCarLocation
{
    [[AFAppDotNetAPIClient sharedClient] getCarLocation:^(NSDictionary *CarLocationDic, NSError *error){
        if(nil == error)
        {
            NSLog(@"CarLocationDic =%@",CarLocationDic);
            double latitude = [[CarLocationDic objectForKey:@"elat"] doubleValue];
            double longitude =[[CarLocationDic objectForKey:@"elng"] doubleValue];
            //
//            SmartAnnotation *annotation = [[SmartAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude,longitude)];
//            annotation.type = Car_Annotation;
//            [self.mapView addAnnotation:annotation];
            _carCoordinate = CLLocationCoordinate2DMake(latitude,longitude);
            if (!carAnnotation) {
                 [self addCarPins];
            }
            else
            {
                [carAnnotation setCoordinate:_carCoordinate];
               
            }
            [self SetMapRegion:_carCoordinate ];
                        //
            //构造AMapReGeocodeSearchRequest对象，location为必选项，radius为可选项
            AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
            regeoRequest.searchType = AMapSearchType_ReGeocode;
            regeoRequest.location = [AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
            regeoRequest.radius = 10000;
            regeoRequest.requireExtension = YES;
            
            //发起逆地理编码
            [_search AMapReGoecodeSearch: regeoRequest];
            
            
        }
        else{//错误
            
        }
    }];

}
#pragma mark --AMapSearchDelegate
/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        //        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        //        ReGeocodeAnnotation *reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate
        //
        AMapAddressComponent *addressComponent = response.regeocode.addressComponent;
        NSLog(@"ismainthread%d", [NSThread isMainThread]);
        NSString* straddress = [NSString stringWithFormat:@"%@%@%@%@",
                                addressComponent.city,
                                addressComponent.district,
                                addressComponent.township,
                                addressComponent.building];
        NSLog(@"ismainthread%d  %@", [NSThread isMainThread] , straddress);
        
        _carAddressLabel.text = straddress;
        
    }
}

#pragma mark -- private
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SERVICESTATUESEG]) {
        ServiceViewController* destinationV = (ServiceViewController*)segue.destinationViewController;
        destinationV.statueCode = sender;
        destinationV.serviceId = _serviceId;
    }
    else if ([segue.identifier isEqualToString:@"InjuredSegue"])
    {
        InjuredRescueController* destinationV = (InjuredRescueController*)segue.destinationViewController;
        destinationV.serviceId = _serviceId;
    }
    else if([segue.identifier isEqualToString:@"InjuRerescueLog"])
    {
        InjuredRescueLog* destinationV = (InjuredRescueLog*)segue.destinationViewController;
        destinationV.rescueLogSource = (NSArray*)sender;
    }
    else if([segue.identifier isEqualToString:@"RoadRescueDLog"])
    {
        roadRescuelLogController* destinationV = (roadRescuelLogController*)segue.destinationViewController;
        destinationV.rescueLogSource = (NSArray*)sender;
    }
}
@end
