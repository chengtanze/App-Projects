//
//  User.h
//  InCarTimeV3
//
//  Created by Mesada on 13-7-25.
//  Copyright (c) 2013年 wangsl-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserBaseInfo, UserDetailInfo;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * emailAccount;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * qqUid;
@property (nonatomic, retain) NSString * sinaUid;
@property (nonatomic, retain) NSString * mobileNo;
@property (nonatomic, retain) NSDate * lastlogindate;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) UserBaseInfo *baseinfo;
@property (nonatomic, retain) UserDetailInfo *detailinfo;

+ (User*)userWithId:(NSInteger)theId andPassword:(NSString*)thePassword andEmail:(NSString*)theEmail inManagedObjectContext:(NSManagedObjectContext*)context;

+ (User*)getUserByID:(NSInteger)userID  inManagedObjectContext:(NSManagedObjectContext*)context;

- (void)updateUserInfo:(NSDictionary*)dicInfo inManagedObjectContext:(NSManagedObjectContext*)context;

@end
