//
//  UserInfo.h
//  Smartbox
//
//  Created by Mesada on 15/3/18.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSString * carnumber;
@property (nonatomic, retain) NSString * cartype;
@property (nonatomic, retain) NSDate * lastlogindate;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * phonenumber;
@property (nonatomic, retain) NSString * pwd;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSString * purchaseCarDate;
@property (nonatomic, retain) NSString * policyDate;
@property (nonatomic, retain) NSNumber * sex;

@end
