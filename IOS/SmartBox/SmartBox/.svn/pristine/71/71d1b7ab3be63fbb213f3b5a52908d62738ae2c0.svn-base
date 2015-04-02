//
//  P2PMessage_Request_Response.h
//  inCarTime
//
//  Created by PippoTan on 11-8-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ClientBase.h"


@interface P2PMessageRequest : ClientRequest
{
	UInt32		fromId;
	NSString*	textContent;
	_4STime		sendTime;
	UInt8		sex;
	NSString*	nickName;
	UInt8		terminalType;
	//
	NSString* poiName;
	NSString* poiInfo;
	NSString* longitude;
	NSString* latitude;
	NSString* fixedLongitude;
	NSString* fixedLatitude;
	UInt8	deviationType; //0-无偏差  1－google偏差
	//
	NSDictionary*	resourceDictionary;
}

- (id)initWithFromID:(UInt32)theSid 
			 andToID:(UInt32)theDid 
			andMySex:(UInt8)theSex 
		 andNickname:(NSString*)theNick 
		  andPoiName:(NSString*)thePoiName
			  andPOI:(NSString*)thePoi
			 andLong:(NSString*)theLongitude
			  andLat:(NSString*)theLatitude
		andFixedLong:(NSString*)theFixedLongitude
		 andFixedLat:(NSString*)theFixedLatitude
	withResourceInfo:(NSDictionary*)resDictionary;

- (NSData*)getBodyData;

@end

@interface P2PMessageResponse : NSObject
{
	NSDictionary*	messageDictionary;
}

@property(nonatomic, retain)	NSDictionary*	messageDictionary;

- (id)initWithDataBlock:(NSData *)data;

@end


@interface P2PServerACK : NSObject		//服务器收到P2P消息后向发送端的回应
{
	
}


@end

@interface P2PClientACK : ClientRequest  //客户端收到P2P消息后向服务器的回应
{
	
}

-(id)initWithPacketHeader:(PacketHeader*)theHeader;

@end

@interface GetOfflineP2PMessageRequest : ClientRequest
{
	NSInteger userID;
}

-(id)initWithUserID:(NSInteger)theUserID;

- (NSData*)getBodyData;

@end



