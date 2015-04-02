//
//  HostManager.h
//  addressList
//
//  Created by yang kong on 12-5-10.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HostManager : NSObject {

}


+ (HostManager*)getInstance;
+ (NSString *)getIPAddressForHostString:(NSString *) theHost ;


//获取本地iphone　IP　

-(void) InitAddresses ;
-(void) FreeAddresses;
-(void) GetIPAddresses;
-(NSString *)deviceIPAdress;
@end
