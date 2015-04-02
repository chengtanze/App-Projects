//
//  PacketChecker.m
//  inCarTime
//
//  Created by PippoTan on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PacketChecker.h"

#import "ClientBase.h"


@implementation PacketChecker

- (id)init
{
	if (self = [super init]) {
		theReceiveData = [[NSMutableData alloc] init];
	}
	
	return self;
}

//- (void)dealloc
//{
//	[theReceiveData release];
//	
//	[super dealloc];
//}

- (void) setRowData:(NSData*)theRowData
{
	NSLog(@"TCP rcv data len = [%d]", [theRowData length]);
	
	if ([theRowData length] <= 0) {
		return;
	}
	
	if ([theReceiveData length] > 0) {
		//认为开头为0xF0或0xF1的包为新的包的开头,重置包检测
		UInt8 theFlag = 0;
		[theRowData getBytes:&theFlag length:1];
		if (theFlag == 0xF1 || theFlag == 0xF0 || theFlag == 0xF2 || theFlag == 0xF3) {
			NSLog(@"Rcv a new packet with 0x%0X, reset the packet checker!!!!!!!!", theFlag);
			[theReceiveData setLength:0];
		}
	}
	
	[theReceiveData appendData:theRowData];
}

- (NSData*) getCompletelyPacket
{
	if ([theReceiveData length] < CLIENT_HEADER_LEN) {
		return nil;
	}
	
	PacketHeader* theHeader = [[PacketHeader alloc] initWithNetData:theReceiveData];
	NSInteger theBodyLen = theHeader.bodyLen;
	if ([theReceiveData length] - CLIENT_HEADER_LEN < theBodyLen) {
		return nil;
	}
	else {
		NSInteger theCompletePacketLen = theBodyLen + CLIENT_HEADER_LEN;
		NSData* theCompletePacket = [NSData dataWithBytes:[theReceiveData bytes] length:theCompletePacketLen];
		
		if ([theReceiveData length] > theCompletePacketLen) {
			NSInteger nLeftLen = [theReceiveData length] - theCompletePacketLen;
			//[theReceiveData resetBytesInRange:NSMakeRange(0, theCompletePacketLen)];
			NSData* leftData = [theReceiveData subdataWithRange:NSMakeRange(theCompletePacketLen, nLeftLen)];
			[theReceiveData setData:leftData];
			NSLog(@"The left packet checker len = %d!!!!!", [leftData length]);
		}
		else {
			[theReceiveData setLength:0];
		}

		NSLog(@"PacketChecker get complete packet cmd = 0x%04x seq = %d", theHeader.cmdId, theHeader.seq);
		return theCompletePacket;
	}
}


@end
