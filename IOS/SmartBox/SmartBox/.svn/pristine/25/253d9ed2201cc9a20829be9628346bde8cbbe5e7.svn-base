//
//  UserDAO.h
//  Smartbox
//
//  Created by Mesada on 14/11/10.
//  Copyright (c) 2014年 mesada. All rights reserved.
//



#import "Userinfo_assist.h"


@interface UserDAO:NSObject

+ (UserDAO*)sharedManager;

//-(void)modifyUserData:(UserInfo_assist*)model;
-(void)updateUserInfo:(NSInteger)userID detailinfo:(NSDictionary*)dicInfo bCreate:(BOOL)bCreate;
-(UserInfo_assist*)find:(NSInteger)userID;
////插入Note方法
//-(int) create:(User*)model;
//
////删除Note方法
//-(int) remove:(User*)model;
//
////修改Note方法
//-(int) modify:(User*)model;
//
////查询所有数据方法
//-(NSMutableArray*) findAll;
//
////按照主键查询数据方法
//-(User*) findById:(User*)model;

@end
