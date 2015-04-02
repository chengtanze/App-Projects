//
//  Generic_Request+Response.m
//  inCarTime
//
//  Created by PippoTan on 11-8-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Generic_Request+Response.h"


@implementation HeartbeatRequrest

- (id)initWithUserID:(UInt32)uid
{
	if (self = [super initWithFlag:FLAG_CLIENT_SEND 
						andKeyType:CLIENT_KEY_SESSION
						  andCmdId:CMD_HEART_BEAT
						  andSrcId:uid
						 andDestId:0]) 
	{
		nUserID = uid;
	}
	return self;
}

- (NSData*)getBodyData
{
	NSMutableData* packetData = [[NSMutableData alloc] init];
	[packetData appendUInt32:nUserID];
	
	self.bodyLen = packetData.length;
	
	return (NSData*)packetData;
}

@end
