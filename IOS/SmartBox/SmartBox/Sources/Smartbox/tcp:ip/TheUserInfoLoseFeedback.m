//
//  TheUserInfoLoseFeedback.m
//  InCarTimeV3
//
//  Created by Mesada on 13-10-11.
//  Copyright (c) 2013年 wangsl-iMac. All rights reserved.
//

#import "TheUserInfoLoseFeedback.h"

@implementation TheUserInfoLoseFeedback
@synthesize uuid;
- (id)initWithDataBlock:(NSData *)data
{
    self = [super init];
	if (self) {
		[data setCursor:19];
		NSData *tempData = [data subdataWithRange:NSMakeRange(19, 32)];
        char * p = (char *) [tempData bytes];
        for (int i=0; i<strlen(p); i++) {
            int chInt = p[i];
            printf("%c = %d\n", p[i], chInt);
        }
        NSString *tempStr = [NSString stringWithCString:p encoding:NSASCIIStringEncoding];
        NSLog(@"getUUID = [%@]", tempStr);        
        self.uuid = tempStr;
	}
	return self;
}

//- (void)dealloc
//{
//    if (self.uuid) {
//        [self.uuid release];
//        self.uuid = nil;
//    }
//    [super dealloc];
//}
@end
