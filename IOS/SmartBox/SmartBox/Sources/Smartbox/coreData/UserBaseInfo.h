//
//  UserBaseInfo.h
//  Smartbox
//
//  Created by Mesada on 14/11/10.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface UserBaseInfo : NSManagedObject

@property (nonatomic, retain) NSString * carinfo;
@property (nonatomic, retain) NSString * figureurl;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSString * locatearea;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSString * signtext;
@property (nonatomic, retain) User *owner;

@end
