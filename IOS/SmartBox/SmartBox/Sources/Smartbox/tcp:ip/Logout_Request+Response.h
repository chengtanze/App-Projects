//
//  Logout_Request+Response.h
//  inCarTime
//
//  Created by PippoTan on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ClientBase.h"


@interface LogoutRequest : ClientRequest 
{
	UInt32	userID;
	UInt8	terminalType;
}

- (id) initWithUserID:(UInt32)theUserId;
- (NSData*)getBodyData;

@end

@interface LogoutResponse : NSObject
{
	UInt8 retValue;
	NSString* errorString;
}

@property (nonatomic) UInt8 retValue;
@property (nonatomic, retain) NSString* errorString;

- (id)initWithDataBlock:(NSData *)data;

@end

