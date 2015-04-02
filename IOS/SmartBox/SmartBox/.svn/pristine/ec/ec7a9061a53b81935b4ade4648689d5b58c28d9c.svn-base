//
//  GetDetailInfo_Request+Response.h
//  inCarTime
//
//  Created by PippoTan on 11-8-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ClientBase.h"


@interface GetDetailInfoRequest : ClientRequest
{
	UInt32  theUserId;
}

- (id)initWithId:(UInt32)theID andDetailId:(UInt32)theGetID;
- (NSData*)getBodyData;


@end

@interface GetDetailInfoResponse : NSObject
{
	UInt8	retValue;
	NSDictionary* detailInfo;
}

@property (nonatomic) UInt8	retValue;
@property (nonatomic, retain) NSDictionary* detailInfo;

- (id)initWithDataBlock:(NSData *)data;
- (void) dealloc;

@end

