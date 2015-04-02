//
//  ClientBase.h
//  ShoujiUIDemo
//
//  Created by PippoTan on 11-7-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//flag define
#define FLAG_SERVER_SEND	0xF0
#define FLAG_SERVER_ACK		0xF1
#define FLAG_CLIENT_SEND	0xF2
#define FLAG_CLIENT_ACK		0xF3

//version and type
#define CLIENT_VERSION	0x00
#define CLIENT_TYPE		0x02 //iOS 0x02

#define CLIENT_KEY_NONE		0x00
#define CLIENT_KEY_SESSION	0x01
#define CLIENT_KEY_RAND		0x02
#define CLIENT_KEY_SERVER	0x03

#define CLIENT_KEY_LEN		16

#define CLIENT_HEADER_LEN	19

#define GB_18030 0x80000632 // GB 18030

#define MAX_ERRSTR_LEN		128

#define ACTION_ADD	0
#define ACTION_DELETE	1

#define CMD_HEART_BEAT		0x001F

#define	CMD_LOGIN_REQUEST	0x0111
#define CMD_LOGIN_RESPONSE	0x0112

#define CMD_GETOFFLINEMSG_REQUEST	0x0113

#define CMD_LOGOUT_REQUEST	0x0103
#define CMD_LOGOUT_RESPONSE	0x0104

#define CMD_CHECKVERSION_REQUEST  0x0117
#define CMD_CHECKVERSION_RESPONSE 0x0118

#define CMD_GETFRIEND_REQUEST	0x022B
#define CMD_GETFRIEND_RESPONSE	0x022C

#define CMD_ADDDELETEFOLLOW_REQUEST		0x022D
#define CMD_ADDDELETEFOLLOW_RESPONSE	0x022E

#define CMD_ADDDELETEBLACKLIST_REQUEST	0x022F
#define CMD_ADDDELETEBLACKLIST_RESPONSE	0x0230

#define CMD_MODIFYUSERINFO_REQUEST		0x0231
#define CMD_MODIFYUSERINFO_RESPONSE		0x0232

#define CMD_SETSITUFORTIFY_REQUEST		0x0239
#define CMD_SETSITUFORTIFY_RESPONSE		0x023A

#define CMD_GETSITUFORTIFY_REQUEST		0x0241
#define CMD_GETSITUFORTIFY_RESPONSE		0x0242


#define CMD_GPSWALLPAPER_REQUEST			0x0240

#define CMD_P2PMESSAGE_REQUEST			0x0215
#define ACK_P2P_SERVER					0x9004
#define ACK_P2P_CLIENT					0x9003

#define CMD_INVALIDE_LOGIN				0x9006
#define CMD_NEED_RELOGIN				0x9008

#define CMD_P2P_BROADCAST_REQUEST		0x9009

#define CMD_FINDFRIENDS_REQUEST			0x0203
#define CMD_FINDFRIENDS_RESPONSE		0x0204

#define CMD_P2PPOSITION_REQUEST			0x0211
#define CMD_P2PPOSITION_RESPONSE		0x0212


#define CMD_GETDETAIL_REQUEST			0x020F
#define CMD_GETDETAIL_RESPONSE			0x0210


#define TIMEOUT_SHORT		8.0
#define TIMEOUT_MID			10.0
#define TIMEOUT_LONG		20.0




typedef struct __4STime {
	UInt16	year;
	UInt8	month;
	UInt8	day;
	UInt8	hour;
	UInt8	min;
	UInt8	sec;
}_4STime;

@interface NSDate(_MyExtent)

+ (id)initWith4STime:(_4STime) st;

- (_4STime)get4STime;

- (NSComparisonResult)justCompare:(NSDate *)theOtherDate;

- (NSString*)timeStringBaseNow;

- (NSString*)myFormatDateString;

- (NSString*)myShortFormatDateString;

@end


#pragma mark -
#pragma mark my NSData

@interface NSData(_MyMethod)



//@property (nonatomic)	UInt32 nCursor;
- (bool)dataEnough:(UInt16) len;
- (void)resetCursor;
- (UInt16)getCursor;
- (bool)setCursor:(UInt16)iCursor;

- (NSString*)fetch4SString;
- (NSString*)fetch4SWString;
- (UInt32)fetchUInt32Value;
- (UInt16)fetchUInt16Value;
- (UInt8)fetchUInt8Value;
- (NSDate*)fetch4STime;
- (NSData*)fetchDataBlock:(UInt16)len;

- (Float32)fetchFloat32Value;

@end

@interface NSMutableData (_MyMethod)

- (void)appendUInt32:(UInt32)value;
- (void)appendUInt16:(UInt16)value;
- (void)appendUInt8:(UInt8)value;
- (void)append4SString:(NSString*)value;
- (void)append4SWString:(NSString*)value;
- (void)append4STime:(_4STime)time;
//add by oudongjia 2011.09.22
- (void)appendUChar32:(NSString *)value;
//add by oudongjia 2012.10.11
- (void)appendFloat32:(Float32)value;

@end





#pragma mark - Packet and request response

@interface PacketHeader : NSObject
{
	UInt8	flag;
	UInt8	version;
	UInt8	keyType;
	UInt16	cmdId;
	UInt16	seq;
	UInt32	srcId;
	UInt32	destId;
	
	UInt32	bodyLen;
}

@property (nonatomic)	UInt16 seq;
@property (nonatomic)	UInt16 cmdId;
@property (nonatomic)	UInt32 bodyLen;
@property (nonatomic)   UInt8  keyType;
@property (nonatomic)	UInt32	srcId;
@property (nonatomic)	UInt32	destId;

- (id)initWithNetData:(NSData*)netData;

- (id)initWithFlag:(UInt8)f andKeyType:(UInt8)kt andCmdId:(UInt16)cid andSrcId:(UInt32)sid andDestId:(UInt32)did;

- (NSData*)formatHeaderToData;

+ (UInt16)getSeqNO;

@end

@interface ClientRequest : PacketHeader
{
	
}

@property (nonatomic) float timeoutInterval;
@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) BOOL isSended;

- (NSData*)getBodyData;

@end




@interface ClientResponse : PacketHeader
{

}

//@property (nonatomic) UInt8	retValue;
//@property (nonatomic, retain) NSString*  errorString;

@property (nonatomic, retain) NSData* busiData;


- (id)initWithNetData:(NSData*)data;

@end


