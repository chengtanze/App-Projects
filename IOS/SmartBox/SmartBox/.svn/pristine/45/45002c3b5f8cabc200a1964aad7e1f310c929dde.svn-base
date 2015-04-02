//
//  P2PMessage_Request_Response.m
//  inCarTime
//
//  Created by PippoTan on 11-8-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "P2PMessage_Request_Response.h"


@implementation P2PMessageRequest

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
	withResourceInfo:(NSDictionary*)resDictionary
{
	if (self = [super initWithFlag:FLAG_CLIENT_SEND
						andKeyType:CLIENT_KEY_RAND
						  andCmdId:CMD_P2PMESSAGE_REQUEST
						  andSrcId:theSid
						 andDestId:theDid])
	{
		fromId = theSid;
		textContent = [[resDictionary objectForKey:@"text"] copy];
		sendTime =  [[NSDate date] get4STime];
		sex = theSex;
		nickName = [theNick copy];
		terminalType = CLIENT_TYPE;//iOS
		
		poiName = [thePoiName copy];
		poiInfo = [thePoi copy];
		longitude = [theLongitude copy];
		latitude = [theLatitude copy];
		fixedLongitude = [theFixedLongitude copy];
		fixedLatitude = [theFixedLatitude copy];
		
		deviationType = 0;
		
		resourceDictionary = resDictionary;
	}
	
	return self;
	
}

- (NSData*)getBodyData
{
	NSMutableData* packetData = [[NSMutableData alloc] init];
	[packetData appendUInt32:fromId];
	[packetData append4SWString:textContent];
	[packetData append4STime:sendTime];
	[packetData append4SWString:nickName];
	[packetData appendUInt8:sex];
	[packetData appendUInt8:terminalType];
	
	NSString* strPoiInfo = nil;
	if (poiInfo == nil) {
		strPoiInfo = @"";
	}
	else {
		strPoiInfo = [NSString stringWithFormat:@"%@|%@|%@|%@|%d|%@|%@",
					  poiName, poiInfo, longitude, latitude, deviationType, fixedLongitude, fixedLatitude];
	}
    [packetData append4SWString:strPoiInfo];
	UInt8 elementCount = 0;
	if ([resourceDictionary objectForKey:@"news"] != nil) {	elementCount += 1;	}
	if ([resourceDictionary objectForKey:@"t_audio_url"] != nil) {	elementCount += 1;	}
	if ([resourceDictionary objectForKey:@"t_pic_url"] != nil) {	elementCount += 1;	}
	if ([resourceDictionary objectForKey:@"pathpointcnt"] != nil) {	elementCount += 1;	}
	
	[packetData appendUInt8:elementCount];
	
	NSString* strNewsURL = [resourceDictionary objectForKey:@"news"];
	if (strNewsURL) {
		UInt16 elementSize = 3+strNewsURL.length + 3; //包含本身
		[packetData appendUInt16:elementSize];
		[packetData appendUInt8:0];
		[packetData append4SString:strNewsURL];
	}
	
	NSString* strAudioURL = [resourceDictionary objectForKey:@"t_audio_url"];
	if (strAudioURL) {
		UInt16 elementSize = 3+strAudioURL.length + 3;
		[packetData appendUInt16:elementSize];
		[packetData appendUInt8:2];
		[packetData append4SString:strAudioURL];
	}
	
	NSString* strPictureURL = [resourceDictionary objectForKey:@"t_pic_url"];
	if (strPictureURL) {
		UInt16 elementSize = 3+strPictureURL.length + 3;
		UInt32 cur =  packetData.length;
        
		[packetData appendUInt16:elementSize];
		[packetData appendUInt8:1];
		[packetData append4SString:strPictureURL];
		
		UInt32 cur2 =  packetData.length;
		UInt16 elementSize2 = cur2 - cur;
		if(elementSize != elementSize2)
		{
			NSLog(@"图片类型的elementSize不对,elementSize = %d,elementSize2 = %d",elementSize,elementSize2);
		}
		
	}
	
	NSString* PathPointCnt= [resourceDictionary objectForKey:@"pathpointcnt"];
	NSLog(@"P2PMessageRequest :: thePathPointCnt == %@", PathPointCnt);
    
	if (PathPointCnt) {
		NSString* strPathIconURL = [resourceDictionary objectForKey:@"t_pathicon_url"];
		
		NSString* PathPoiInfo= [resourceDictionary objectForKey:@"pathpoiinfo"];
		NSUInteger cnt = [PathPointCnt intValue];
        
		UInt16 elementSize = 3+strPathIconURL.length + 3 +4 + PathPoiInfo.length*2 + 4 ;
		UInt32 cur =  packetData.length;
		[packetData appendUInt16:elementSize];
		[packetData appendUInt8:4];
		[packetData append4SString:strPathIconURL];
		[packetData appendUInt32:cnt];
		[packetData append4SWString:PathPoiInfo];
		
		UInt32 cur2 =  packetData.length;
		UInt16 elementSize2 = cur2 - cur;
		if(elementSize != elementSize2)
		{
			NSLog(@"轨迹类型的elementSize不对,elementSize = %d,elementSize2 = %d",elementSize,elementSize2);
		}
		
	}
	
	self.bodyLen = packetData.length;
	
	return (NSData*)packetData;
	
}

//- (void)dealloc
//{
//	[textContent release];
//	[nickName release];
//	[poiName release];
//	[poiInfo release];
//	[longitude release];
//	[latitude release];
//	[fixedLongitude release];
//	[fixedLatitude release];
//	
//	[resourceDictionary release];
//	
//	[super dealloc];
//}


@end


/*
 MessageRcv* message = nil;
 
 message = [NSEntityDescription insertNewObjectForEntityForName:@"MessageRcv" inManagedObjectContext:context];
 
 message.textContent = [netData objectForKey:@"text"];
 message.audioURL = [netData objectForKey:@"audio"];
 message.friendID = [netData objectForKey:@"friendid"];
 message.messageTime = [netData objectForKey:@"time"];
 message.imagURL = [netData objectForKey:@"picture"];
 message.sex = [netData objectForKey:@"sex"];
 message.nickName = [netData objectForKey:@"nick"];
 message.theOwner = [netData objectForKey:@"currentUser"];
 
 return message;
 */


@implementation P2PMessageResponse

@synthesize	messageDictionary;

- (id)initWithDataBlock:(NSData *)data
{
	if (self = [super init])
	{
		[data resetCursor];
        
		UInt32 fromId = [data fetchUInt32Value];
		NSString* textContent = [data fetch4SWString];
		NSDate* sendTime = [data fetch4STime];
		NSString* nickName = [data fetch4SWString];
		UInt8 sex = [data fetchUInt8Value];
		UInt8 terminalType = [data fetchUInt8Value];
		
		//poi信息
		NSString* poiName = nil;
		NSString* poiInfo = nil;
		NSString* longitude = nil;
		NSString* latitude = nil;
		NSString* fixedLng = nil;
		NSString* fixedLat = nil;
		NSInteger poiType = 0;
		NSString* poiInfoString = [data fetch4SWString];
		NSLog(@"YYYY = %@", poiInfoString);
		if ([poiInfoString length] > 0) {
			NSArray* infoArray = [poiInfoString componentsSeparatedByString:@"|"];//componentsSeparatedByString: @"."
			if ([infoArray count] < 7) {
				NSLog(@"POI 信息数据格式错误!");
			}else {
				poiName = [infoArray objectAtIndex:0];
				poiInfo = [infoArray objectAtIndex:1];
				longitude = [infoArray objectAtIndex:2];
				latitude = [infoArray objectAtIndex:3];
				poiType = [[infoArray objectAtIndex:4] intValue];
				fixedLng = [infoArray objectAtIndex:5];
				fixedLat = [infoArray objectAtIndex:6];
			}
		}
		
		NSMutableDictionary* tempDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         [NSNumber numberWithUnsignedInt:fromId], @"friendid",
                                         [NSNumber numberWithUnsignedChar:sex], @"sex",
                                         [NSNumber numberWithUnsignedChar:terminalType], @"terminalType",
                                         [NSNumber numberWithInt:poiType], @"poiType",
                                         nil];
		[tempDic setObject:[NSString stringWithFormat:@"%ld", fromId] forKey:@"friendList"];
        [tempDic setObject:[NSNumber numberWithBool:NO] forKey:@"isGroup"];
		if (textContent) [tempDic setObject:textContent forKey: @"text"];
		if (sendTime) [tempDic setObject:sendTime forKey: @"time"];
		if (nickName) [tempDic setObject:nickName forKey: @"nick"];
		//add by DJ
		if (poiName) [tempDic setObject:poiName forKey: @"poiname"];
		
		if (poiInfo) [tempDic setObject:poiInfo forKey: @"poi"];
		if (longitude) [tempDic setObject:longitude forKey: @"longitude"];
		if (latitude) [tempDic setObject:latitude forKey: @"latitude"];
		if (fixedLng) [tempDic setObject:fixedLng forKey: @"fixedLongitude"];
		if (fixedLat) [tempDic setObject:fixedLat forKey: @"fixedLatitude"];
		
		//资源   0－文本(新闻链接)   1－图片    2－音频    3－视频
		UInt8 nCount = [data fetchUInt8Value];
		if (nCount > 0)
		{
			for (int i = 0; i < nCount; i++) {
				
				UInt16 iCursor = [data getCursor];
                
				UInt16 nElementSize = [data fetchUInt16Value]; //元素大小
				
				UInt8 resType = [data fetchUInt8Value];
				if (resType == 1) {
					NSString* resURL = [data fetch4SString];
					[tempDic setObject:resURL forKey:@"t_pic_url"];
				}else if (resType == 2) {
					NSString* resURL = [data fetch4SString];
					[tempDic setObject:resURL forKey:@"t_audio_url"];
				}else if (resType == 3) {
					NSString* resURL = [data fetch4SString];
					[tempDic setObject:resURL forKey:@"video"];
				}else if (resType == 4) {
					NSString* resURL = [data fetch4SString];
					if (resURL)
						[tempDic setObject:resURL forKey:@"t_pathicon_url"];
					UInt32 pathPointCnt = [data fetchUInt32Value];
					[tempDic setObject:[NSString stringWithFormat:@"%ld",pathPointCnt] forKey:@"pathpointcnt"];
					NSString* pathPoiInfo = [data fetch4SWString];
					if (pathPoiInfo)
						[tempDic setObject:pathPoiInfo forKey:@"pathpoiinfo"];
				}else if (resType == 0) {
					NSString* resURL = [data fetch4SString];
                    if (resURL != nil) {
                        [tempDic setObject:resURL forKey:@"news"];
                    }
				}
				UInt16 iCursorEnd = [data getCursor];
				if(iCursorEnd - iCursor != nElementSize)
					NSLog(@"Size 元素大小不对");
			}
		}
		
		self.messageDictionary = (NSDictionary*)tempDic;
		
		NSLog(@"self.messageDictionary = %@", self.messageDictionary);
	}
	return self;
}

- (void)dealloc
{
	self.messageDictionary = nil;
	
//	[super dealloc];
}

@end



@implementation P2PClientACK

-(id)initWithPacketHeader:(PacketHeader*)theHeader
{
	if (self = [super initWithFlag:FLAG_CLIENT_ACK
						andKeyType:CLIENT_KEY_NONE
						  andCmdId:ACK_P2P_CLIENT
						  andSrcId:theHeader.destId
						 andDestId:theHeader.srcId])
	{
		self.seq = theHeader.seq;
	}
	
	return self;
}

- (NSData*)getBodyData
{
	NSMutableData* packetData = [[NSMutableData alloc] init];
	[packetData appendUInt8:0];
	
	self.bodyLen = packetData.length;
	
	return (NSData*)packetData;
	
}

@end



@implementation GetOfflineP2PMessageRequest

-(id)initWithUserID:(NSInteger)theUserID
{
	if (self = [super initWithFlag:FLAG_CLIENT_SEND
						andKeyType:CLIENT_KEY_SESSION
						  andCmdId:CMD_GETOFFLINEMSG_REQUEST
						  andSrcId:theUserID
						 andDestId:0])
	{
		userID = theUserID;
	}
	
	return self;
}

- (NSData*)getBodyData
{
	NSMutableData* packetData = [[NSMutableData alloc] init];
	[packetData appendUInt32:userID];
	
	self.bodyLen = packetData.length;
	
	return (NSData*)packetData;	
}

@end
