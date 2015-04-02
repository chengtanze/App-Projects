//
//  TheTCPClient.m
//  SocketClientDemo
//
//  Created by PippoTan on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "PCHHeader.h"
#import "TheTCPClient.h"
#include "Utility.h"

#import "TheUserManager.h"
//#import "TheP2PMessageReceiver.h"
//#import "TheP2PPositionRequestReceiver.h"
#import "TheUserInfoLoseFeedback.h"
#import "HostManager.h"

NSString* NetworkDisconnectNotifier = @"NetworkDisconnect_Notifier";
NSString* NetworkConnectedNotifier = @"NetworkConnected_Notifier";
NSString* UserLoginNotifier = @"UserLogin_Notifier";
NSString* UserLoginedByOtherPepole = @"UserLogined_ByOtherPepole";



@interface TheTCPClient ()

-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err;
-(void)onSocket:(AsyncSocket*)sock didConnectToHost:(NSString*)host port:(UInt16)port;
-(void)onSocketDidDisconnect:(AsyncSocket *)sock;
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData*)data withTag:(long)t;

- (void)startGlobalTimer;
- (void)killGlobalTimer;
- (void)globalTimerFired:(NSTimer *)timer;

-(void)connectToRemote:(NSString*)remoteAddr onPort:(UInt16)port;
-(BOOL)doSendRequest:(ClientRequest*)request;

- (void)scheduleRequest:(ClientRequest*)theRequest withDelegate:(id)itsDelegate withTimeout:(float)theTimeoutInterval andSended:(BOOL)beSended;
- (ClientRequest*)getRequestBySeq:(UInt16)theSeqNO;
- (id)getDelegateBySeq:(UInt16)theSeqNO;
- (void)removeRequestWithDelegate:(id)theDelegate; //remove all request by this delegate
- (void)removeRequestWithSeqNo:(UInt16)theSeqNO; //just remove the request who's seq == theSeqNO
- (void)perocessRequestWithNetError:(NSString*)theErrorString;

- (void)UserLoginNotified : (NSNotification *)aNotification;

@end


@implementation TheTCPClient


static TheTCPClient* kOnlyOne = nil;

+ (TheTCPClient*)getInstance
{
	//static TheTCPClient* kOnlyOne = nil;
	if (kOnlyOne == nil) {
		kOnlyOne = [[TheTCPClient alloc] init];
	}
	return kOnlyOne;
}

- (void)reset
{
	NSLog(@"Reset the TCP client.");
	
    for (id obj in delegateArray) {
        id key = [[obj allKeys]lastObject];
        id delegate = [obj objectForKey:key];
        if (delegate && [delegate respondsToSelector:@selector(onTCPClient:request:didFailWithError:)]) {
			[delegate onTCPClient:self request:obj didFailWithError:@"网络断开"];
		}
    }
//	for(id obj in delegateDictionary)
//	{
//		id delegate = [delegateDictionary objectForKey:obj];
//		if (delegate && [delegate respondsToSelector:@selector(onTCPClient:request:didFailWithError:)]) {
//			[delegate onTCPClient:self request:obj didFailWithError:@"网络断开"];
//		}
//	}
	
	[delegateCondition lock];
    [delegateArray removeAllObjects];
//	[delegateDictionary removeAllObjects];
	[delegateCondition unlock];
	
	[socket disconnect];
//	[socket release];
	socket = nil;
	
	NSLog(@"End of Reset the TCP client.");
}

-(BOOL)isConnected
{
	return [socket isConnected];
}

-(id)init
{
	self = [super init];
	
	// Create socket.
	NSLog (@"Creating socket.");
	socket = [[AsyncSocket alloc] initWithDelegate:self];
	
	delegateDictionary = [[NSMutableDictionary alloc] init];
    delegateArray = [[NSMutableArray alloc]initWithCapacity:0];
	delegateCondition = [[NSCondition alloc] init];
	
	thePacketChecker = [[PacketChecker alloc] init];
	
	theLastHeartbeatTime = 0.0; 
	
	[self startGlobalTimer];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserLoginNotified:) name:UserLoginNotifier object:nil];

	return self;
}

//-(void)dealloc
//{
//	NSLog(@"TheTCPClient dealloc");
//	
//	[[NSNotificationCenter defaultCenter] removeObserver:self];
//	
//	theLastHeartbeatTime = 0.0;
//	
//	[self killGlobalTimer];
//	
//	[socket release];
//	
//	[delegateDictionary release];
//	[delegateCondition release];
//	
//    [delegateArray release];
//	[thePacketChecker release];
//	
//	[super dealloc];
//}


//Timer method
- (void)startGlobalTimer
{
	if (theGlobalTimer != nil) {
		[self killGlobalTimer];
	}
	
	theGlobalTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(globalTimerFired:) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:theGlobalTimer forMode:NSDefaultRunLoopMode];
	
	NSLog(@"The theGlobalTimer started.");
}

- (void)killGlobalTimer
{	
	[theGlobalTimer invalidate];
	//[theGlobalTimer release];
	theGlobalTimer = nil;
	
	NSLog(@"The theGlobalTimer killed.");
}

- (void)globalTimerFired:(NSTimer *)timer
{
	//NSLog(@"globalTimerFired.");
	//The timer fired , check the request timeout.
	
	NSTimeInterval timeIntervalNow = [NSDate timeIntervalSinceReferenceDate];
	
	//send heart packet
	if (theLastHeartbeatTime > 0.0 && timeIntervalNow - theLastHeartbeatTime >= 20.0) {
		[[TheUserManager defaultUserManager] doHeartbeat];
		theLastHeartbeatTime = timeIntervalNow;
	}
	
	//check the request timeout.
	NSMutableArray* theTimeoutRequests = [[NSMutableArray alloc] init];
	
	[delegateCondition lock];
    for (id arr in delegateArray) {
        ClientRequest *request = (ClientRequest *)[[arr allKeys]lastObject];
        if (timeIntervalNow - request.startTime > request.timeoutInterval ) //is timeout
		{
			[theTimeoutRequests addObject:arr];
		}
    }
//	for(id key in delegateDictionary)
//	{
//		ClientRequest* request = (ClientRequest*)key;
//		if (timeIntervalNow - request.startTime > request.timeoutInterval ) //is timeout
//		{
//			[theTimeoutRequests addObject:key];
//		}
//	}
	[delegateCondition unlock];
	for (int i = 0; i<[theTimeoutRequests count]; i++) {
        int j = 0;
        j = [delegateArray indexOfObject:[theTimeoutRequests objectAtIndex:0]];
        id delegate = [[[delegateArray objectAtIndex:j]allValues]lastObject];
        if (delegate && [delegate respondsToSelector:@selector(onTCPClient:request:didFailWithError:)]) {
            [delegate onTCPClient:self request:[[delegateArray objectAtIndex:j]objectForKey:delegate] didFailWithError:@"网络超时"];
        }
        NSLog(@"The request %@ timeout.", (ClientRequest*)[[delegateArray objectAtIndex:j]objectForKey:delegate]);
    }
//	for(id obj in theTimeoutRequests)
//	{
//		id delegate = [delegateDictionary objectForKey:obj];
//		if (delegate && [delegate respondsToSelector:@selector(onTCPClient:request:didFailWithError:)]) {
//			[delegate onTCPClient:self request:obj didFailWithError:@"网络超时"];
//		}
//		NSLog(@"The request %@ is timeout.", (ClientRequest*)obj);
//	}
	
	[delegateCondition lock];
    for (id obj in theTimeoutRequests) {
//
        ClientRequest *request = (ClientRequest *)[[obj allKeys]lastObject];
        NSLog(@"Remove timeouted request [reqest = %@  delegate = %@]", request, [obj objectForKey:request]);
        [delegateArray removeObject:obj];
    }
//	for(id obj in theTimeoutRequests)
//	{
//		NSLog(@"Remove timeouted request [reqest = %@  delegate = %@]", (ClientRequest*)obj, [delegateDictionary objectForKey:obj]);
//		
//		[delegateDictionary removeObjectForKey:obj];
//	}
	[delegateCondition unlock];
	
}

//for user's interface
-(void)connectToRemote:(NSString*)remoteAddr onPort:(UInt16)port
{	
	if (socket == nil) {
		NSLog (@"Recreating socket.");
		socket = [[AsyncSocket alloc] initWithDelegate:self];
	}
	
	if ([socket isConnected]) {
		[socket disconnect];
	}
	
	@try
	{
		NSError *err;
		if ([socket connectToHost:remoteAddr onPort:port error:&err])
		{
			NSLog (@"Connecting to %@ port %u.", remoteAddr, port);
		}
		else
		{
			NSLog (@"Couldn't connect to %@ port %u (%@).", remoteAddr, port, err);
		}
	}
	@catch (NSException *exception)
	{
		NSLog (@"Exception: %@", [exception reason]);
	}
}

//取消该delegate的所有tcp请求,该delegate可能已经不存在
//从列表中删除该delegate的所有键值对
-(void)cancelRequestByDelegate:(id)theDelegate
{
	[self removeRequestWithDelegate:theDelegate];
}

- (void)scheduleRequest:(ClientRequest*)theRequest withDelegate:(id)itsDelegate withTimeout:(float)theTimeoutInterval andSended:(BOOL)beSended
{
	if (theRequest != nil && itsDelegate != nil) {
		if (theTimeoutInterval <= 0.0) {
			theTimeoutInterval = 2.0;
		}
		
		theRequest.timeoutInterval = theTimeoutInterval;
		theRequest.startTime = [NSDate timeIntervalSinceReferenceDate];
		theRequest.isSended = beSended;
		
		[delegateCondition lock];
		{
            //wanglang change 20130318
			//[delegateDictionary setObject:itsDelegate forKey:theRequest];
            NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:itsDelegate, (id)theRequest, nil];
            [delegateArray addObject:dic];
//			[delegateDictionary setObject:itsDelegate forKey:(id)theRequest];
			NSLog(@"TheTcpClient schedule request %@ . [send = %d]", theRequest, beSended);
		}
		[delegateCondition unlock];
	}
}

- (ClientRequest*)getRequestBySeq:(UInt16)theSeqNO
{
	ClientRequest* request = nil;
	
	[delegateCondition lock];
	{
        for(id obj in delegateArray){
            ClientRequest *theRequest = (ClientRequest *)[[obj allKeys]lastObject];
            if (theSeqNO == theRequest.seq) {
                request = theRequest;
            }
        }
//		NSArray* allKeys = [delegateDictionary allKeys];
//		for(id obj in allKeys)
//		{
//			ClientRequest* theRequest = (ClientRequest*)obj;
//			if (theSeqNO == theRequest.seq) {
//				request = theRequest;
//			}
//		}
	}
	[delegateCondition unlock];
	
	return request;
}

- (id)getDelegateBySeq:(UInt16)theSeqNO
{
	//NSLog(@"delegateDictionary = %@", delegateDictionary);
	
	id delegate = nil;
	
	[delegateCondition lock];
	{
        id key = nil;
        for (id obj in delegateArray) {
            ClientRequest *theRequest = (ClientRequest *)[[obj allKeys]lastObject];
            if (theSeqNO == theRequest.seq) {
                key = theRequest;
                delegate = [obj objectForKey:key];
                break;
            }
        }
//		NSArray* allKeys = [delegateDictionary allKeys];
//		id key = nil;
//		for(id obj in allKeys)
//		{
//			ClientRequest* theRequest = (ClientRequest*)obj;
//			if (theSeqNO == theRequest.seq) {
//				key = theRequest;
//			}
//		}
//		delegate = [delegateDictionary objectForKey:key];
	}
	[delegateCondition unlock];
	
	return delegate;
}

- (void)removeRequestWithDelegate:(id)theDelegate
{
	[delegateCondition lock];
	{
		if (theDelegate != nil) {
			NSMutableArray* findKeys = [[NSMutableArray alloc] init];
            for (id obj in delegateArray) {
                id key = [[obj allKeys]lastObject];
                if ([obj objectForKey:key] == theDelegate) {
                    [findKeys addObject:key];
                    [delegateArray removeObject:obj];
                }
            }
//			for (id key in delegateDictionary) {
//				if ([delegateDictionary objectForKey:key] == theDelegate) {
//					[findKeys addObject:key];
//				}
//			}
//			
//			for (id obj in findKeys) {
//				[delegateDictionary removeObjectForKey:obj];
//			}
			
			NSLog(@"TheTCPCLient remove all requests whitch delegate = %@", theDelegate);
		}
	}
	[delegateCondition unlock];
}

- (void)removeRequestWithSeqNo:(UInt16)theSeqNO
{
	[delegateCondition lock];
	{
		id findKey = nil;
        for (id obj in delegateArray) {
            ClientRequest *request = (ClientRequest *)[[obj allKeys] lastObject];
            if (request.seq == theSeqNO) {
                findKey = request;
                [delegateArray removeObject:obj];
                NSLog(@"TheTcpClient remove request %@ .", (ClientRequest*)findKey);
                break;
            }
        }
//		for (id key in delegateDictionary) {
//			ClientRequest* request = (ClientRequest*)key;
//			if (request.seq == theSeqNO) {
//				findKey = key;
//				break;
//			}
//		}
//		
//		if (findKey) {
//			[delegateDictionary removeObjectForKey:findKey];
//			NSLog(@"TheTcpClient remove request %@ .", (ClientRequest*)findKey);
//		}
	}
	[delegateCondition unlock];
}

- (void)perocessRequestWithNetError:(NSString*)theErrorString
{
	[delegateCondition lock];
	{
        for (id obj in delegateArray) {
            ClientRequest *request = (ClientRequest *)[[obj allKeys]lastObject];
            id delegate = [obj objectForKey:request];
            if (delegate && [delegate respondsToSelector:@selector(onTCPClient:request:didFailWithError:)]) {
				[delegate onTCPClient:self request:request didFailWithError:theErrorString];
			}
        }
//		for (id key in delegateDictionary) {
//			ClientRequest* request = (ClientRequest*)key;
//			id delegate = [delegateDictionary objectForKey:key];
//			
//			if (delegate && [delegate respondsToSelector:@selector(onTCPClient:request:didFailWithError:)]) {
//				[delegate onTCPClient:self request:request didFailWithError:theErrorString];
//			}
//		}
//        
//		[delegateDictionary removeAllObjects];
        [delegateArray removeAllObjects];
	}
	[delegateCondition unlock];
}

//向网络发送请求数据
-(BOOL)doSendRequest:(ClientRequest*)request
{
	NSData* sessionKey = [TheUserManager defaultUserManager].theSessionKey;
	UInt8 kt = request.keyType;
	NSData* bodyPlainData = [request getBodyData];
	NSMutableData* dataToSend = nil;
	
	switch (kt) {
		case 0:
		{
			request.bodyLen = [bodyPlainData length];
			dataToSend = [[NSMutableData alloc] initWithData:[request formatHeaderToData]];
			//[dataToSend appendBytes:kDefaultRandKey length:CLIENT_KEY_LEN];
			[dataToSend appendData:bodyPlainData];
			break;
		}
		case 1:
		{
			if (sessionKey.length < CLIENT_KEY_LEN) {
				NSLog(@"获取Session key失败!!!");
				return NO;
			}
			char szEncrytText[4096] = { 0 };
			unsigned int nEncryptLen = 4096;
			if (!xTEAEncryptWithKey((const char*)[bodyPlainData bytes], (unsigned int)[bodyPlainData length], 
									(const char*)[sessionKey bytes], szEncrytText, &nEncryptLen)) {
				NSLog(@"SessionKey加密出错!!!");
				return NO;
			}
			request.bodyLen = nEncryptLen;
			dataToSend = [[NSMutableData alloc] initWithData:[request formatHeaderToData]];
			//[dataToSend appendBytes:kDefaultRandKey length:CLIENT_KEY_LEN];
			[dataToSend appendBytes:szEncrytText length:nEncryptLen];
			
			break;
		}
		case 2:
		{
			static char kDefaultRandKey[CLIENT_KEY_LEN+1] = "1234567890ABCDEF";
			
			//bool xTEADecryptWithKey(const char *crypt, unsigned int crypt_len,const char key[16], char *plain, unsigned int * plain_len);
			//bool xTEAEncryptWithKey(const char *plain, unsigned int plain_len, const char key[16], char *crypt, unsigned int * crypt_len );
			
			char szEncrytText[4096] = { 0 };
			unsigned int nEncryptLen = 4096;
			if (!xTEAEncryptWithKey((const char*)[bodyPlainData bytes], (unsigned int)[bodyPlainData length], 
									kDefaultRandKey, szEncrytText, &nEncryptLen)) {
				NSLog(@"P2P数据加密出错!!!");
				return NO;
			}
			
			/*
			 //test
			 char szTestBUffer[4096] = {0};
			 unsigned int hhhhh = 4096;
			 if (!xTEADecryptWithKey(szEncrytText, nEncryptLen, (const char*)kDefaultRandKey, szTestBUffer, &hhhhh)) {
			 NSLog(@"SessionKey数据解密出错!!!");
			 }
			 */
			
			request.bodyLen = CLIENT_KEY_LEN + nEncryptLen;
			dataToSend = [[NSMutableData alloc] initWithData:[request formatHeaderToData]];
			[dataToSend appendBytes:kDefaultRandKey length:CLIENT_KEY_LEN];
			[dataToSend appendBytes:szEncrytText length:nEncryptLen];
		}
			break;
		default:
		{
			NSLog(@"协议头错误!!!<KeyType = %d>", request.keyType);
			return NO;
		}
	}
	
	NSLog(@"Send request [CMD = %d] [seq = %d] [srcid=%ld] [did=%ld] [bodylen=%ld]", 
		  request.cmdId, request.seq, request.srcId, request.destId, request.bodyLen);
	
	[socket writeData:dataToSend withTimeout:-1 tag:0];
	
//	[[SaveNetRateCount getInstance] saveNetRateCount:dataToSend.length];
	
	return YES;
}

-(void)sendRequest:(ClientRequest*)request delegate:(id)theDelegate withTimeout:(float)theTimeoutInterval
{
	if (![socket isConnected]) {
		[socket disconnect];
		

		
		//需要将请求放入发送对列,当网络连接之后进行请求
		[self scheduleRequest:request withDelegate:theDelegate withTimeout:theTimeoutInterval andSended:NO];
		
		NSLog(@"Connection is disconnected. Reconnect it. %@",BusiServerIp);
		
		//获取IP 
		NSString * busiServerIp = [HostManager getIPAddressForHostString:BusiServerIp];
		//这个为空时会导致crash　add by  DJ 2012.10.31
		if(busiServerIp == nil)
		{
			//获取不到IP时提示网络为链接。
			NSLog(@"busiServerIp == nil");
			if([theDelegate respondsToSelector:@selector(onTCPClient:request:didFailWithError:)]){
				[theDelegate onTCPClient:self request:request didFailWithError:@"网络未连接"];
			}
			return;
		}
		[self connectToRemote:busiServerIp onPort:8090];//8090
		return;
	}
	
	if (![[TheUserManager defaultUserManager] isOnline]  && request.cmdId != CMD_LOGIN_REQUEST) {
		//需要将请求放入发送对列,当网络连接之后进行请求
		[self scheduleRequest:request withDelegate:theDelegate withTimeout:theTimeoutInterval andSended:NO];
		
		return;
	}
	
	if([self doSendRequest:request])
	{
		//add the request to schedul
		[self scheduleRequest:request withDelegate:theDelegate withTimeout:theTimeoutInterval andSended:YES];
	}
	else if([theDelegate respondsToSelector:@selector(onTCPClient:request:didFailWithError:)]){
		[theDelegate onTCPClient:self request:request didFailWithError:@"网络未连接"];
	}
}

- (void)UserLoginNotified : (NSNotification *)aNotification
{
	//发送在队列里的请求包,当用户重新登录后
	[delegateCondition lock];
    for (id obj in delegateArray) {
        ClientRequest *request = (ClientRequest *)[[obj allKeys]lastObject];
        if (request.isSended == NO) {
            [self doSendRequest:request];
            NSLog(@"Resend unsend request = %@ pactet....  ", request);
        }
    }
//	for(id key in delegateDictionary)
//	{
//		ClientRequest* request = (ClientRequest*)key;
//		if (request.isSended == NO) //is not send already
//		{
//			[self doSendRequest:request];
//			NSLog(@"Resend unsend request = %@ pactet....  ", request);
//		}
//	}
	[delegateCondition unlock];
}


#pragma mark -
#pragma mark  AsyncSocketDelegate
-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
	if (err != nil) {
		NSLog(@"Scoket will disconnect. Error domian %@, code %d (%@).", 
			  [err domain], [err code], [err localizedDescription]);
	}else {
		NSLog(@"Socket will disconnect. No error info.");
	}
	
	//主动断开网络不会有这个事件过来
	[self perocessRequestWithNetError:@"网络连接断开"];
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
	NSLog(@"Socket Disconnected.");
	[[NSNotificationCenter defaultCenter] postNotificationName:NetworkDisconnectNotifier object:nil];
}

-(void)onSocket:(AsyncSocket*)sock didConnectToHost:(NSString*)host port:(UInt16)port
{
	NSLog(@"Connected to %@ %u.", host, port);
	
	[sock readDataWithTimeout:-1 tag:0];
	
	theLastHeartbeatTime = [NSDate timeIntervalSinceReferenceDate];
	
	[delegateCondition lock];
    for (id obj in delegateArray) {
        ClientRequest *request = (ClientRequest *)[[obj allKeys]lastObject];
        if (request.isSended == NO && request.cmdId == CMD_LOGIN_REQUEST) {//重发登录请求
            [self doSendRequest:request];
            NSLog(@"Resend login request = %@ pactet....  ", request);
			break;
        }
    }
//	for(id key in delegateDictionary)
//	{
//		ClientRequest* request = (ClientRequest*)key;
//		if (request.isSended == NO && request.cmdId == CMD_LOGIN_REQUEST) //重发登录请求
//		{
//			[self doSendRequest:request];
//			NSLog(@"Resend login request = %@ pactet....  ", request);
//			break;
//		}
//	}
	[delegateCondition unlock];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:NetworkConnectedNotifier object:nil];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData*)data withTag:(long)t
{	
	//read the next packet Immediately
	[sock readDataWithTimeout:-1 tag:0];
	
	[thePacketChecker setRowData:data];
	
//	[[SaveNetRateCount getInstance] saveNetRateCount:data.length];
	while (YES) {
		NSData* packetData = [thePacketChecker getCompletelyPacket];
		if (packetData == nil) {
			NSLog(@"获取完一个packetData");
			break;
		}
		
		NSData* sessionKey = [TheUserManager defaultUserManager].theSessionKey;
		
		ClientResponse* response = [[ClientResponse alloc] initWithNetData:packetData];
		
		NSLog(@"Rcv response =[cmdid = 0x%04x seq = %d bodylen = %ld]", response.cmdId, response.seq, response.bodyLen);
		
		//0X20心跳包解密出错
		if (response.cmdId == 0x0020) {
			//[self reset]; //重置网络,断开原来的Socket???
			
			[[NSNotificationCenter defaultCenter] postNotificationName:UserLoginedByOtherPepole object:nil];
			return;
		}
		
		UInt8 kt = response.keyType;
		switch (kt) {
			case 0: //None key
			{
				char* bodyData = (char*)packetData.bytes + CLIENT_HEADER_LEN;
				response.busiData = [NSData dataWithBytes:bodyData length: (packetData.length - CLIENT_HEADER_LEN)];
				response.bodyLen = packetData.length - CLIENT_HEADER_LEN;
				break;
			}
			case 1: //Session Key
			{
				if ([sessionKey length] < CLIENT_KEY_LEN) {
					NSLog(@"获取SessionKey失败!!!");
					return;
				}
				char* pEncrytData = (char*)packetData.bytes + CLIENT_HEADER_LEN;
				unsigned int nEncrytLen = response.bodyLen;
				
				char szPlainText[8192*2] = { 0 };
				unsigned int nPlianLen = 8192*2;
				if (!xTEADecryptWithKey(pEncrytData, nEncrytLen, (const char*)[sessionKey bytes], szPlainText, &nPlianLen)) {
					NSLog(@"SessionKey数据解密出错!!!");
					return;
				}
				response.busiData = [NSData dataWithBytes:szPlainText length:nPlianLen];
				response.bodyLen = nPlianLen;
				break;
			}
			case 2:	//P2P key (Rand key)
			{
				char szKey[CLIENT_KEY_LEN] = { 0 };
				[packetData getBytes:szKey range:NSMakeRange(CLIENT_HEADER_LEN, CLIENT_KEY_LEN)];
				char* pEncrytData = (char*)packetData.bytes + CLIENT_HEADER_LEN + CLIENT_KEY_LEN;
				unsigned int nEncrytLen = response.bodyLen - CLIENT_KEY_LEN;
				
				//bool xTEADecryptWithKey(const char *crypt, unsigned int crypt_len,const char key[16], char *plain, unsigned int * plain_len);
				//bool xTEAEncryptWithKey(const char *plain, unsigned int plain_len, const char key[16], char *crypt, unsigned int * crypt_len );
				
				char szPlainText[8192*2] = { 0 };
				unsigned int nPlianLen = 8192*2;
				if (!xTEADecryptWithKey(pEncrytData, nEncrytLen, szKey, szPlainText, &nPlianLen)) {
					NSLog(@"P2P数据解密出错!!!");
					return;
				}
				response.busiData = [NSData dataWithBytes:szPlainText length:nPlianLen];
				response.bodyLen = nPlianLen;
				break;
			}
				
			default:
				NSLog(@"不可识别的加密类型数据!!!");
				return;
		}
        if (response.cmdId == CMD_NEED_RELOGIN) {
            NSUserDefaults *theuserInfo = [NSUserDefaults standardUserDefaults];
            NSString *uuidStr = [theuserInfo valueForKey:@"reloginuuid"];
            TheUserInfoLoseFeedback *theResponse = [[TheUserInfoLoseFeedback alloc] initWithDataBlock:data];
            if ([uuidStr isEqualToString:theResponse.uuid]) {
//                [theResponse release];
                continue;
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:UserLoginedByOtherPepole object:nil];
//                [theResponse release];
                break;
            }
//            [theResponse release];
        }
		//需要重新登录的处理 20120215 by TanRui //response.cmdId == CMD_NEED_RELOGIN || 
		if (response.cmdId == CMD_INVALIDE_LOGIN) {
			[[NSNotificationCenter defaultCenter] postNotificationName:UserLoginedByOtherPepole object:nil];
			return;
		}
        /*  /// bobo注释起来的
		//p2p微信消息的处理
		if (response.cmdId == CMD_P2PMESSAGE_REQUEST && response.srcId != 0  && response.destId != 0) //is a p2p message
		{
			[[TheP2PMessageReceiver getInstance] onTCPClient:self request:nil receiveResponse:response];
			//modify by DJ 2012.03.19 修改获取离线消息存在几条的情况,必须用continue;
			continue;
		}
		//p２p请求好友位置的处理
		if (response.cmdId == CMD_P2PPOSITION_REQUEST && response.srcId != 0  && response.destId != 0) //is a p2p message
		{
			[[TheP2PPositionRequestReceiver getInstance] onTCPClient:self request:nil receiveResponse:response];
		}
		*/
		id customDelegate = [self getDelegateBySeq:response.seq];
		ClientRequest* theRequest = [self getRequestBySeq:response.seq];
		if (customDelegate && [customDelegate respondsToSelector:@selector(onTCPClient:request:receiveResponse:)]) 
		{
			NSLog(@"Remove request and delegate as it's response come.[seq = %d]", response.seq);
			[self removeRequestWithSeqNo:response.seq];
			
			//先后顺序
			[customDelegate onTCPClient:self request:theRequest receiveResponse:response];
//          [customDelegate release];
		}
		else {
			if (customDelegate == nil) {
				NSLog(@"The response cmdid = 0x%04x seq = %d can not find its request delegate.", response.cmdId, response.seq);
			}else {
				NSLog(@"The delegate is not response TheTCPClient selector.");
//				[customDelegate release];
			}
		}
	}
}

#pragma mark AsyncSocketDelegate end
#pragma mark -


@end
