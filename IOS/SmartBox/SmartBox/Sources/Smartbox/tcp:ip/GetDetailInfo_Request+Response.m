//
//  GetDetailInfo_Request+Response.m
//  inCarTime
//
//  Created by PippoTan on 11-8-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetDetailInfo_Request+Response.h"


@implementation GetDetailInfoRequest

- (id)initWithId:(UInt32)theID andDetailId:(UInt32)theGetID
{
	if (self = [super initWithFlag:FLAG_CLIENT_SEND 
						andKeyType:CLIENT_KEY_SESSION
						  andCmdId:CMD_GETDETAIL_REQUEST
						  andSrcId:theID
						 andDestId:0]) 
	{
		theUserId = theGetID;
	}
	
	return self;
}


- (NSData*)getBodyData
{	
	NSMutableData* packetData = [[NSMutableData alloc] init];
	[packetData appendUInt32:theUserId];
	
	return (NSData*)packetData;
}

@end


@implementation GetDetailInfoResponse

@synthesize retValue;
@synthesize detailInfo;

- (id)initWithDataBlock:(NSData *)data
{
	if (self = [super init]) {
		[data resetCursor];
		self.retValue = [data fetchUInt8Value];
		if (retValue == 0) 
		{
			//获取data当前的偏移量
			UInt16 iCursor = [data getCursor];
			//base info
			//nCBSize 包含自身
			UInt16 nCBSize = [data fetchUInt16Value];	//BaseInfo 结构体大小
			NSLog(@"GetDetailInfoResponse [BaseInfo结构体大小 = %d]", nCBSize);
			
			UInt32 nUserId = [data fetchUInt32Value];
            NSMutableData *ssData = [[NSMutableData alloc]init];
            [ssData appendUInt32:nUserId];
			UInt32 nUserState = [data fetchUInt32Value];
			//UInt8 nUserState = [data fetchUInt8Value];
			NSString* nickName = [data fetch4SWString];
			UInt8 sex = [data fetchUInt8Value];
			NSString* locateArea = [data fetch4SWString];
			NSString* carType = [data fetch4SWString];
			
			NSString* userSign = [data fetch4SWString];
			UInt8 userLevel = [data fetchUInt8Value];
			NSString* figureURL = [data fetch4SString];
			//设置data的下一记录偏移量
			[data setCursor:iCursor+nCBSize];
			
			//extend info
			//车队ID
			UInt8	displacement = [data fetchUInt8Value];
			NSString* carNo = [data fetch4SWString];
			NSString* carColor = [data fetch4SWString];
			UInt8	age = [data fetchUInt8Value];
			NSString* phoneNo = [data fetch4SString];
			UInt8	phoneOpen = [data fetchUInt8Value];
			NSString* carBrand = [data fetch4SWString];
			UInt32  teamID = [data fetchUInt32Value];
			UInt8	carbrandOpen = [data fetchUInt8Value];
			UInt8	teamOpen = [data fetchUInt8Value];
			
			NSString* latestBlog = [data fetch4SWString];
			
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
			
			NSMutableDictionary* userDetailInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
												   [NSNumber numberWithUnsignedInt:nUserId], @"userId",
												   [NSNumber numberWithUnsignedInt:nUserState], @"state",
												   [NSNumber numberWithUnsignedChar:sex], @"sex",
												   [NSNumber numberWithUnsignedChar:userLevel], @"level",
												   [NSNumber numberWithUnsignedChar:displacement], @"displacement",
												   [NSNumber numberWithUnsignedChar:age], @"age",
												   [NSNumber numberWithUnsignedChar:phoneOpen], @"phoneOpen",
												   [NSNumber numberWithUnsignedChar:carbrandOpen], @"carbrandOpen",
												   [NSNumber numberWithUnsignedInt:teamID], @"team",
												   [NSNumber numberWithUnsignedChar:teamOpen], @"teamOpen",
												   nil];
			if (nickName) {
				[userDetailInfo setObject:nickName forKey:@"nickName"];
			}
			if (locateArea) {
				[userDetailInfo setObject:locateArea forKey:@"locate"];
			}
			if (carType) {
				[userDetailInfo setObject:carType forKey:@"carType"];
			}
			if (![userSign isEqualToString:@" "] && userSign.length > 0)//数据库的默认数据是一个空格
			{
				[userDetailInfo setObject:userSign forKey:@"sign"];
			}
			if (figureURL) {
				[userDetailInfo setObject:figureURL forKey:@"figureURL"];
			}
			if (carNo) {
				[userDetailInfo setObject:carNo forKey:@"carNo"];
			}
			if (carColor) {
				[userDetailInfo setObject:carColor forKey:@"carColor"];
			}
			if (phoneNo) {
				[userDetailInfo setObject:phoneNo forKey:@"phoneNo"];
			}
			if (carBrand) {
				[userDetailInfo setObject:carBrand forKey:@"carBrand"];
			}
			if (latestBlog) {
				[userDetailInfo setObject:latestBlog forKey:@"latestBlog"];
			}
			
			self.detailInfo = userDetailInfo;
		}
	}
	return self;
}


- (void) dealloc
{
	self.detailInfo = nil;
	
	//[super dealloc];
}

@end