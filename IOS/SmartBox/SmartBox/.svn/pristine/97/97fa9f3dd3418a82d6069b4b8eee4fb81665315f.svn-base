//
//  InjuredRescueController.m
//  Smartbox
//
//  Created by Mesada on 14/12/26.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "InjuredRescueController.h"
#import "UserInfo.h"
#import "UserDAO.h"
#import "LoginManager.h"
#import "APIKey.h"
#import "MBProgressHUD.h"
#import "PublicFunction.h"
#import "AFJsonAPIClient.h"

@interface InjuredRescueController ()
{
    UserInfo_assist* userinfo;
    MAMapView* signMapView;
    MBProgressHUD *hudb;
    double userLatitude;
    double userLongitude;
}

@property (nonatomic, strong) AMapSearchAPI *search;
@end

@implementation InjuredRescueController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults* settingInfo =  [NSUserDefaults standardUserDefaults];
    [settingInfo setObject:@(TRUE) forKey:@"runedUseInjured"];
    _search = [[AMapSearchAPI alloc] initWithSearchKey:(NSString*)APIKey Delegate:self];
    signMapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    signMapView.showsUserLocation = YES;
    signMapView.delegate = self;
    //从数据库中获取用户信息
    UserInfo_assist* info = [[UserDAO sharedManager] find:[[LoginManager sharedInstance].userId integerValue]];
    if (info) {
        userinfo = info;
    }
    _carNumCell.detailTextLabel.text = userinfo.carnumber;
    if (userinfo.phonenumber.length>0) {
        _phoneCell.detailTextLabel.text = userinfo.phonenumber;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}


- (void)mapView:(MAMapView *)theMapView didUpdateUserLocation:(MAUserLocation *)userLocation

{
    if (userLocation.location) {
        //构造AMapReGeocodeSearchRequest对象，location为必选项，radius为可选项
        [self showLoadingHUB:nil];
        AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
        regeoRequest.searchType = AMapSearchType_ReGeocode;
        regeoRequest.location = [AMapGeoPoint locationWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
        regeoRequest.radius = 10000;
        regeoRequest.requireExtension = YES;
        
        //发起逆地理编码
        [_search AMapReGoecodeSearch: regeoRequest];
        signMapView.showsUserLocation = NO;
        
        userLatitude  = userLocation.location.coordinate.latitude;
        userLongitude = userLocation.location.coordinate.longitude;
        
    }
    
    signMapView = nil;
    
    //非常重要的一句代码，因为每一次点击签到，都要重新创建一个MKMapView,，以便能获取当前最新的经纬度，所以这里每签到一次后就要清除旧对象，重新创建对象，再重新定位。
    
}

-(void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error

{
    
    if (error.code == kCLErrorDenied){
        
        NSLog(@"User refused location services");
        
    } else {
        
        NSLog(@"Did fail to locate user with error: %@", error.description);
        
    }
    
    signMapView = nil;
    
} // 如果获取不到用户位置，则调用此代理方

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    [self hideHUD];
    if (response.regeocode != nil)
    {
        AMapAddressComponent *addressComponent = response.regeocode.addressComponent;
        
        NSString* straddress = [NSString stringWithFormat:@"%@%@%@%@",
                                addressComponent.city,
                                addressComponent.district,
                                addressComponent.township,
                                addressComponent.building];
        NSLog(@"ismainthread%d  %@", [NSThread isMainThread] , straddress);
        
        _addressCell.detailTextLabel.text = straddress;
        
    }
    
}

#pragma mark --private
- (void)showHUB:(NSString *)mes
{
    if (hudb) {
        [hudb removeFromSuperViewOnHide];
        hudb.hidden = YES;
        hudb = nil;
    }
    hudb = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hudb.customView = [[UIImageView alloc] init];
    hudb.mode = MBProgressHUDModeCustomView;
    hudb.labelText = mes;
    [hudb hide:YES afterDelay:2];
}


-(void)showLoadingHUB:(NSString *)message
{
    if (hudb) {
        [hudb removeFromSuperViewOnHide];
        hudb = nil;
    }
    hudb = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hudb.labelText = message;
    //bobo
    //    hudb.userInteractionEnabled = NO;
}

- (void)hideHUD
{
    if (hudb) {
        hudb.hidden = YES;
        hudb = nil;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"InjuredRescueSeg"]) {
        phoneNumController* destination = segue.destinationViewController;
        destination.delegate = self;
        destination.userIdentifier = @"InjuredRescueSeg";
    }
    else if([segue.identifier isEqualToString:@"InjuredRescueSegex"])
    {
        phoneNumController* destination = segue.destinationViewController;
        destination.delegate = self;
        destination.userIdentifier = @"InjuredRescueSegex";
    }
}

#pragma mark - SetphoneDelegate
-(void)Setphone:(NSString*)phonenum userIdentifier:(NSString *)Identifier
{
    if ([Identifier isEqualToString:@"InjuredRescueSeg"]) {
        _phoneCell.detailTextLabel.text = phonenum;
    }
    else
    {
        _UrgencyPhoneCell.detailTextLabel.text = phonenum;
    }
}

- (IBAction)RequestInjuredRescue:(id)sender {
    NSString* carNum = _carNumCell.detailTextLabel.text;
    NSString* phoneNum = _phoneCell.detailTextLabel.text;
//    NSString* urgencyPhoneNum = _UrgencyPhoneCell.detailTextLabel.text;
    NSString* address = _addressCell.detailTextLabel.text;
    
   
    if ( ![PublicFunction isCarNumber:carNum])
    {
       return [PublicFunction showMessage:@"请设置车牌号"];
    }
    if ( ![PublicFunction isPhoneNum:phoneNum])
    {
        return [PublicFunction showMessage:@"请填写联系电话"];
    }
    if(address.length==0)
    {
         return [PublicFunction showMessage:@"请输入事发地点"];
    }

        NSDictionary* datadic =  @{@"phone":phoneNum,@"lat":[NSString stringWithFormat:@"%f",userLatitude],@"lon":[NSString stringWithFormat:@"%f",userLongitude],@"serviceId":_serviceId ,@"carNum":carNum};
    
        [self showLoadingHUB:@"正在发送请求.."];
    
        [[AFJsonAPIClient sharedClient]RequsetInjredhelp:datadic complete:^(NSDictionary *jsonDic, NSError *error) {
            NSString *strResult = [jsonDic valueForKeyPath:@"res.result"];
            NSString *errCode = [NSString stringWithFormat:@"%@",[jsonDic valueForKeyPath:@"res.errCode"]];
            [self hideHUD];
            if(error)
            {
                [PublicFunction showMessage:@"道路救援发失败"];
            }
            else
            {
                NSInteger retCode = [strResult integerValue];
                if ([errCode isEqualToString:@"0"]) {
                    switch (retCode) {
                        case 0:
                        {
                            [PublicFunction showMessage:@"道路救援发送成功"];
                            
                        }
                            break;
                        case 1:
                            [PublicFunction showMessage:@"已购买道路救援,请求第三方"];
                            break;
                        case 2:
                            [PublicFunction showMessage:@"未购买道路救援"];
                            break;
                        case 3:
                            [PublicFunction showMessage:@"道路救援服务已过期"];
                            break;
                        case 4:
                            [PublicFunction showMessage:@"服务器繁忙,无空闲坐席"];
                            break;
                        case 5:
                            [PublicFunction showMessage:@"4S店客服不在线"];
                            break;
                        case 6:
                            [PublicFunction showMessage:@"4S服务器异常"];
                            break;
                            
                        default:
                            break;
                    }
                } else if ([errCode isEqualToString:@"9003"]) {
                    [PublicFunction showMessage:@"参数错误."];
                }
            }
        }];

}




@end
