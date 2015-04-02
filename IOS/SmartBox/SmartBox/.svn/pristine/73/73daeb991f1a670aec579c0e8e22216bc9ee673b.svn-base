//
//  TheTCPClient.h
//  SocketClientDemo
//
//  Created by PippoTan on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
#import "ClientBase.h"
#import "PacketChecker.h"

extern NSString* NetworkDisconnectNotifier;
extern NSString* NetworkConnectedNotifier;
extern NSString* UserLoginNotifier;
extern NSString* UserLoginedByOtherPepole;

#pragma mark - TheTCPClient

@interface TheTCPClient : NSObject
{
	AsyncSocket* socket;
	
	NSMutableDictionary* delegateDictionary;
	NSCondition* delegateCondition;
	
	id connectDelegate;

	NSTimer*	theGlobalTimer;	//just one timer for multi things
	NSTimeInterval theLastHeartbeatTime; //heart beat timer control
	
	PacketChecker* thePacketChecker;
    NSInteger nowSeq;
    NSMutableArray *delegateArray;
}

//Is a sington model
+ (TheTCPClient*)getInstance;

//for user 
-(void)sendRequest:(ClientRequest*)request delegate:(id)theDelegate withTimeout:(float)theTimeoutInterval; 

//取消该delegate的所有tcp请求,该delegate可能已经不存在
//从delegateDictionary中删除该delegate的所有键值对
-(void)cancelRequestByDelegate:(id)theDelegate;

-(id)init;
-(void)reset;
-(void)dealloc;
-(BOOL)isConnected;

@end

@interface NSObject (TheTCPClientDelegate)

- (void)onTCPClient:(TheTCPClient*)client request:(ClientRequest*)theRequest receiveResponse:(ClientResponse*)response;

- (void)onTCPClient:(TheTCPClient*)client request:(ClientRequest*)theRequest didFailWithError:(NSString*)error;

@end
