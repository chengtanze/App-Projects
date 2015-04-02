//
//  UserDAO.m
//  Smartbox
//
//  Created by Mesada on 14/11/10.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "UserDAO.h"
#import "asyncCoreDataWrapper.h"

@implementation UserDAO

static UserDAO *sharedManager = nil;

+ (UserDAO*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[UserDAO alloc] init];
    });
    return sharedManager;
}

-(void)updateUserInfo:(NSInteger)userID detailinfo:(NSDictionary*)dicInfo
{
    NSManagedObjectContext *context = [[CoreDataDAO instance] createPrivateObjectContext];
    [context performBlockAndWait:^{
        NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"id = %d", userID];
        
        NSError* error = nil;
        User* theUser = [[context executeFetchRequest:fetchRequest error:&error]lastObject];
        if (theUser) //not exist
        {
            
            if (theUser.baseinfo == nil) {
                NSLog(@"Create user baseinfo.");
                theUser.baseinfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserBaseInfo" inManagedObjectContext:context];
                theUser.baseinfo.owner = theUser;
            }
            if (theUser.detailinfo == nil) {
                NSLog(@"Create user detailinfo.");
                theUser.detailinfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserDetailInfo" inManagedObjectContext:context];
                theUser.detailinfo.owner = theUser;
            }
            
            NSString* strFigureURL = [dicInfo objectForKey:@"figureURL"];
            if (strFigureURL != nil) {
                if (![[strFigureURL lastPathComponent] isEqualToString:@"user_photo.gif"]) {
                    theUser.baseinfo.figureurl = strFigureURL;
                }
            }
            
            //self.baseinfo.figureurl = [dicInfo objectForKey:@"figureURL"];
            theUser.baseinfo.signtext = [dicInfo objectForKey:@"sign"];
            theUser.baseinfo.nickname = [dicInfo objectForKey:@"nickName"];
            theUser.baseinfo.level = [dicInfo objectForKey:@"level"];
            theUser.baseinfo.locatearea = [dicInfo objectForKey:@"locate"];
            theUser.baseinfo.sex = [dicInfo objectForKey:@"sex"];
            theUser.baseinfo.carinfo = [dicInfo objectForKey:@"carType"];
            
            
            theUser.detailinfo.phonenumber = [dicInfo objectForKey:@"phoneNo"];
            theUser.detailinfo.carcolor = [dicInfo objectForKey:@"carColor"];
            theUser.detailinfo.age = [dicInfo objectForKey:@"age"];
            theUser.detailinfo.cartype = [dicInfo objectForKey:@"carType"];
            theUser.detailinfo.carnumber = [dicInfo objectForKey:@"carNo"];
            theUser.detailinfo.phoneopen = [dicInfo objectForKey:@"phoneOpen"];
            theUser.detailinfo.displacement = [dicInfo objectForKey:@"displacement"];
            
            if([context save:&error])
            {
                NSLog(@"修改数据成功");
            }
            else
            {
                NSLog(@"修改数据失败");
            }
        }
    }];
}

-(void)modifyUserData:(User_assist*)model
{
     ////
     NSManagedObjectContext *ctx = [[CoreDataDAO instance] createPrivateObjectContext];
     [ctx performBlockAndWait:^{
        NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:ctx];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"id = %d", model.id];

        NSError* error = nil;
        User* theUser = [[ctx executeFetchRequest:fetchRequest error:&error]lastObject];
        if (!error && !theUser) //not exist
        {
            theUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:ctx];
            theUser.id = model.id;
            theUser.password = model.password;
            theUser.emailAccount = model.emailAccount;
            theUser.lastlogindate  = model.lastlogindate;
            
        }
        else {
            // NSLog(@"Find the user id = %d", theId);
            theUser.password = model.password;
            theUser.emailAccount = model.emailAccount;
            theUser.lastlogindate  = model.lastlogindate;
        }
        
      
         if([ctx save:&error])
        {
            //[[CoreDataDAO instance] save:nil];
             NSLog(@"修改数据成功");
        }
        else
        {
             NSLog(@"修改数据失败");
        }

    }];
    
    ///test
//   NSManagedObjectContext *ctxtest = [[CoreDataDAO instance] createPrivateObjectContext];
//   [ctxtest performBlockAndWait:^{
//        NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
//        fetchRequest.entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:ctxtest];
//        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"id = %d", model.id];
//        
//        NSError* error = nil;
//        User* theUserctxtest = [[ctxtest executeFetchRequest:fetchRequest error:&error]lastObject];
//        if(theUserctxtest)
//        {
//            NSLog(@"%d",theUserctxtest.password);
//        }
//
//   }];
}


////插入Note方法
//-(int) create:(User*)model
//{
//    
//    NSManagedObjectContext *cxt = [self managedObjectContext];
//    
//    User *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:cxt];
//    [note setValue: model.content forKey:@"content"];
//    [note setValue: model.date forKey:@"date"];
//    
//    note.date = model.date;
//    note.content = model.content;
//    
//    NSError *savingError = nil;
//    if ([self.managedObjectContext save:&savingError]){
//        NSLog(@"插入数据成功");
//    } else {
//        NSLog(@"插入数据失败");
//        return -1;
//    }
//    
//    return 0;
//}
//
////删除Note方法
//-(int) remove:(User*)model
//{
//    
//    NSManagedObjectContext *cxt = [self managedObjectContext];
//    
//    NSEntityDescription *entityDescription = [NSEntityDescription
//                                              entityForName:@"Note" inManagedObjectContext:cxt];
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entityDescription];
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:
//                              @"date =  %@", model.date];
//    [request setPredicate:predicate];
//    
//    NSError *error = nil;
//    NSArray *listData = [cxt executeFetchRequest:request error:&error];
//    if ([listData count] > 0) {
//        NoteManagedObject *note = [listData lastObject];
//        [self.managedObjectContext deleteObject:note];
//        
//        NSError *savingError = nil;
//        if ([self.managedObjectContext save:&savingError]){
//            NSLog(@"删除数据成功");
//        } else {
//            NSLog(@"删除数据失败");
//            return -1;
//        }
//    }
//    
//    return 0;
//}
//
////修改Note方法
//-(int) modify:(Note*)model
//{
//    NSManagedObjectContext *cxt = [self managedObjectContext];
//    
//    NSEntityDescription *entityDescription = [NSEntityDescription
//                                              entityForName:@"Note" inManagedObjectContext:cxt];
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entityDescription];
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:
//                              @"date =  %@", model.date];
//    [request setPredicate:predicate];
//    
//    NSError *error = nil;
//    NSArray *listData = [cxt executeFetchRequest:request error:&error];
//    if ([listData count] > 0) {
//        NoteManagedObject *note = [listData lastObject];
//        note.content = model.content;
//        
//        NSError *savingError = nil;
//        if ([self.managedObjectContext save:&savingError]){
//            NSLog(@"修改数据成功");
//        } else {
//            NSLog(@"修改数据失败");
//            return -1;
//        }
//    }
//    return 0;
//}
//
////查询所有数据方法
//-(NSMutableArray*) findAll
//{
//    NSManagedObjectContext *cxt = [self managedObjectContext];
//    
//    NSEntityDescription *entityDescription = [NSEntityDescription
//                                              entityForName:@"Note" inManagedObjectContext:cxt];
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entityDescription];
//    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
//    [request setSortDescriptors:@[sortDescriptor]];
//    
//    NSError *error = nil;
//    NSArray *listData = [cxt executeFetchRequest:request error:&error];
//    
//    NSMutableArray *resListData = [[NSMutableArray alloc] init];
//    
//    for (NoteManagedObject *mo in listData) {
//        Note *note = [[Note alloc] init];
//        note.date = mo.date;
//        note.content = mo.content;
//        [resListData addObject:note];
//    }
//    
//    return resListData;
//}
//
////按照主键查询数据方法
//-(Note*) findById:(Note*)model
//{
//    NSManagedObjectContext *cxt = [self managedObjectContext];
//    
//    NSEntityDescription *entityDescription = [NSEntityDescription
//                                              entityForName:@"Note" inManagedObjectContext:cxt];
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entityDescription];
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:
//                              @"date =  %@",model.date];
//    [request setPredicate:predicate];
//    
//    NSError *error = nil;
//    NSArray *listData = [cxt executeFetchRequest:request error:&error];
//    
//    if ([listData count] > 0) {
//        NoteManagedObject *mo = [listData lastObject];
//        
//        Note *note = [[Note alloc] init];
//        note.date = mo.date;
//        note.content = mo.content;
//        
//        return note;
//    }
//    return nil;
//}
@end
