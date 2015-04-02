//
//  UserInfo_assist.m
//  Smartbox
//
//  Created by Mesada on 15/3/18.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "UserInfo_assist.h"

@implementation UserInfo_assist
@synthesize carnumber;
@synthesize cartype;
@synthesize lastlogindate;
@synthesize level;
@synthesize nickname;
@synthesize phonenumber;
@synthesize pwd;
@synthesize userId;
@synthesize purchaseCarDate;
@synthesize policyDate;
@synthesize sex;


+(instancetype)initWithManagedObject:(UserInfo*)ManagedObject
{
    if (ManagedObject) {
        UserInfo_assist* instance = [[UserInfo_assist alloc]init];
        instance.carnumber = ManagedObject.carnumber;
        instance.cartype = ManagedObject.cartype;
        instance.lastlogindate = ManagedObject.lastlogindate;
        instance.level = ManagedObject.level;
        instance.nickname = ManagedObject.nickname;
        instance.pwd = ManagedObject.pwd;
        instance.userId = ManagedObject.userId;
        instance.purchaseCarDate = ManagedObject.purchaseCarDate;
        instance.policyDate = ManagedObject.policyDate;
        instance.sex = ManagedObject.sex;
        return instance;
    }

    return  nil;
}
@end
