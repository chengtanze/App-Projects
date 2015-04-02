//
//  PacketChecker.h
//  inCarTime
//
//  Created by PippoTan on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PacketChecker : NSObject 
{
	NSMutableData* theReceiveData;
}

//装包和取包在同个线程中进行
- (NSData*) getCompletelyPacket;
- (void) setRowData:(NSData*)theRowData;

@end
