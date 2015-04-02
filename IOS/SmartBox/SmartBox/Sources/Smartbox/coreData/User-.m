//
//  User.m
//  InCarTimeV3
//
//  Created by Mesada on 13-7-25.
//  Copyright (c) 2013年 wangsl-iMac. All rights reserved.
//

#import "User.h"
#import "UserBaseInfo.h"
#import "UserDetailInfo.h"


@implementation User

@dynamic emailAccount;
@dynamic id;
//@dynamic qqUid;
//@dynamic sinaUid;
//@dynamic mobileNo;
@dynamic lastlogindate;
@dynamic password;
@dynamic baseinfo;
@dynamic detailinfo;


+ (User*)userWithId:(NSInteger)theId andPassword:(NSString*)thePassword andEmail:(NSString*)theEmail inManagedObjectContext:(NSManagedObjectContext*)context
{
	User* theUser = nil;
	
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
	request.predicate = [NSPredicate predicateWithFormat:@"id = %d", theId];
	
	NSError* error = nil;
	theUser = [[context executeFetchRequest:request error:&error] lastObject];
	
	if (!error && !theUser) //not exist
	{
		theUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
		theUser.id = [NSNumber numberWithUnsignedInt:theId];
		theUser.password = thePassword;
		theUser.emailAccount = theEmail;
		
		NSLog(@"Create User with id = %d password = %@", theId, thePassword);
	}
	else {
		NSLog(@"Find the user id = %d", theId);
		theUser.password = thePassword;
		theUser.emailAccount = theEmail;
	}
	
	return theUser;
}

+ (User*)getUserByID:(NSInteger)userID  inManagedObjectContext:(NSManagedObjectContext*)context
{
	User* theUser = nil;
	
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
	request.predicate = [NSPredicate predicateWithFormat:@"id = %d", userID];
	
	NSError* error = nil;
	theUser = [[context executeFetchRequest:request error:&error] lastObject];
	
	return theUser;
}


//更新用户详细信息
- (void)updateUserInfo:(NSDictionary*)dicInfo inManagedObjectContext:(NSManagedObjectContext*)context
{
	NSLog(@"User::updateUserInfo:inManagedObjectContext.");
	
	if (self.baseinfo == nil) {
		NSLog(@"Create user baseinfo.");
		self.baseinfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserBaseInfo" inManagedObjectContext:context];
		self.baseinfo.owner = self;
	}
	if (self.detailinfo == nil) {
		NSLog(@"Create user detailinfo.");
		self.detailinfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserDetailInfo" inManagedObjectContext:context];
		self.detailinfo.owner = self;
	}
	/*
	 @property (nonatomic, retain) NSString * figureurl;
	 @property (nonatomic, retain) NSString * signtext;
	 @property (nonatomic, retain) NSString * nickname;
	 @property (nonatomic, retain) NSNumber * level;
	 @property (nonatomic, retain) NSString * locatearea;
	 @property (nonatomic, retain) NSNumber * sex;
	 @property (nonatomic, retain) NSString * carinfo;
	 @property (nonatomic, retain) User * owner;
	 */
	
	/*
	 self.detailInfo = [NSDictionary dictionaryWithObjectsAndKeys:
	 [NSNumber numberWithUnsignedInt:nUserId], @"userId",
	 [NSNumber numberWithUnsignedChar:nUserState], @"state",
	 nickName, @"nickName",
	 [NSNumber numberWithUnsignedChar:sex], @"sex",
	 locateArea, @"locate",
	 carType, @"carType",
	 userSign, @"sign",
	 [NSNumber numberWithUnsignedChar:userLevel], @"level",
	 figureURL, @"figureURL",
	 //[NSNumber numberWithUnsignedChar:friendType], @"friendType",
	 //catString, @"catalog",
	 [NSNumber numberWithUnsignedChar:displacement], @"displacement",
	 carNo, @"carNo",
	 carColor, @"carColor",
	 [NSNumber numberWithUnsignedChar:age], @"age",
	 phoneNo, @"phoneNo",
	 [NSNumber numberWithUnsignedChar:phoneOpen], @"phoneOpen",
	 carBrand, @"carBrand",
	 [NSNumber numberWithUnsignedChar:carbrandOpen], @"carbrandOpen",
	 [NSNumber numberWithUnsignedInt:teamID], @"team",
	 [NSNumber numberWithUnsignedChar:teamOpen], @"teamOpen",
	 latestBlog, @"latestBlog",
	 nil];
	 */
	
	NSString* strFigureURL = [dicInfo objectForKey:@"figureURL"];
	if (strFigureURL != nil) {
		if (![[strFigureURL lastPathComponent] isEqualToString:@"user_photo.gif"]) {
			self.baseinfo.figureurl = strFigureURL;
		}
	}
	
	//self.baseinfo.figureurl = [dicInfo objectForKey:@"figureURL"];
	self.baseinfo.signtext = [dicInfo objectForKey:@"sign"];
	self.baseinfo.nickname = [dicInfo objectForKey:@"nickName"];
	self.baseinfo.level = [dicInfo objectForKey:@"level"];
	self.baseinfo.locatearea = [dicInfo objectForKey:@"locate"];
	self.baseinfo.sex = [dicInfo objectForKey:@"sex"];
	self.baseinfo.carinfo = [dicInfo objectForKey:@"carType"];
    
	/*
	 @property (nonatomic, retain) NSString * phoneopen;
	 @property (nonatomic, retain) NSString * carcolor;
	 @property (nonatomic, retain) NSNumber * age;
	 @property (nonatomic, retain) NSString * cartype;
	 @property (nonatomic, retain) NSString * carnumber;
	 @property (nonatomic, retain) NSNumber * phonenumber;
	 @property (nonatomic, retain) NSNumber * displacement;
	 */
	
	self.detailinfo.phonenumber = [dicInfo objectForKey:@"phoneNo"];
	self.detailinfo.carcolor = [dicInfo objectForKey:@"carColor"];
	self.detailinfo.age = [dicInfo objectForKey:@"age"];
	self.detailinfo.cartype = [dicInfo objectForKey:@"carType"];
	self.detailinfo.carnumber = [dicInfo objectForKey:@"carNo"];
	self.detailinfo.phoneopen = [dicInfo objectForKey:@"phoneOpen"];
	self.detailinfo.displacement = [dicInfo objectForKey:@"displacement"];
}


@end
