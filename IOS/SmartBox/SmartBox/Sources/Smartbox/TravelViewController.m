//
//  SecondViewController.m
//  Smartbox
//
//  Created by Mesada on 14-10-16.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "TravelViewController.h"
#import "DriveLogCell.h"
#import "AccidentCell.h"
#import "LoginManager.h"
#import "AFAppDotNetAPIClient.h"
#import "APIKey.h"
#import "TravelReGeocodeSearchRequest.h"
#import "LoadfaildTipView.h"
#import "mapLogViewController.h"
#import "DriveLogsController.h"
#import "MBProgressHUD.h"

#define SADDRESS @"sAddress"
#define EADDRESS @"eAddress"

@interface TravelViewController ()
{
    LoadfaildTipView* loadfaildview;
    MBProgressHUD* HUD;
}
@property(strong, nonatomic)  NSArray *dataSouce;
@property (nonatomic, strong) AMapSearchAPI *search;
@end

@implementation TravelViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _search = [[AMapSearchAPI alloc] initWithSearchKey:(NSString*)APIKey Delegate:self];
    
    
    if (_startDate) {
        NSRange rang1={5,2};
        int month = [[_startDate substringWithRange:rang1]intValue];
        NSRange rang2={8,2};
        int day = [[_startDate substringWithRange:rang2]intValue];
        self.title =[NSString stringWithFormat:@"%d月%d日",month,day];
    }
    else{
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        [calendar setTimeZone: timeZone];
        NSCalendarUnit calendarUnit = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
        NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:[[NSDate alloc]init]];
        self.title =[NSString stringWithFormat:@"%d月%d",theComponents.month,theComponents.day];
        _startDate =[NSString stringWithFormat:@"%d-%02d-%02d",theComponents.year,theComponents.month,theComponents.day];
    }
    
    [self getDateFromWeb];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSouce.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"driveCell";
    static NSString* cellIndetifie2 = @"accidentCell";
    NSDictionary* celldata = [_dataSouce objectAtIndex:indexPath.row];
  
    

    //地址
    
    //
    if([[celldata objectForKey:@"isRescue"] boolValue])
    {
        AccidentCell* cell = (AccidentCell*)[tableView dequeueReusableCellWithIdentifier:cellIndetifie2];
        //时间
        NSRange rang={11,5};
        NSString *timeStr = [celldata objectForKey:@"createTimeConvert"];
        timeStr =[timeStr substringWithRange:rang];
        cell.timeLabel.text = timeStr;
        NSString* address = [celldata objectForKey:SADDRESS];
        cell.addressLabel.text  = [NSString stringWithFormat:@"位置:%@",address == nil?@"正在获取位置点...":address];
        return cell;
    }
    else
    {

        DriveLogCell* cell = (DriveLogCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
//        strStartTime = [strStartTime substringToIndex:10];
        NSRange rang = {11,5};
        cell.startTimeView.text = [[celldata objectForKey:@"startTimeConvert"]substringWithRange:rang];
        cell.endTimeView.text = [[celldata objectForKey:@"endTimeConvert"]substringWithRange:rang];
        
        NSString* address = [celldata objectForKey:SADDRESS];
        cell.startLocationView.text = address ==nil?@"正在获取位置点...":address;
        address = [celldata objectForKey:EADDRESS];
        cell.endLocationView.text = address ==nil?@"正在获取位置点...":address;
        
        cell.mileageView.text  = [[celldata objectForKey:@"mileage"]stringByAppendingString:@"km"];
        cell.traveltimeView.text = [[celldata objectForKey:@"duration"]stringByAppendingString:@"min"];
        cell.averageSpeedVeiw.text = [[celldata objectForKey:@"speedAvg"]stringByAppendingString:@"km/h"];
        cell.maxSpeedView.text = [[celldata objectForKey:@"speedMax"]stringByAppendingString:@"km/h"];
        cell.persentLabel.text = [celldata objectForKey:@"score"];
        cell.progressView.progress = cell.persentLabel.text.floatValue/100;
        return cell;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void)showLoadFaildTip:(NSString*)tipstring
{
    [loadfaildview removeFromSuperview];
    loadfaildview = [[[NSBundle mainBundle]loadNibNamed:@"loadfaildview" owner:self options:nil] objectAtIndex:0];
    loadfaildview.frame = self.view.frame;
    loadfaildview.tipLabel.text = tipstring;
    [self.view addSubview:loadfaildview];
}

-(void)getDateFromWeb
{
    if ([[LoginManager sharedInstance] isLogin]) {
        if (_startDate) {
            
            //等待框
            if (HUD) {
                [HUD removeFromSuperview];
                HUD = nil;
            }
            HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUD.labelText = @"正在加载行车记录";
            [HUD show:YES];
            //
            [[AFAppDotNetAPIClient sharedClient] findDriveRecordForWeek:_startDate endDate:_startDate complete:^(NSArray *DriveRecord, NSError *error){
         
                _dataSouce = DriveRecord;
                if (_dataSouce.count == 0) {
                   [self showLoadFaildTip:@"暂时没行车记录"];
                }
                
                __block float fmileage = 0.f;
                __block int   cumulative =0;
                __block float maxSpeed =0.f;
                

                [_dataSouce enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop)
                 {
                      fmileage += [[dic objectForKey:@"mileage"] floatValue];
                      cumulative += [[dic objectForKey:@"duration"] intValue];
                      maxSpeed = MAX(maxSpeed, [[dic objectForKey:@"speedMax"] floatValue]);
                     
                     double latitude = [[dic objectForKey:@"onlat"] doubleValue];
                     double longitude =[[dic objectForKey:@"onlng"] doubleValue];
                     ///
                     //构造AMapReGeocodeSearchRequest对象，location为必选项，radius为可选项
                     TravelReGeocodeSearchRequest *regeoRequest = [[TravelReGeocodeSearchRequest alloc] init];
                     regeoRequest.searchType = AMapSearchType_ReGeocode;
                     regeoRequest.location = [AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
                     regeoRequest.radius = 10000;
                     regeoRequest.requireExtension = YES;
                     regeoRequest.index = idx;
                     //发起逆地理编码
                     [_search AMapReGoecodeSearch: regeoRequest];
                     BOOL isRescue = [[dic objectForKey:@"isRescue"] boolValue];
                     if (!isRescue) {
                         latitude = [[dic objectForKey:@"offlat"] doubleValue];
                         longitude =[[dic objectForKey:@"offlng"] doubleValue];
                         TravelReGeocodeSearchRequest *regeoRequest = [[TravelReGeocodeSearchRequest alloc] init];
                         regeoRequest.searchType = AMapSearchType_ReGeocode;
                         regeoRequest.location = [AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
                         regeoRequest.radius = 10000;
                         regeoRequest.requireExtension = YES;
                         regeoRequest.index = idx;
                         regeoRequest.tag = 1;
                         [_search AMapReGoecodeSearch: regeoRequest];
                     }
                     ///
                 }];
                _mileageView.text = [NSString stringWithFormat:@"%d",(int)fmileage];
                _cumulativeTimeView.text = [NSString stringWithFormat:@"%d",cumulative];
                _maxSpeedView.text = [NSString stringWithFormat:@"%d",(int)maxSpeed];
              
                self.headView.hidden = NO;
                [self.tableView reloadData];
                HUD.hidden = YES;

            }
            ];
        }
        else{
           [self showLoadFaildTip:@"加载数据失败"];
            HUD.hidden = YES;
        }
    }
    else
    {
        ///提示登录
        [self showLoadFaildTip:@"加载数据失败"];
    }
}

#pragma mark - AMapSearchDelegate

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        AMapAddressComponent *addressComponent = response.regeocode.addressComponent;
        NSString* straddress = [NSString stringWithFormat:@"%@%@%@%@",
                                addressComponent.city,
                                addressComponent.district,
                                addressComponent.township,
                                addressComponent.building];
        TravelReGeocodeSearchRequest*  travelrequest = (TravelReGeocodeSearchRequest*)request;
        
        NSMutableDictionary* data = [_dataSouce objectAtIndex:travelrequest.index];
        if (data) {
             if(travelrequest.tag == 0)
             {
                 [data  setObject:straddress forKey:SADDRESS];//开始地址
             }
             else{
                [data  setObject:straddress forKey:EADDRESS];//结束地址
             }
            
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:travelrequest.index inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        }
        
    }
}

- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    TravelReGeocodeSearchRequest*  travelrequest = (TravelReGeocodeSearchRequest*)request;
    NSMutableDictionary* data = [_dataSouce objectAtIndex:travelrequest.index];
    if (data) {
        if(travelrequest.tag == 0)
        {
            [data  setObject:@"获取位置失败" forKey:SADDRESS];//开始地址
        }
        else{
            [data  setObject:@"获取位置失败" forKey:EADDRESS];//结束地址
        }
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:travelrequest.index inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"cell2mapLog"]) {
        mapLogViewController* detinationV = (mapLogViewController*)segue.destinationViewController;
        detinationV.dataSouce = self.dataSouce;
        detinationV.dataIndex = [self.tableView indexPathForSelectedRow].row;
    }
}

- (IBAction)unwindSegueToTravelLog:(UIStoryboardSegue *)segue {
    if([segue.identifier isEqualToString:@"Un2TravelLog"])
    {
        DriveLogsController* driveLogsV =  (DriveLogsController*)segue.sourceViewController;
        _startDate = driveLogsV.StrItemDate;
        
        if (_startDate) {
            NSRange rang1={5,2};
            int month = [[_startDate substringWithRange:rang1]intValue];
            NSRange rang2={8,2};
            int day = [[_startDate substringWithRange:rang2]intValue];
            self.title =[NSString stringWithFormat:@"%d月%d日",month,day];
        }
        
        [self getDateFromWeb];
        
    }
}


@end
