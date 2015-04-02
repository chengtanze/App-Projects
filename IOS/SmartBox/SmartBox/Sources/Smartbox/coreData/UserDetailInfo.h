//
//  UserDetailInfo.h
//  Smartbox
//
//  Created by Mesada on 14/11/10.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface UserDetailInfo : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * carcolor;
@property (nonatomic, retain) NSString * carnumber;
@property (nonatomic, retain) NSString * cartype;
@property (nonatomic, retain) NSNumber * displacement;
@property (nonatomic, retain) NSString * phonenumber;
@property (nonatomic, retain) NSNumber * phoneopen;
@property (nonatomic, retain) User *owner;

@end
