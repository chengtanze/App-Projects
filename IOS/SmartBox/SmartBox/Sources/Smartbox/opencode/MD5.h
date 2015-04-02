//
//  MD5.h
//  inCarTime
//
//  Created by zhu xian on 11-8-5.
//  Copyright 2011 z. All rights reserved.
//
#import "PCHHeader.h"
#import <CommonCrypto/CommonDigest.h>
@interface NSString (md5)

- (NSString *) MD5;

@end

//调用例子
//NSString *myString = @"test";
//NSString *md5 = [myString MD5]; //returns NSString of the MD5 of test