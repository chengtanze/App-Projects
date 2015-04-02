//
//  LoginManager.m
//  LoginDemo
//
//  Created by Mesada on 13-7-20.
//  Copyright (c) 2013年 掌淘科技. All rights reserved.
//

#import "LoginManager.h"
#import "TheUserManager.h"
#import "GDataXMLNode.h"



static LoginManager *shareLoginManager= nil;

@implementation LoginManager
//@synthesize menuView;
@synthesize pushViewCtr;
@synthesize toViewCtr;
@synthesize loginCtr;
@synthesize loginDelegate;
@synthesize checkUpdateVersionDelegate;
@synthesize type;//1:注册  2:找回秘密 3:登录
@synthesize phoneNum;
@synthesize eMail;
@synthesize qqUid;
@synthesize sinaUid;
@synthesize userId;
@synthesize userPwd;
@synthesize deviceToken;
@synthesize timestamp;

@synthesize outQQID;
@synthesize outSinaID;
@synthesize loginKey;
@synthesize iconUrl;
@synthesize sex;
@synthesize nick;
@synthesize signName;


@synthesize isFinishedInfo;
@synthesize isGetBindInfo;

@synthesize finishedUserInfoDelegateCtr;

+ (LoginManager*) sharedInstance
{
	@synchronized (self)
	{
		if (shareLoginManager == nil)
		{
			shareLoginManager = [[LoginManager alloc] init];
		}
	}
	
	return shareLoginManager;
}

+ (id) allocWithZone:(NSZone *)zone
{
    @synchronized (self) {
        if (shareLoginManager == nil) {
            shareLoginManager = [super allocWithZone:zone];
            return shareLoginManager;
        }
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        isFinishedInfo = FALSE;
        isGetBindInfo = false;
        type = 0;
        sex = 0;
    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    return self;
}



#pragma mark
#pragma mark selfdefind method

- (void)doLoginAction:(id)delegate
{
	NSDate *nowdate = [NSDate date];
    NSTimeInterval timeInterval = [nowdate timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", timeInterval * 1000];
	if (LoginByEmail == self.loginType) {
		[[TheUserManager defaultUserManager] doLogin:0
                                           andUserID:0
                                            andEmail:eMail
                                        andMobileNum:nil
                                         andOtherKey:nil
                                       andTimeIntVal:timeString
                                         andPassword:userPwd
									  andDeviceToken:deviceToken
                                         andDelegate:delegate];
	} else if (LoginByID == self.loginType || LoginBySinaWeibo == self.loginType || LoginByTencentWeibo == self.loginType) {
		[[TheUserManager defaultUserManager] doLogin:0
                                           andUserID:[userId integerValue]
                                            andEmail:nil
                                        andMobileNum:nil
                                         andOtherKey:nil
                                       andTimeIntVal:timeString
                                         andPassword:userPwd
									  andDeviceToken:deviceToken
                                         andDelegate:delegate];
        
    } else if (LoginByPhoneNum == self.loginType){
		[[TheUserManager defaultUserManager] doLogin:1
                                           andUserID:0
                                            andEmail:nil
                                        andMobileNum:phoneNum
                                         andOtherKey:nil
                                       andTimeIntVal:timeString
                                         andPassword:userPwd
                                      andDeviceToken:deviceToken
                                         andDelegate:delegate];
	} else {
        [[TheUserManager defaultUserManager] doLogin:self.loginType
                                           andUserID:[userId integerValue]
                                            andEmail:nil
                                        andMobileNum:phoneNum
                                         andOtherKey:loginKey
                                       andTimeIntVal:timestamp
                                         andPassword:nil
                                      andDeviceToken:deviceToken
                                         andDelegate:delegate];
    }
}

- (void)resetLoginManager
{
//    shareLoginManager = nil;
    type = 0;
   
    phoneNum = nil;
    eMail = nil;
    qqUid = nil;
    sinaUid = nil;
    userId = nil;
    userPwd = nil;
    timestamp = nil;
   
    loginKey = nil;
    outQQID = nil;//第三方返回的唯一id
    outSinaID = nil;
    iconUrl = nil;
    nick = nil;
    signName = nil;
    sex = 0;
   
    isFinishedInfo = FALSE;
    isGetBindInfo = FALSE;
}

- (BOOL)isLogin
{
    return [[TheUserManager defaultUserManager] isOnline];
}

- (void)setDelegate:(id)delegate
{
    loginDelegate = delegate;
}

- (void)LoginResult:(BOOL)Result
{
    if (loginDelegate&&[loginDelegate conformsToProtocol:@protocol(LoginManagerDelegate)]) {
        [loginDelegate LoginFeedBack:Result];
        loginDelegate = nil;
    }
}
//bobo 先注释
//- (void)checkUpdateVerionWithDelegate:(id)delegate
//{
//    self.checkUpdateVersionDelegate = delegate;
//    NSString *tempUserId = @"0";
//    NSDate *nowdate = [NSDate date];
//    NSTimeInterval timeInterval = [nowdate timeIntervalSince1970];
//    NSString *timeString = [NSString stringWithFormat:@"%f", timeInterval * 1000];
//    NSString *SignMd5=[[[tempUserId stringByAppendingString:[CTokenKey MD5]] stringByAppendingString:timeString] MD5];
//    NSString *url=[TsiServPrefix stringByAppendingString:checkUpdateVerion];
//    NSString *Para=[NSString stringWithFormat:@"userId=%d&sign=%@&timestamp=%@&platformName=%@&versionNo=%@&packName=%@",[tempUserId integerValue],SignMd5,timeString,@"iphone-OBD手机",VERSION_CHECKNO/*1.0.0*/,@"车友互联"];
//    [self beginRequest:url paras:Para];
//}
//
//- (void)isFinishedUserInfo
//{
//    NSDate *nowdate = [NSDate date];
//    NSTimeInterval timeInterval = [nowdate timeIntervalSince1970];
//    NSString *timeString = [NSString stringWithFormat:@"%f", timeInterval * 1000];
//    NSString *SignMd5=[[[userId stringByAppendingString:[CTokenKey MD5]] stringByAppendingString:timeString] MD5];
//    NSString *url=[TsiServPrefix stringByAppendingString:userDetailInfoApi];
//    NSString *Para=[NSString stringWithFormat:@"userId=%d&sign=%@&timestamp=%@",[userId integerValue],SignMd5,timeString];
//    [self beginRequest:url paras:Para];
//}
//
//- (void)getCurrentUserInfo
//{
//    NSDate *nowdate = [NSDate date];
//    NSTimeInterval timeInterval = [nowdate timeIntervalSince1970];
//    NSString *timeString = [NSString stringWithFormat:@"%f", timeInterval * 1000];
//    NSString *SignMd5=[[[userId stringByAppendingString:[CTokenKey MD5]] stringByAppendingString:timeString] MD5];
//    NSString *url=[TsiServPrefix stringByAppendingString:userDetailInfoApi];
//    NSString *Para=[NSString stringWithFormat:@"userId=%d&sign=%@&timestamp=%@",[userId integerValue],SignMd5,timeString];
//    [self beginRequest:url paras:Para];
//}
//
//
////开始检测用户名异步请求
//-(void)beginRequest:(NSString *)url  paras:(NSString *)paramString
//{
//	NSLog(@"ValidCode:%@",url);
//	NSLog(@"参数:%@",paramString);
//	http=[[HttpAsyncRequest alloc] init];
//	http.delegate=self;
//	[http BeginAsyncPost:url Paras:paramString];
//	
//}
//
//- (void)didFinishLoading:(NSString *)responseString
//{
//	NSLog(@"%@",responseString);
//
//    NSInteger finishedCount = 0;
//    NSError *error;
//
//    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
//    if (doc != nil){
//        NSArray *arr = [doc nodesForXPath:@"//resultCode" error:nil];
//        GDataXMLElement *firstName;
//        if ([arr count] == 1){
//            firstName = (GDataXMLElement *) [arr objectAtIndex:0];
//            if ([[firstName stringValue] isEqual:@"0"]) {
//                //系统更新判断
//                arr = [doc nodesForXPath:@"//isUpdateVerion" error:nil];
//                if (arr.count==1) {
//                    firstName = (GDataXMLElement *) [arr objectAtIndex:0];
//                    BOOL retValue = NO;
//                    NSString *newVersionURL = @"";
//                    if ([[firstName stringValue] isEqualToString:@"true"]) {
//                        retValue = YES;
//                    }
//                    arr = [doc nodesForXPath:@"//upFileUrl" error:nil];
//                    if (arr.count == 1) {
//                        firstName = (GDataXMLElement *)[arr objectAtIndex:0];
//                        newVersionURL = [firstName stringValue];
//                    }
//                    if (checkUpdateVersionDelegate&&[checkUpdateVersionDelegate conformsToProtocol:@protocol(CheckUpdateVersionDelegate)]) {
//                        [checkUpdateVersionDelegate didCheckUpdateVerion:retValue andNewURL:newVersionURL];
//                        checkUpdateVersionDelegate = nil;
//                    }
//                    return;
//                }
//                arr = [doc nodesForXPath:@"//nickName" error:nil];
//                if (arr.count==1) {
//                    firstName = (GDataXMLElement *) [arr objectAtIndex:0];
//                    if ([firstName stringValue].length>0&&![[firstName stringValue] isEqualToString:@"null"]) {
//                        self.nick = [firstName stringValue];
//                        finishedCount ++;
//                    } else {
//                        self.nick = nil;
//                    }
//                }
//                
//                arr = [doc nodesForXPath:@"//sex" error:nil];
//                if (arr.count==1) {
//                    firstName = (GDataXMLElement *) [arr objectAtIndex:0];
//                    if ([firstName stringValue].length>0&&![[firstName stringValue] isEqualToString:@"null"]) {
//                        self.sex = [[firstName stringValue] integerValue];
//                        finishedCount ++;
//                    } else {
//                        self.sex = 2;
//                    }
//                }
//                
//                arr = [doc nodesForXPath:@"//signature" error:nil];
//                if (arr.count==1) {
//                    firstName = (GDataXMLElement *) [arr objectAtIndex:0];
//                    NSString *signature = [[firstName stringValue] stringByReplacingOccurrencesOfString:@" " withString:@""];
//                    NSLog(@"firstName = [%@] ,signature = [%@]",[firstName stringValue],signature);
//                    if (signature.length>0&&![signature isEqualToString:@"null"]) {
//                        self.signName = signature;
//                        finishedCount ++;
//                    } else {
//                        self.signName = nil;
//                    }
//                }
//            
//                arr = [doc nodesForXPath:@"//userPhoto" error:nil];
//                if (arr.count==1) {
//                    firstName = (GDataXMLElement *) [arr objectAtIndex:0];
//                    NSString *userPhoto = [[firstName stringValue] stringByReplacingOccurrencesOfString:@" " withString:@""];
//                    NSLog(@"firstName = [%@] ,userPhoto = [%@]",[firstName stringValue],userPhoto);
//                    if (userPhoto.length>0&&![userPhoto isEqualToString:@"null"]&&![userPhoto isEqualToString:@"user_photo.gif"]) {
//                        if ([userPhoto rangeOfString:@"http://"].location == NSNotFound) {
//                            self.iconUrl = [NSString stringWithFormat:@"%@%@%@",FileServPrefix,FileMiddleUri,userPhoto];;
//                        } else {
//                            self.iconUrl = userPhoto;
//                        }
//                        finishedCount ++;
//                    } else {
//                        self.iconUrl = nil;
//                    }
//                }
//                
//                arr = [doc nodesForXPath:@"//mobileNo" error:nil];
//                if (arr.count==1) {
//                    firstName = (GDataXMLElement *) [arr objectAtIndex:0];
//                    NSString *mobileNo = [[firstName stringValue] stringByReplacingOccurrencesOfString:@" " withString:@""];
//                    NSLog(@"firstName = [%@] ,mobileNo = [%@]",[firstName stringValue],mobileNo);
//                    if (mobileNo.length>0&&![mobileNo isEqualToString:@"null"]) {
//                        self.phoneNum = mobileNo;
//                    } else {
//                        self.phoneNum = nil;
//                    }
//                }
//                
//                arr = [doc nodesForXPath:@"//email" error:nil];
//                if (arr.count==1) {
//                    firstName = (GDataXMLElement *) [arr objectAtIndex:0];
//                    NSString *email = [[firstName stringValue] stringByReplacingOccurrencesOfString:@" " withString:@""];
//                    NSLog(@"firstName = [%@] ,email = [%@]",[firstName stringValue],email);
//                    if (email.length>0&&![email isEqualToString:@"null"]) {
//                        self.eMail = email;
//                    } else {
//                        self.eMail = nil;
//                    }
//                }
//                
//                arr = [doc nodesForXPath:@"//qqUid" error:nil];
//                if (arr.count==1) {
//                    firstName = (GDataXMLElement *) [arr objectAtIndex:0];
//                    NSString *tempQQUid = [[firstName stringValue] stringByReplacingOccurrencesOfString:@" " withString:@""];
//                    NSLog(@"firstName = [%@] ,email = [%@]",[firstName stringValue],tempQQUid);
//                    if (tempQQUid.length>0&&![tempQQUid isEqualToString:@"null"]) {
//                        self.qqUid = tempQQUid;
//                    } else {
//                        self.qqUid = nil;
//                    }
//                }
//                
//                arr = [doc nodesForXPath:@"//sinaUid" error:nil];
//                if (arr.count==1) {
//                    firstName = (GDataXMLElement *) [arr objectAtIndex:0];
//                    NSString *tempSinaUid = [[firstName stringValue] stringByReplacingOccurrencesOfString:@" " withString:@""];
//                    NSLog(@"firstName = [%@] ,email = [%@]",[firstName stringValue],tempSinaUid);
//                    if (tempSinaUid.length>0&&![tempSinaUid isEqualToString:@"null"]) {
//                        self.sinaUid = tempSinaUid;
//                    } else {
//                        self.sinaUid = nil;
//                    }
//                }
//            } else {
//                NSString *resultCode = [firstName stringValue];
//                if (checkUpdateVersionDelegate&&[checkUpdateVersionDelegate conformsToProtocol:@protocol(CheckUpdateVersionDelegate)]) {
//                    [checkUpdateVersionDelegate didCheckUpdateVerionError:resultCode];
//                    checkUpdateVersionDelegate = nil;
//                }
//            }
//        }
//    }
//    doc = nil;
//    if (finishedCount==4) {
//        //finished
//        if (loginDelegate&&[loginDelegate conformsToProtocol:@protocol(LoginManagerDelegate)]) {
//            [loginDelegate isFinished:YES];
//        }
//    } else {
//        //unfinished
//        if (loginDelegate&&[loginDelegate conformsToProtocol:@protocol(LoginManagerDelegate)]) {
//            [loginDelegate isFinished:NO];
//        }
//    }
//}

- (void)didFail:(NSError *)error
{
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    if (loginDelegate&&[loginDelegate conformsToProtocol:@protocol(LoginManagerDelegate)]) {
        [loginDelegate LoginManagerRequestFailed:error];
    }
    if (checkUpdateVersionDelegate&&[checkUpdateVersionDelegate conformsToProtocol:@protocol(CheckUpdateVersionDelegate)]) {
        [checkUpdateVersionDelegate checkUpdateVerionRequestFailed:error];
        checkUpdateVersionDelegate = nil;
    }
}
@end
