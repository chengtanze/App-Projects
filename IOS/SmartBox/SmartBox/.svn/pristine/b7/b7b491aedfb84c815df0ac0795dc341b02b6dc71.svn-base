//
//  Login_Reqest+Response.m
//  ShoujiUIDemo
//
//  Created by PippoTan on 11-7-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Login_Request+Response.h"

#include "Utility.h"


@implementation LoginRequest

@synthesize email;
@synthesize userID;
@synthesize password;
@synthesize loginState;
@synthesize loginType;
@synthesize deviceToken;

@synthesize userLoginType;
@synthesize mobileNum;
@synthesize timeIntval;
@synthesize loginKey;


- (id)initWithID:(UInt32)uid
        orEmail:(NSString*)theEmail
       orMobile:(NSString*)theMobile
     orLoginKey:(NSString*)theLoginKey
     andPassword:(NSString*)thePassword
  andDeviceToken:(NSString*)theDeviceToken
        andState:(UInt32)theState
andUserLoginType:(UInt8)ulogintype
   andTimeIntval:(NSString*)timeval
{
	if (self = [super initWithFlag:FLAG_CLIENT_SEND
						andKeyType:CLIENT_KEY_RAND
                          andCmdId:CMD_LOGIN_REQUEST
                          andSrcId:uid
                         andDestId:0])
	{
		//
		self.userID = uid;
        self.email = [theEmail copy];
        self.mobileNum = [theMobile copy];
        self.loginKey = [theLoginKey copy];
		self.password = [thePassword copy];
		self.loginState = theState;
		self.loginType = CLIENT_TYPE;
		self.deviceToken = [theDeviceToken copy];
        
        self.userLoginType = ulogintype;
        self.timeIntval = [timeval copy];
	}
    
	return self;
}

- (NSData*)getBodyData
{	
	NSMutableData* packetData = [[NSMutableData alloc] init];
	[packetData appendUInt32:userID];
	[packetData append4SString:self.email];
	[packetData append4SString:password];
	[packetData appendUInt8:loginState];
	[packetData appendUInt8:loginType];
	NSLog(@"send deviceToken===============");
    if (!deviceToken) {
        deviceToken = DefaultDeviceToken;
    }
	[packetData appendUChar32:deviceToken];
	[packetData appendUInt32:VERSION_UINT];
    
    [packetData appendUInt8:userLoginType];
    [packetData append4SString:self.mobileNum];
    [packetData append4SString:timeIntval];
    [packetData append4SString:loginKey];
    
    NSString *uuidStr = [self uuid];
    NSUserDefaults *theuserInfo = [NSUserDefaults standardUserDefaults];
    [theuserInfo setValue:uuidStr forKey:@"reloginuuid"];
    NSLog(@"new UUIDSTR = [%@]",uuidStr);
    const char *p = [uuidStr cStringUsingEncoding:NSASCIIStringEncoding];
    [packetData appendBytes:p length:32];
//    [packetData appendUChar32:uuidStr];
    for (int i =0 ; i < strlen(p); i++) {
        printf("%c", p[i]);
    }
    [packetData appendUInt8:0];//OBD 用户登录 0:表示其他用户登录

	NSLog(@"retUserinfo = [userId = %ld,email = %@,password = %@,loginState = %ld,loginType = %d,deviceToken = %@,version = %d,userLoginType = %d,mobileNum = %@,timeIntval = %@,loginKey = %@]",userID,self.email,password,loginState,loginType,deviceToken,VERSION_UINT,userLoginType,self.mobileNum,timeIntval,loginKey);
	self.bodyLen = packetData.length;
	
	return (NSData*)packetData;
}

-(NSString*) uuid {
    NSUserDefaults *theuserInfo = [NSUserDefaults standardUserDefaults];
    NSString* uuidStr = [theuserInfo objectForKey:@"reloginuuid"];
    if (uuidStr.length>0) {
        NSLog(@"uuid = @[%@]",uuidStr);
        return uuidStr;
    }
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    //把 - 去掉
    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    result = [result uppercaseString];
    NSLog(@"uuid = [%@]",result);
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

//- (void)dealloc
//{
//	[password release];
//	[deviceToken release];
//	
//	[super dealloc];
//}

@end


#pragma mark -
#pragma mark LoginResponse



@implementation LoginResponse

@synthesize retValue;
@synthesize	sessionKey;
@synthesize	syncTime;
@synthesize	errorString;
@synthesize userId;
@synthesize userType;
//@synthesize userBaseInfo;
- (id)initWithDataBlock:(NSData *)data
{
	if (self = [super init]) {
		[data resetCursor];
		self.retValue = [data fetchUInt8Value];
		if (retValue == 0) {
			self.sessionKey = [data fetchDataBlock:CLIENT_KEY_LEN];
			self.syncTime = [data fetch4STime];
			self.userId = [data fetchUInt32Value];
            self.userType = [data fetchUInt8Value];
            
//            //协议新添加返回数据包  add  by  luoyan
//            self.userBaseInfo = [[UserBaseInfo alloc] init];
//            UInt16 nCBSize = [data fetchUInt16Value];	//BaseInfo 结构体大小
//			NSLog(@"GetDetailInfoResponse [BaseInfo结构体大小 = %d]", nCBSize);
//			
//			UInt32 nUserId = [data fetchUInt32Value];
//			UInt32 nUserState = [data fetchUInt32Value];
//			self.userBaseInfo.nickname = [data fetch4SWString];
//			self.userBaseInfo.sex = [data fetchUInt8Value];
//			self.userBaseInfo.locatearea = [data fetch4SWString];
//			self.userBaseInfo.carinfo = [data fetch4SWString];
//			
//			self.userBaseInfo.signtext = [data fetch4SWString];
//			self.userBaseInfo.level = [data fetchUInt8Value];
//			self.userBaseInfo.figureurl = [data fetch4SString];
            
            
		}
		else {
			self.errorString = [data fetch4SWString];
		}
	}
	return self;
}

//- (void)dealloc
//{
//	self.sessionKey  = nil;
//	self.syncTime  = nil;
//	self.errorString  = nil;
//	
//	[super dealloc];
//}

@end



