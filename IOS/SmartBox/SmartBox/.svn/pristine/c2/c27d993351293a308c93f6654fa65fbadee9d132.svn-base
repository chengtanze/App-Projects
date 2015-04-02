//
//  AFJsonAPIClient.h
//  Smartbox
//
//  Created by Mesada on 15/1/16.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

//返回值为json的协议
#import "AFHTTPSessionManager.h"

@interface AFJsonPortAPIClient : AFHTTPSessionManager
//发送请求
+ (instancetype)sharedClient;
@end

@interface AFJsonTsiAPIClient : AFHTTPSessionManager
//发送请求
+ (instancetype)sharedClient;
@end

@interface AFJsonAPIClient : NSObject
+ (instancetype)sharedClient;
//获取行驶统计
-(NSURLSessionDataTask*)getDrivingCount:(NSString*)strbeginTime endTime:(NSString*)strendTime complete:(void (^)(NSDictionary *RspondDate, NSError *error))block;
//获取时间统计
-(NSURLSessionDataTask*)getDriveScore:(NSString*)strBeginDate endDate:(NSString*)strEndDate complete:(void (^)(NSDictionary *RspondDate, NSError *error))block;

//道路救援请求
-(NSURLSessionDataTask*)RequsetRoadhelp:(NSDictionary*)paramsDic complete:(void (^)(NSDictionary *repondData, NSError *error))block;

//人伤救援
-(NSURLSessionDataTask*)RequsetInjredhelp:(NSDictionary*)paramsDic complete:(void (^)(NSDictionary *repondData, NSError *error))block;

//用户服务状态 (10, 03)人伤救援
-(NSURLSessionDataTask*)queryUserSerrvice:(NSString*)bigTypeNum appTypeNumber:(NSString*)appTypeNumber complete:(void (^)(NSDictionary *repondData, NSError *error))block;


//人伤救援状态变更记录接口
/*
返回的结构是：
NSArray->|dic  ->  rescueId：@(1)
         |dic ->   statueText:@"申请成功"
                   time:@"2015年12月1日 12:13"
*/
-(NSURLSessionDataTask*)getRescue:(BOOL)isNear complete:(void (^)(NSArray *repondData, NSError *error))block;

//获取救援评论接口
-(NSURLSessionDataTask*)getCommentRescue:(NSInteger)rescuetype RescueId:(NSInteger)rescueId complete:(void (^)(NSDictionary *repondData, NSError *error))block;

//评论救援接口
-(NSURLSessionDataTask*)commentRescue:(NSInteger)rescuetype RescueId:(NSInteger)rescueId commentType:(NSInteger)commentType complete:(void (^)(NSDictionary *repondData, NSError *error))block;

//查询道路救援详情接口
-(NSURLSessionDataTask*)queryRoadRescueDetailInfo:(NSInteger)rescueId complete:(void (^)(NSDictionary *repondData, NSError *error))block;
@end

