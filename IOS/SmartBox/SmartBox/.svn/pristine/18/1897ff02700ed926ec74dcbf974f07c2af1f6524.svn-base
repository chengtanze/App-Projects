//
//  AFJsonAPIClient.m
//  Smartbox
//
//  Created by Mesada on 15/1/16.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "AFJsonAPIClient.h"
#import "httpRequestDef.h"

@implementation AFJsonPortAPIClient
//发送请求
+ (instancetype)sharedClient {
    static AFJsonPortAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSLog(@"configuration.timeout =%f timeoutIntervalForResource=%f",configuration.timeoutIntervalForResource ,configuration.timeoutIntervalForResource);
        _sharedClient = [[AFJsonPortAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AppBasePortURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return _sharedClient;
}
@end

@implementation AFJsonTsiAPIClient
//发送请求
+ (instancetype)sharedClient {
    static AFJsonTsiAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFJsonTsiAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AppBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return _sharedClient;
}
@end

@implementation AFJsonAPIClient
+ (instancetype)sharedClient {
    static AFJsonAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFJsonAPIClient alloc]init];
    });
    
    return _sharedClient;
}

-(NSURLSessionDataTask*)httpRequest_handel:(NSString *)URLString parameters:params  complete:(void (^)(NSDictionary *DriveRecord, NSError *error))block
{
    return [self httpRequest_base_handel:nil URL:URLString parameters:params complete:block];
}

-(NSURLSessionDataTask*)httpRequest_base_handel:(AFHTTPSessionManager*)httPSession URL:(NSString *)URLString parameters:params  complete:(void (^)(NSDictionary *DriveRecord, NSError *error))block
{
    AFHTTPSessionManager* AFPhttPSession = httPSession;
    if(!AFPhttPSession)
    {
        AFPhttPSession = [AFJsonTsiAPIClient sharedClient];
    }
    
    return [AFPhttPSession POST:URLString parameters:params success:^(NSURLSessionDataTask * __unused task, id jsonObj) {
        
        NSDictionary *jsonDate  = (NSDictionary*)jsonObj;
        NSLog(@"json =%@",[jsonDate class]);
        
        NSLog(@"ismainThread %d",[NSThread isMainThread]);
        
        
        if (jsonDate) {
            NSNumber* errCode = [[jsonDate valueForKey:@"result"] valueForKey:@"errCode"];
            if (errCode) {
                int nerrCode = [errCode intValue];
                if (nerrCode != 0) {
                    return  block(nil, [[NSError alloc]initWithDomain:@"获取失败" code:[errCode intValue]  userInfo:nil]);
                    
                }
            }
        }
        
        
        NSDictionary *dateDic = jsonDate;
        if (dateDic) {
            if (block) {
                return  block([NSDictionary dictionaryWithDictionary:dateDic], nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
            NSLog(@"%@",error);
        }
    }];
}

-(NSURLSessionDataTask*)httpRequest_base_handelex:(AFHTTPSessionManager*)httPSession URL:(NSString *)URLString parameters:params resultPath:(NSString*)resultPath complete:(void (^)(NSDictionary *DriveRecord, NSError *error))block
{
    if (!resultPath) {
        resultPath = @"result.errCode";
    }
    AFHTTPSessionManager* AFPhttPSession = httPSession;
    if(!AFPhttPSession)
    {
        AFPhttPSession = [AFJsonTsiAPIClient sharedClient];
    }
    
    return [AFPhttPSession POST:URLString parameters:params success:^(NSURLSessionDataTask * __unused task, id jsonObj) {
        
        NSDictionary *jsonDate  = (NSDictionary*)jsonObj;
        NSLog(@"json =%@",[jsonDate class]);
        
        NSLog(@"ismainThread %d",[NSThread isMainThread]);
        
        
        if (jsonDate) {
            NSNumber* errCode = [jsonDate valueForKey:resultPath];
            if (errCode) {
                int nerrCode = [errCode intValue];
                if (nerrCode != 0) {
                    return  block(nil, [[NSError alloc]initWithDomain:@"获取失败" code:[errCode intValue]  userInfo:nil]);
                    
                }
            }
        }
        
        NSDictionary *dateDic = jsonDate;
        if (dateDic) {
            if (block) {
                return  block([NSDictionary dictionaryWithDictionary:dateDic], nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
            NSLog(@"%@",error);
        }
    }];
}


//获取行驶统计
-(NSURLSessionDataTask*)getDrivingCount:(NSString*)strbeginTime endTime:(NSString*)strendTime complete:(void (^)(NSDictionary *drivingCount, NSError *error))block
{
    //debug bobo
    NSInteger userId = [[LoginManager sharedInstance].userId integerValue];//[[LoginManager sharedInstance].userId integerValue];
    NSString *useridString = [NSString stringWithFormat:@"%d", userId];
    
    NSDate *nowdate = [NSDate date];
    NSTimeInterval timeInterval = [nowdate timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", timeInterval * 1000];
    NSString *SignMd5=[[[[NSString stringWithFormat:@"%ld",(long)userId] stringByAppendingString:[OBDTokenKey MD5]] stringByAppendingString:timeString] MD5];
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: useridString forKey:@"userId"];
    [params setObject:strbeginTime  forKey:@"beginTime"];
    [params setObject:strendTime  forKey:@"endTime"];
    [params setObject: timeString forKey:@"timestamp"];
    [params setObject: SignMd5 forKey:@"sign"];
    [params setObject:@"obd/statisticsApi/getDrivingCount" forKey:@"methodName"];
    [params setObject:@"obd" forKey:@"serverName"];
    
    //
    //
    //
    return [[AFJsonTsiAPIClient sharedClient] POST:@"tsi/api/httpUtilsApi/commonPost?" parameters:params success:^(NSURLSessionDataTask * __unused task, id jsonObj) {
        
        NSDictionary *jsonDate  = (NSDictionary*)jsonObj;
        NSLog(@"json =%@",[jsonDate class]);
        
        NSLog(@"ismainThread %d",[NSThread isMainThread]);
        
        NSDictionary * resultDate =  [jsonDate valueForKey:@"drivingCount"];
        
        if (resultDate) {
            NSNumber* errCode = [resultDate valueForKey:@"errCode"];
            if (errCode) {
                int nerrCode = [errCode intValue];
                if (nerrCode != 0) {
                    block(nil, [[NSError alloc]initWithDomain:@"获取失败" code:[errCode intValue]  userInfo:nil]);
                    return;
                }
            }
        }
        
        
        NSDictionary *dateDic = [jsonDate valueForKey:@"drivingCount"];
        if (dateDic) {
            if (block) {
                block([NSDictionary dictionaryWithDictionary:dateDic], nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
            NSLog(@"%@",error);
        }
    }];
    
}


-(NSURLSessionDataTask*)getDriveScore:(NSString*)strBeginDate endDate:(NSString*)strEndDate complete:(void (^)(NSDictionary *RspondDate, NSError *error))block
{
    NSInteger userId = [[LoginManager sharedInstance].userId integerValue];//[[LoginManager sharedInstance].userId integerValue];
    NSString *useridString = [NSString stringWithFormat:@"%d", userId];
    
    NSDate *nowdate = [NSDate date];
    NSTimeInterval timeInterval = [nowdate timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", timeInterval * 1000];
    NSString *SignMd5=[[[[NSString stringWithFormat:@"%ld",(long)userId] stringByAppendingString:[OBDTokenKey MD5]] stringByAppendingString:timeString] MD5];
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: useridString forKey:@"userId"];
    [params setObject:strBeginDate  forKey:@"beginTime"];
    [params setObject:strEndDate  forKey:@"endTime"];
    [params setObject:timeString  forKey:@"timestamp"];
    [params setObject: SignMd5 forKey:@"sign"];
    [params setObject:@"obd/statisticsApi/getDriveScore" forKey:@"methodName"];
    [params setObject:@"obd" forKey:@"serverName"];
  
    return [self httpRequest_handel:UTILSAPI parameters:params complete:block];
}


-(NSURLSessionDataTask*)RequsetRoadhelp:(NSDictionary*)paramsDic complete:(void (^)(NSDictionary *repondData, NSError *error))block;
{
    NSString *useridString = [LoginManager sharedInstance].userId;
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: useridString forKey:@"roadHelp.userId"];
    [params setObject: paramsDic[@"mobile"]  forKey:@"roadHelp.mobile"];
    [params setObject: paramsDic[@"latitude"] forKey:@"latitude"];
    [params setObject: paramsDic[@"longitude"] forKey:@"longitude"];
    [params setObject: paramsDic[@"helpType"] forKey:@"roadHelp.helpType"];
    [params setObject: paramsDic[@"requestTime"] forKey:@"roadHelp.requestTime"];
    [params setObject: @"2" forKey:@"roadHelp.requestFrom"];
    
    return [self httpRequest_base_handel:[AFJsonPortAPIClient sharedClient] URL:@"agent/interface/roadHelp_roadHelp4Mobile.action" parameters:params complete:block];
}


//人伤救援
-(NSURLSessionDataTask*)RequsetInjredhelp:(NSDictionary*)paramsDic complete:(void (^)(NSDictionary *repondData, NSError *error))block
{
    NSString *useridString = [LoginManager sharedInstance].userId;
    NSString *SignMd5=[[NSString stringWithFormat:@"%@%@%@",useridString,thirdserTokenKey,paramsDic[@"serviceId"]] MD5];
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
  
    [params setObject: paramsDic[@"lat"] forKey:@"lat"];
    [params setObject: paramsDic[@"lon"] forKey:@"lon"];
    [params setObject: paramsDic[@"phone"] forKey:@"phone"];
    [params setObject: paramsDic[@"serviceId"] forKey:@"serviceId"];
    [params setObject: paramsDic[@"carNum"] forKey:@"carNum"];
    
    [params setObject: SignMd5 forKey:@"sign"];
    [params setObject: useridString forKey:@"userId"];
    [params setObject: @"1" forKey:@"status"];
    [params setObject: @"1" forKey:@"item"];
    [params setObject: @"/thirdser/ecall/ecallFull.action" forKey:@"methodName"];
    [params setObject: @"thirdser" forKey:@"serverName"];
    
    return [self httpRequest_base_handel:[AFJsonPortAPIClient sharedClient] URL:UTILSAPI parameters:params complete:block];
}


//用户服务状态 10, 03
-(NSURLSessionDataTask*)queryUserSerrvice:(NSString*) bigTypeNum appTypeNumber:(NSString*)appTypeNumber complete:(void (^)(NSDictionary *repondData, NSError *error))block
{
    NSString *useridString = [LoginManager sharedInstance].userId;
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: useridString forKey:@"userId"];
    [params setObject: appTypeNumber  forKey:@"appTypeNumber"];
    [params setObject: bigTypeNum forKey:@"bigTypeNumber"];
    
    return [self httpRequest_base_handel:[AFJsonPortAPIClient sharedClient] URL:@"agent/interface/userBusiness_queryUserServiceByAppType.action" parameters:params complete:block];
}


//人伤救援状态变更记录接口
-(NSURLSessionDataTask*)getRescue:(BOOL)isNear complete:(void (^)(NSArray *repondData, NSError *error))block
{
    NSString *useridString = [LoginManager sharedInstance].userId;
    NSString* sign = [[NSString stringWithFormat:@"%@%@",useridString,thirdserTokenKey] MD5];
    NSString* csisNear = [NSString stringWithFormat:@"%d",!isNear];
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: useridString forKey:@"userId"];
    [params setObject: sign forKey:@"sign"];
    [params setObject: csisNear forKey:@"isNear"];
//    return [self httpRequest_base_handel:[AFJsonPortAPIClient sharedClient] URL:@"thirdser/ecall/getRescue.action?" parameters:params complete:block];
    ///////
    return [[AFJsonPortAPIClient sharedClient] POST:@"thirdser/ecall/getRescue.action?" parameters:params success:^(NSURLSessionDataTask * __unused task, id jsonObj) {
        
        NSDictionary *jsonDate  = (NSDictionary*)jsonObj;
//        NSLog(@"json =%@",[jsonDate class]);
        
        if (jsonDate) {
            NSNumber* errCode = [jsonDate valueForKey:@"result"];
            if (errCode) {
                int nerrCode = [errCode intValue];
                if (nerrCode != 0) {
                    return  block(nil, [[NSError alloc]initWithDomain:@"获取失败" code:[errCode intValue]  userInfo:nil]);
                    
                }
            }
        }
        
        NSDictionary *dataDic = jsonDate;
        if (dataDic) {
            if (block) {
//                NSMutableDictionary*  resultdata = [[NSMutableDictionary alloc]init];
                NSArray* statueListInfo = [dataDic objectForKey:@"list"];
                NSMutableArray* dataArray = [[NSMutableArray alloc]init];
                __block NSNumber* rescueId;
//                NSArray* staticArry = @[@"申请成功",@"救护车出发",@"救援成功"];
                if (statueListInfo) {
                    [statueListInfo enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
                        
                        /*
                        返回的结构是：
                        dic  ->  rescueId：@(1)
                        dic ->   statueText:@"申请成功"
                                 time:@"2015年12月1日 12:13"
                        */
                        if (idx == 0) {
                            rescueId = obj[@"alarmid"];
                            NSDictionary* rescueElement = @{@"rescueId":rescueId};
                            [dataArray addObject:rescueElement];
                        }
                        NSString* timestring = obj[@"begintimeStr"];
                        //handstatus = 0;
                        NSRange r1 = {4,1};
                        timestring= [timestring stringByReplacingCharactersInRange:r1 withString:@"年"];
                        NSRange r2 = {7,1};
                        timestring =[timestring stringByReplacingCharactersInRange:r2 withString:@"月"];
                        
                        NSInteger handstatus = [obj[@"handstatus"] integerValue];
                        NSString* statueDesc;
                        switch (handstatus) {
                            case 0:
                            {
                                statueDesc = @"申请成功";
                                NSDictionary* rescueElement = @{@"statueText":statueDesc,@"time":timestring};
                                [dataArray addObject:rescueElement];
                            }
                                break;
                            case 2:
                            {
                                statueDesc = @"救护车出发";
                                NSDictionary* rescueElement = @{@"statueText":statueDesc,@"time":timestring};
                                [dataArray addObject:rescueElement];
                            }
                                break;
                            case 3:
                            {
                                statueDesc = @"救援成功";
                                NSDictionary* rescueElement = @{@"statueText":statueDesc,@"time":timestring};
                                [dataArray addObject:rescueElement];
                            }
                                break;
//                            case 4:
//                                statueDesc = @"取消救援";
//                                break;
                        }
                        

                        
                    }];
                    
                }
                //解析协议
                //
                return  block(dataArray, nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
            NSLog(@"%@",error);
        }
    }];

}


-(NSURLSessionDataTask*)getCommentRescue:(NSInteger)rescuetype RescueId:(NSInteger)rescueId complete:(void (^)(NSDictionary *repondData, NSError *error))block;
{
    NSString *useridString = [LoginManager sharedInstance].userId;
    NSString* sign = [[NSString stringWithFormat:@"%@%@",useridString,thirdserTokenKey] MD5];

    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: useridString forKey:@"userid"];
    [params setObject: sign forKey:@"sign"];
    [params setObject: [NSString stringWithFormat:@"%ld",(long)rescuetype] forKey:@"rescuetype"];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)rescueId] forKey:@"dataid"];
    
    return [self httpRequest_base_handelex:[AFJsonPortAPIClient sharedClient] URL:@"thirdser/ecall/getCommentRescue" parameters:params resultPath:@"result" complete:block];
}

-(NSURLSessionDataTask*)commentRescue:(NSInteger)rescuetype RescueId:(NSInteger)rescueId commentType:(NSInteger)commentType complete:(void (^)(NSDictionary *repondData, NSError *error))block
{
    NSString *useridString = [LoginManager sharedInstance].userId;
    NSString* sign = [[NSString stringWithFormat:@"%@%@",useridString,thirdserTokenKey] MD5];
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: useridString forKey:@"userid"];
    [params setObject: sign forKey:@"sign"];
      [params setObject:[NSString stringWithFormat:@"%ld",(long)commentType] forKey:@"type"];
    [params setObject: [NSString stringWithFormat:@"%ld",(long)rescuetype] forKey:@"rescuetype"];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)rescueId] forKey:@"dataid"];
    
    return [self httpRequest_base_handelex:[AFJsonPortAPIClient sharedClient] URL:@"thirdser/ecall/saveOrUpdateComentRescue" parameters:params resultPath:@"result" complete:block]  ;
}


-(NSURLSessionDataTask*)queryRoadRescueDetailInfo:(NSInteger)rescueId  complete:(void (^)(NSDictionary *repondData, NSError *error))block
{
    NSString *useridString = [LoginManager sharedInstance].userId;
    NSString* sign = [[NSString stringWithFormat:@"%@%@",useridString,thirdserTokenKey] MD5];
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: useridString forKey:@"userid"];
    [params setObject: sign forKey:@"sign"];
    
    if(rescueId != 0){
    [params setObject:[NSString stringWithFormat:@"%ld",(long)rescueId] forKey:@"orderId"];
    
    }
    return [self httpRequest_base_handelex:[AFJsonPortAPIClient sharedClient] URL:@"thirdser/roadRescue/queryRescueMessage" parameters:params resultPath:@"result" complete:block];
}
@end
