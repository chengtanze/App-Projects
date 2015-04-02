//
//  TheP2PMessageReceiver.m
//  inCarTime
//	负责接收P2P消息 和 发送ACK
//  Created by PippoTan on 11-8-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//

#import "TheP2PMessageReceiver.h"
#import "P2PMessage_Request_Response.h"

//#import "MyMessage.h"
#import "AppDelegate.h"
#import "TheUserManager.h"

//#import "FriendInfo.h"

NSString* P2P_Message_Notifer = @"p2p_message_notifier";
NSString* newMessage = @"newMessage";


@implementation TheP2PMessageReceiver


static TheP2PMessageReceiver* kOnlyOne = nil;

+ (TheP2PMessageReceiver*)getInstance
{
	if (kOnlyOne == nil) {
		kOnlyOne = [[TheP2PMessageReceiver alloc] init];
	}
	return kOnlyOne;
}

- (id)init
{
	if (self = [super init]) {
		//
	}
	
	return self;
}

- (void)p2pMessageReceiveDidSave:(NSNotification*)saveNotification 
{
	NSLog(@"TheP2PMessageReceiver::mergeChangesFromContextDidSaveNotification. [saveNotification = %@]", saveNotification);
	
	[[AppDelegate sharedAppDelegate].managedObjectContext mergeChangesFromContextDidSaveNotification:saveNotification];
	
	//向消息管理器发送通知
	//[[NSNotificationCenter defaultCenter] postNotificationName:P2P_Message_Notifer object:nil];
}


- (void)onTCPClient:(TheTCPClient*)client request:(ClientRequest*)theRequest receiveResponse:(ClientResponse*)response
{
	BOOL isARepeatedMessage = NO;
	
	if (theLastP2PRcvTime > 0.0 && [NSDate timeIntervalSinceReferenceDate] - theLastP2PRcvTime < P2P_REPEAT_TIMEINTERVAL) {
        NSLog(@"\nnowSeq = %d, lastSeq = %d, srcId = %ld, theLastSrcId = %d, destId = %ld, theLastDestId = %d", response.seq, theLastSeq, response.srcId, theLastSrcId, response.destId, theLastDstId);
		if (response.seq == theLastSeq && response.srcId == theLastSrcId && response.destId == theLastDstId) {
			isARepeatedMessage = YES;
		}
	}
    //wanglang change 添加收到重复消息的处理。
    /* wanglang change 添加收到重复消息的处理。
	if(response.seq > theLastSeq){
        theLastSeq = response.seq;
    }else{
        isARepeatedMessage = YES;
    }*/
    theLastSeq = response.seq;
	theLastSrcId = response.srcId;
	theLastDstId = response.destId;
	theLastP2PRcvTime = [NSDate timeIntervalSinceReferenceDate];
	
	if (isARepeatedMessage) {
		NSLog(@"Rcv a reoeated p2p2 msg!!!");
		return;
	}

	NSPersistentStoreCoordinator *coordinator = [[AppDelegate sharedAppDelegate] persistentStoreCoordinator];
	NSManagedObjectContext* threadManagedContext = nil;
	if (coordinator != nil) {
		threadManagedContext = [[NSManagedObjectContext alloc] init];
		[threadManagedContext setPersistentStoreCoordinator:coordinator];
	}

	NSLog(@"Receive P2P message [CMD = %04x] [len = %d] [fromid = %ld]", response.cmdId, response.busiData.length, response.srcId);
	P2PMessageResponse* p2pResponse = [[P2PMessageResponse alloc] initWithDataBlock:response.busiData];
	if (p2pResponse) {
		NSLog(@"Parse p2p message OK.");
		
		P2PClientACK* ack = [[[P2PClientACK alloc] initWithPacketHeader:(PacketHeader*)response] autorelease];
		[[TheTCPClient getInstance] sendRequest:ack delegate:nil withTimeout:TcpNetworkTimeout];
		
		NSInteger fromUserId = [[p2pResponse.messageDictionary objectForKey:@"friendid"] intValue];
		FriendInfo* theFriend = [FriendInfo getFriendByID:fromUserId inManagedObjectContext:threadManagedContext];
		if (theFriend != nil) {
			if ([theFriend.friendType intValue] == 1) {
				NSLog(@"来自黑名单好友的消息需要忽略!!!");
				[p2pResponse release];
				return;
			}
		}

		NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
		[dnc addObserver:self selector:@selector(p2pMessageReceiveDidSave:) name:NSManagedObjectContextDidSaveNotification object:threadManagedContext];

		NSInteger myID = [[TheUserManager defaultUserManager] getCurrentUserID];
		MyMessage* theRcvMessage = [MyMessage messageWithType:0 withMyId:myID withContent:p2pResponse.messageDictionary inManagedObjectContext:threadManagedContext];
		[p2pResponse release];
		//写好友的最近联系事件
		if (theFriend) {
			theFriend.latestContract = theRcvMessage.messageTime;
		}
		
		NSError *error = nil;
		if ([threadManagedContext hasChanges] && ![threadManagedContext save:&error]) {
			NSLog(@"threadManagedContext saveContext Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
		[dnc removeObserver:self name:NSManagedObjectContextDidSaveNotification object:threadManagedContext];

		//向消息管理器发送通知
		[[NSNotificationCenter defaultCenter] postNotificationName:P2P_Message_Notifer object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"updateMessageListNotification" object:theRcvMessage];
	}
	[threadManagedContext release];
}

@end
