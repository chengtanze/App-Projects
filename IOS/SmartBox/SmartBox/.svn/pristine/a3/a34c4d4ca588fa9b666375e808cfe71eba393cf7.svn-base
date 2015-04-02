//
//  Login_Reqest+Response+Parser.h
//  inCarTime
//
//  Created by PippoTan on 11-7-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ClientBase.h"
#import "UserBaseInfo.h"

@interface LoginResponse : NSObject
{
	NSInteger	retValue;
	NSData*		sessionKey;
	NSDate*		syncTime;
	NSString*	errorString;
	UInt32		userId;
    UInt8       userType;
}

@property (nonatomic) NSInteger	retValue;
@property (nonatomic, retain) NSData*	sessionKey;
@property (nonatomic, retain) NSDate*	syncTime;
@property (nonatomic, retain) NSString*	errorString;
@property (nonatomic) UInt32		userId;
@property (nonatomic) UInt8         userType;
@property (nonatomic, strong) UserBaseInfo* userBaseInfo;
- (id)initWithDataBlock:(NSData *)data;

@end




@interface LoginRequest : ClientRequest 
{
	UInt32		userID;		//用户id号
	NSString*	email;
	NSString*	password;	//密码
	UInt32		loginState;	//0-普通 1－隐身
	//UInt8		loginState;	//0-普通 1－隐身
	UInt8		loginType;	//0-iOS	1-Android
	NSString*   deviceToken;//设备令牌
    
    //v3.0新添加 add by luoyan
    UInt8       userLoginType; //0:用户ID登录或者邮箱登录  1:手机号码登录 2:QQ登录 3:新浪登录 4:腾讯微博登录
    NSString*   mobileNum;     //手机号码
    NSString*   timeIntval;    //时间戳
    NSString*   loginKey;      //登录 KER（QQ或者微博登录需要）
}

@property (nonatomic, retain) NSString*	email;
@property (nonatomic) UInt32 userID;
@property (nonatomic, copy)	NSString* password;
@property (nonatomic,copy)NSString*   deviceToken;
@property (nonatomic) UInt32 loginState;
//@property (nonatomic) UInt8 loginState;
@property (nonatomic) UInt8	loginType;

@property (nonatomic) UInt8 userLoginType;
@property (nonatomic,copy)  NSString* mobileNum;
@property (nonatomic,copy)  NSString* timeIntval;
@property (nonatomic,copy)  NSString* loginKey;

- (id)initWithID:(UInt32)uid
         orEmail:(NSString*)theEmail
        orMobile:(NSString*)theMobile
      orLoginKey:(NSString*)theLoginKey
     andPassword:(NSString*)thePassword
  andDeviceToken:(NSString*)theDeviceToken
        andState:(UInt32)theState
andUserLoginType:(UInt8)ulogintype
   andTimeIntval:(NSString*)timeval;

- (NSData*)getBodyData;

- (void)dealloc;

@end





