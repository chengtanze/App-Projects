//
//  TheUserManager.h
//  inCarTime
//
//  Created by PippoTan on 11-8-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PCHHeader.h"
#import <Foundation/Foundation.h>
#import "UserInfo_assist.h"
//#import "UserBaseInfo.h"
//#import "User.h"
//#import "User_assist.h"
//#import "UserBaseInfo_assist.h"

extern NSString* userReloginedNotify;
extern NSString* userReloginErrorNotify;

//bobo
#define  LastUserID                     @"LastUserID"
#define  LastUserPassword               @"LastUserPassword"
#define  RememberPasswdState            @"RememberPasswdState"
#define  LastUserLoginState             @"LastUserLoginState"
typedef enum {
	STATE_INIT				= 0,
	STATE_LOGINING			= 1,
	STATE_ONLINE			= 2, 
	STATE_OFFLINE			= 3,
	STATE_LOGOUTING			= 4,
	STATE_LOGOUTED			= 5
}USER_STATE;

typedef enum {
    LoginByPhoneNum         = 1,
    LoginByQQ               = 2,
    LoginBySinaWeibo        = 3,
    LoginByTencentWeibo     = 4,
    LoginByID               = 5,
    LoginByEmail            = 6
}LoginType;

@interface TheUserManager : NSObject 
{
	NSInteger theCurrentUserID;
	NSData* theSessionKey;

//	BOOL loginType;  //0-车友号登录  1-邮箱登录
    UInt8 loginType;//0-车友号登录,邮箱登录 1-手机号码登录,2-QQ ,3-新浪,4-腾讯
	
	//用于重新登录
	NSString* tempEmailString;
	UInt32	tempUserID;
	NSString* tempPassword;
	
	//当前状态
	USER_STATE theCurrentState;
	
//	NSManagedObjectContext* theMainThreadContext;
//	NSManagedObjectContext* threadManagedContext;
	
	//id delegate;
	BOOL didUpdateDetailInfo;
	
	//保存deviceToken
	NSString *DeviceToken;
}

@property (nonatomic, readonly) NSInteger theCurrentUserID;

@property (nonatomic, copy)	NSData* theSessionKey;

//@property (nonatomic, assign) NSManagedObjectContext* theMainThreadContext;
//@property (nonatomic, retain) NSManagedObjectContext* threadManagedContext;

@property (nonatomic, copy) NSString* tempEmailString;
@property (nonatomic) UInt32 tempUserID;
@property (nonatomic, copy) NSString* tempPassword;
@property (nonatomic,copy) NSString *DeviceToken;

@property (nonatomic) UInt8 userLoginType;
@property (nonatomic,copy) NSString* tempMobileNum;
@property (nonatomic,copy) NSString* tempTimeIntVal;
@property (nonatomic,copy) NSString* tempLoginKey; //第三方登录使用
//wanglang change 添加用户类型，以区分是否为蓝牙一键通用户
@property (nonatomic) UInt8 tempUserType;

@property (nonatomic, assign) id delegate;

+ (TheUserManager*) defaultUserManager;

- (NSInteger)getCurrentUserID;

- (BOOL)isOnline;

- (void)doLogin:(UInt8)theLoginType  //0-车友号登录  1－邮箱登录
	  andUserID:(UInt32)theUserID 
	   andEmail:(NSString*)theEmail
   andMobileNum:(NSString*)theMobileNum
    andOtherKey:(NSString*)theOtherKey
  andTimeIntVal:(NSString*)theTimeIntval
	andPassword:(NSString*)thePassword
	andDeviceToken:(NSString*)theDeviceToken
	andDelegate:(id)theDelegate;

- (void)doLogoutWithDelegate:(id)theDelegate;

- (void)doHeartbeat;

-(void)doGetOfflineP2PMsg;

- (void)resetSate;

@end


@interface NSObject (TheUserManagerDelegate)

- (void) theUserDidLogin:(BOOL)success andUserInfo:(UserInfo_assist*)user andErrorString:(NSString*)theError;
- (void) isFinishedUserInfo:(UserInfo_assist*)userBaseInfo andErrorString:(NSString*)theError;
- (void) getUserInfofailed;
- (void) theUserDidLogoutWithState:(NSString*)theState;

@end



