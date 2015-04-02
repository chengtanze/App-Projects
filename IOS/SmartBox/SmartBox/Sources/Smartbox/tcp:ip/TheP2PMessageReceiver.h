//
//  TheP2PMessageReceiver.h
//  inCarTime
//
//  Created by PippoTan on 11-8-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheTCPClient.h"
extern NSString* newMessage ;
extern NSString *P2P_Message_Notifer;

#define P2P_REPEAT_TIMEINTERVAL		180

@interface TheP2PMessageReceiver : NSObject 
{
	//过滤掉120秒之内的相同的P2P包
	NSTimeInterval	theLastP2PRcvTime;
	NSInteger	theLastSeq;
	NSInteger	theLastSrcId;
	NSInteger	theLastDstId;
}

+ (TheP2PMessageReceiver*)getInstance;

@end
