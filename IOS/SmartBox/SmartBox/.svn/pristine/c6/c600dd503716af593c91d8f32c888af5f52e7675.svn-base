//
//  ClientBase.m
//  ShoujiUIDemo
//
//  Created by PippoTan on 11-7-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClientBase.h"

@implementation NSDate (_MyExtent)

+ (id)initWith4STime:(_4STime) st
{
	NSCalendar* chineseCalendar = [NSCalendar currentCalendar];
	NSDateComponents* components =[[NSDateComponents alloc] init];
	[components setYear:st.year];
	[components setMonth:st.month];
	[components setDay:st.day];
	[components setHour:st.hour];
	[components setMinute:st.min];
	[components setSecond:st.sec];
	
	NSDate *theDate = [chineseCalendar dateFromComponents:components];
	
	return theDate;
}

//(NSTimeZone *)localTimeZone;
//NSArray* zonArray = [NSTimeZone knownTimeZoneNames];
//NSTimeZone* myZone = [NSTimeZone localTimeZone];
//NSLog(@"THe zone is %@", myZone);

- (NSString*)myFormatDateString
{
	NSCalendar* chineseCalendar = [NSCalendar currentCalendar];
	[chineseCalendar setTimeZone:[NSTimeZone localTimeZone]];
	
	unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents* components =[chineseCalendar components:unitFlags fromDate:self];
	
	return [NSString stringWithFormat:@"%ld-%02d-%02d %02d:%02d:%02d", 
			(long)components.year, components.month, components.day, components.hour, components.minute, components.second];
}

- (NSString*)myShortFormatDateString
{
	NSCalendar* chineseCalendar = [NSCalendar currentCalendar];
	[chineseCalendar setTimeZone:[NSTimeZone localTimeZone]];
	
	unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents* components =[chineseCalendar components:unitFlags fromDate:self];
	
	NSDateComponents* componentNow = [chineseCalendar components:unitFlags fromDate:[NSDate date]];
	
	if ((componentNow.year == components.year))
	{
		if(componentNow.month == components.month)
		{
			if (componentNow.day == components.day) {
				return [NSString stringWithFormat:@"今天 %2d:%02d", components.hour, components.minute];
			}
			else if(componentNow.day == components.day + 1){
				return [NSString stringWithFormat:@"昨天 %2d:%02d", components.hour, components.minute];
			}
			else {
				return [NSString stringWithFormat:@"%d日 %2d:%02d", components.day, components.hour, components.minute];
			}
		}
		else {
			return [NSString stringWithFormat:@"%d月%d日", components.month, components.day];
		}

	}
	return [NSString stringWithFormat:@"%d-%d-%d", components.year,components.month, components.day];
}

- (_4STime)get4STime
{
	_4STime time = {0};
	
	//NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | 
	NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	comps = [calendar components:unitFlags fromDate:self];
	time.year = [comps year];    
	time.month = [comps month];
	time.day = [comps day];
	time.hour = [comps hour];
	time.min = [comps minute];
	time.sec = [comps second]; 
	
	
	return time;
}

- (NSComparisonResult)justCompare:(NSDate *)theOtherDate
{
	NSTimeInterval result = [self timeIntervalSinceDate:theOtherDate];
	if (result > 0.0) {
		return NSOrderedAscending;
	}
	else {
		return NSOrderedDescending;
	}
}

- (NSString*)timeStringBaseNow
{
	NSInteger secsBefore = (NSInteger)(-[self timeIntervalSinceDate:[NSDate date]]);
	
	if (secsBefore < 3600) {
		if(secsBefore < 0)
			return [NSString stringWithFormat:@"0分钟前"];
		return [NSString stringWithFormat:@"%d分钟前", secsBefore/60 + 1];
	}
	
	return [self myShortFormatDateString];
}

@end

@implementation NSData(_MyMethod)

static    UInt16 nCursor;
//@synthesize nCursor;
- (void)resetCursor
{
	nCursor = 0;
}

- (bool)dataEnough:(UInt16) len
{
	return (self.length - nCursor < len) ? NO : YES;
}

- (UInt16)getCursor
{
	return nCursor;
}
- (bool)setCursor:(UInt16)iCursor
{
	if(self.length >= iCursor){
		nCursor = iCursor;
		return YES;
	}
	else {
		return NO;
	}
	return	NO;

}

- (NSString*)fetch4SString
{
	UInt16 nLen = 0;
	if ([self dataEnough:2]) {
		nLen = [self fetchUInt16Value];
	}
	else {
		return nil;
	}
	
	//NSLog(@"fetch4SString len = %d", nLen);

	if ([self dataEnough:nLen] ) {
		char ch = *(char*)(self.bytes + nCursor + nLen - 1);
		if (ch == 0) {
			//- (id)initWithCharacters:(const unichar *)characters length:(NSUInteger)length;
			char* begin = (char*)(self.bytes + nCursor);
			NSString* retString = [[NSString alloc] initWithUTF8String:begin];//字符在'\0'处结尾
			nCursor += nLen;
			if (nLen == 1) {
				return nil;
			}			
			return retString;			
		}
	}	
	
	return nil;
}

- (NSString*)fetch4SWString
{
	UInt16 nLen = 0;
	if ([self dataEnough:2]) {
		nLen = [self fetchUInt16Value];
	}
	else {
		return nil;
	}
	
	//NSLog(@"fetch4SWString len = %d", nLen);
	
	if (nLen > 0 && [self dataEnough: nLen*2]) {
		const unichar* begin = (const unichar*)(self.bytes + nCursor);
		NSString* retString = [[NSString alloc] initWithCharacters:begin length:nLen - 1]; //length 为字符的长度 不是byte长度 该len包含'\0'结尾符
		nCursor += nLen * 2;
		if (nLen == 1) {
			NSLog(@"Fetch4SWString = nil.");
			return nil;
		}
		return retString;
	} 
	
	return nil;	
}

- (Float32)fetchFloat32Value
{
	Float32 retValue = 0;
	if ([self dataEnough:4]) {
		[self getBytes:&retValue range:NSMakeRange(nCursor, 4)];
		nCursor += 4;
	}
	return retValue;
}

- (UInt32)fetchUInt32Value
{
	UInt32 retValue = 0;
	if ([self dataEnough:4]) {
		[self getBytes:&retValue range:NSMakeRange(nCursor, 4)];
		nCursor += 4;
	}
	return retValue;
}

- (UInt16)fetchUInt16Value
{
	UInt16 retValue = 0;
	if ([self dataEnough:2]) {
		[self getBytes:&retValue range:NSMakeRange(nCursor, 2)];
		nCursor += 2;
	}
	return retValue;
}

- (UInt8)fetchUInt8Value
{
	UInt8 retValue = 0;
	if ([self dataEnough:1]) {
		[self getBytes:&retValue range:NSMakeRange(nCursor, 1)];
		nCursor += 1;
	}
	return retValue;
}

- (NSData*)fetchDataBlock:(UInt16)len
{
	if ([self dataEnough:len]) {
		void* dataBegin = (void*)(self.bytes + nCursor);
		nCursor += len;
		return [NSData dataWithBytes:dataBegin length:len];
	}
	return nil;
}

- (NSDate*)fetch4STime
{
	if ([self dataEnough:7]) {
		_4STime st = { 0 };
		st.year = [self fetchUInt16Value];
		st.month = [self fetchUInt8Value];
		st.day = [self fetchUInt8Value];
		st.hour = [self fetchUInt8Value];
		st.min = [self fetchUInt8Value];
		st.sec = [self fetchUInt8Value];
		
		return [NSDate initWith4STime:st];
	}
	return nil;
}

@end

@implementation NSMutableData (_MyMethod)

- (void)appendFloat32:(Float32)value
{
	[self appendBytes:&value length:4];
}

- (void)appendUInt32:(UInt32)value
{
	[self appendBytes:&value length:4];
}

- (void)appendUInt16:(UInt16)value
{
	[self appendBytes:&value length:2];
}

- (void)appendUInt8:(UInt8)value
{
	[self appendBytes:&value length:1];
}

- (void)append4SString:(NSString*)value
{
	UInt16 len = value.length + 1;
	[self appendBytes:&len length:2];
	const char* buffer = [value cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
	[self appendBytes:buffer length:value.length];
	
	//end with '\0'
	UInt8 strEnd = 0;
	[self appendBytes:&strEnd length:1];
}

#define BUFFER_LEN	1024
- (void)append4SWString:(NSString*)value
{
	UInt16 len = value.length + 1;
	[self appendBytes:&len length:2];
	
	unichar wBuffer[BUFFER_LEN + 1] = {0};

	NSInteger lenRetain = value.length;
	NSInteger lenApped = 0;
	while (lenRetain) {
		NSInteger wLen = lenRetain > BUFFER_LEN ? BUFFER_LEN : lenRetain;
		[value getCharacters:wBuffer range:NSMakeRange(lenApped, lenApped + wLen)];
		[self appendBytes:wBuffer length:wLen*2];
		lenApped += wLen;
		lenRetain -= wLen;
	}
	
	//end with '\0'
	UInt16 strEnd = 0;
	[self appendUInt16:strEnd];
}

- (void)append4STime:(_4STime)time
{
	[self appendUInt16:time.year];
	[self appendUInt8:time.month];
	[self appendUInt8:time.day];
	[self appendUInt8:time.hour];
	[self appendUInt8:time.min];
	[self appendUInt8:time.sec];
}

//add by oudongjia 2011.09.22
- (void)appendUChar32:(NSString *)value
{
	uint32_t i = 0;
	uint32_t tmpNum = 0;
	uint32_t len  = 0,k = 0;
	char NumString[3] = {'\0','\0','\0'};
	const char *buf ;//= [value UTF8String];
	
	//转换为16进制
	if(value == nil)
	{
		NSLog(@"deviceToken is nil;");
		NSString *str = @"aa"; 
		buf = [str UTF8String];
	}
	else 
	{
		buf = [value UTF8String];
		len = strlen(buf);
	}
	for(i = 0;i < len;i+=2)
	{
		if(((i+1)< len) && isxdigit(buf[i]) && (isxdigit(buf[i+1])))
		{
			NumString[0] = buf[i];
			NumString[1] = buf[i+1];
			sscanf(NumString, "%x",&tmpNum);
			[self appendBytes:(void*)&tmpNum length:1];
			k++;
			
		}
		else {
			break;
		}
	}

}
@end



@implementation PacketHeader

@synthesize seq;
@synthesize cmdId;
@synthesize bodyLen;
@synthesize keyType;
@synthesize srcId;
@synthesize destId;


- (id)initWithFlag:(UInt8)f andKeyType:(UInt8)kt andCmdId:(UInt16)cid andSrcId:(UInt32)sid andDestId:(UInt32)did
{
	if (self = [super init]) {
		flag = f;
		version = CLIENT_VERSION;
		keyType = kt;
		cmdId = cid;
		seq = [PacketHeader getSeqNO];
		srcId = sid;
		destId = did;
		bodyLen = 0;
	}
	
	return self;
}

- (id)initWithNetData:(NSData*)netData
{
	if (self = [super init]) {
		
		//for test NSData
		/*
		unsigned char aBuffer[20];
		NSString *myString = @"123456789";
		const char *utfString = [myString UTF8String];
		NSData *myData = [NSData dataWithBytes: utfString length: strlen(utfString)];
		[myData getBytes:aBuffer];
		*/
		//end test
		
		//
		if ([netData length] >= CLIENT_HEADER_LEN) 
		{
			[netData getBytes:&flag range:NSMakeRange(0,1)];
			[netData getBytes:&version range:NSMakeRange(1,1)];
			[netData getBytes:&keyType range:NSMakeRange(2,1)];
			[netData getBytes:&cmdId range:NSMakeRange(3,2)];
			[netData getBytes:&seq range:NSMakeRange(5,2)];
			[netData getBytes:&srcId range:NSMakeRange(7,4)];
			[netData getBytes:&destId range:NSMakeRange(11,4)];
			[netData getBytes:&bodyLen range:NSMakeRange(15,4)];
		}
	}
	
	return self;
}

- (NSData*)formatHeaderToData
{
	NSMutableData* headerData = [[NSMutableData alloc] init];
	[headerData appendBytes:&flag length:1];
	[headerData appendBytes:&version length:1];
	[headerData appendBytes:&keyType length:1];
	[headerData appendBytes:&cmdId length:2];
	[headerData appendBytes:&seq length:2];
	[headerData appendBytes:&srcId length:4];
	[headerData appendBytes:&destId length:4];
	[headerData appendBytes:&bodyLen length:4];
	
	return (NSData*)headerData;
}

+ (UInt16)getSeqNO
{
	static UInt16 kSeq = 1;
	if (kSeq >= 65530) {
		kSeq = 1;
	}
	return ++kSeq;
}

@end


@implementation ClientRequest

@synthesize timeoutInterval;
@synthesize startTime;
@synthesize isSended;

- (NSData*)getBodyData
{
	//assert(NO);
	return nil;
}
- (UInt32)getBodyLength
{
	assert(NO);
	return 0;
}
- (id)copyWithZone:(NSZone *)zone
{
	return self ;
}

@end


@implementation ClientResponse

//@synthesize retValue;
//@synthesize errorString;
@synthesize busiData;

- (id)initWithNetData:(NSData*)data
{
	self = [super initWithNetData:data];
	
	return self;
}

@end





