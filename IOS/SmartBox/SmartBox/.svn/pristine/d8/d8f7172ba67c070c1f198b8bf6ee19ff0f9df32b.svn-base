//
//  Logout_Request+Response.m
//  inCarTime
//
//  Created by PippoTan on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Logout_Request+Response.h"


@implementation LogoutRequest

- (id) initWithUserID:(UInt32)theUserId
{
	if (self = [super initWithFlag:FLAG_CLIENT_SEND 
						andKeyType:CLIENT_KEY_SESSION
						  andCmdId:CMD_LOGOUT_REQUEST
						  andSrcId:theUserId
						 andDestId:0]) 
	{
		userID = theUserId;
		terminalType = CLIENT_TYPE;
	}
	
	return self;
}


- (NSData*)getBodyData
{
	NSMutableData* packetData = [[NSMutableData alloc] init];
	[packetData appendUInt32:userID];
	[packetData appendUInt8:terminalType];
	
	self.bodyLen = packetData.length;
	
	return (NSData*)packetData;
}

@end





@implementation LogoutResponse

@synthesize retValue;
@synthesize errorString;

- (id)initWithDataBlock:(NSData *)data
{
	if (self = [super init]) {
		[data resetCursor];
		self.retValue = [data fetchUInt8Value];
		if (retValue != 0) {
			self.errorString = [data fetch4SWString];
		}
	}
	return self;
}

- (void)dealloc
{
	self.errorString = nil;
	
//	[super dealloc];
}

@end



