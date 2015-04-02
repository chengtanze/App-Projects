//
//  LoginManager.h
//  LoginDemo
//
//  Created by Mesada on 13-7-20.
//  Copyright (c) 2013年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheUserManager.h"

//#import "HomeMenuView.h"

@protocol LoginManagerDelegate;
@protocol CheckUpdateVersionDelegate;
@interface LoginManager : NSObject
//<HttpAsyncRequestDelegate>
{
//    HttpAsyncRequest     *http;
}

//@property (nonatomic,retain) HomeMenuView     *menuView;
@property (nonatomic,retain) UIViewController *pushViewCtr;
@property (nonatomic,retain) UIViewController *toViewCtr;
@property (nonatomic,retain) UIViewController *loginCtr;
@property (nonatomic,assign) id<LoginManagerDelegate> loginDelegate;
@property (nonatomic,assign) id<CheckUpdateVersionDelegate> checkUpdateVersionDelegate;
@property (nonatomic,assign) NSInteger        type;//通过 1:注册 2:找回秘密 3:登录 4:查看基本资料, 后没有完善基本资料进入基本资料页面
                                                   //5:绑定帐号
@property (nonatomic,retain) NSString         *phoneNum;
@property (nonatomic,retain) NSString         *eMail;
@property (nonatomic,retain) NSString         *qqUid;
@property (nonatomic,retain) NSString         *sinaUid;
@property (nonatomic,retain) NSString         *userId;
@property (nonatomic,retain) NSString         *userPwd;
@property (nonatomic,retain) NSString         *deviceToken;
@property (nonatomic,retain) NSString         *timestamp;

@property (nonatomic,assign) LoginType        loginType;// 0
@property (nonatomic,retain) NSString         *loginKey;
@property (nonatomic,retain) NSString         *outQQID;//第三方返回的唯一id
@property (nonatomic,retain) NSString         *outSinaID;
@property (nonatomic,retain) NSString         *iconUrl;
@property (nonatomic,retain) NSString         *nick;
@property (nonatomic,retain) NSString         *signName;
@property (nonatomic,assign) NSInteger        sex;


@property (nonatomic,assign) BOOL             isFinishedInfo;
@property (nonatomic,assign) BOOL             isGetBindInfo;

@property (nonatomic,retain) UIViewController *finishedUserInfoDelegateCtr;

+ (LoginManager*)sharedInstance;
- (void)doLoginAction:(id)delegate;
- (BOOL)isLogin;
- (void)setDelegate:(id)delegate;
- (void)LoginResult:(BOOL)Result;
- (void)isFinishedUserInfo;
- (void)getCurrentUserInfo;
- (void)resetLoginManager;
- (void)checkUpdateVerionWithDelegate:(id)delegate;
@end

@protocol LoginManagerDelegate <NSObject>

@optional
- (void)LoginFeedBack:(BOOL)result;
- (void)isFinished:(BOOL)result;
- (void)LoginManagerRequestFailed:(NSError *)error;
@end

@protocol CheckUpdateVersionDelegate <NSObject>

- (void)didCheckUpdateVerion:(BOOL)retValue andNewURL:(NSString*)newVersionURL;
- (void)didCheckUpdateVerionError:(NSString*)resultCode;
- (void)checkUpdateVerionRequestFailed:(NSError *)error;

@end
