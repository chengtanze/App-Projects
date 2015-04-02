//
//  UserDAO.m
//  Smartbox
//
//  Created by Mesada on 14/11/10.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "UserDAO.h"
#import "asyncCoreDataWrapper.h"
#import "UserInfo.h"

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

-(void)updateUserInfo:(NSInteger)userID detailinfo:(NSDictionary*)dicInfo bCreate:(BOOL)bCreate
{
    NSManagedObjectContext *context = [[CoreDataDAO instance] createPrivateObjectContext];
    [context performBlockAndWait:^{
        NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:context];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userId = %d", userID];
        
        NSError* error = nil;
        UserInfo* theUser = [[context executeFetchRequest:fetchRequest error:&error]lastObject];
        if (nil == theUser && bCreate) {
            theUser = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:context];
            if (!error) {
                theUser.userId =  [NSNumber numberWithInteger:userID];
            }
        }
        
        if (theUser)
        {
            NSDictionary* keydic = [NSDictionary dictionaryWithObjects:
                     @[@"carnumber",@"cartype",@"lastlogindate",@"level", @"nickname",@"pwd",@"purchaseCarDate",@"policyDate",@"sex",@"phonenumber"]
            forKeys: @[@"carNumber",@"cartype",@"lastlogindate",@"level",@"nickName",@"pwd",@"purchaseCarDate",@"policyDate",@"sex",@"mobileNo"]
];

            [keydic enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL *stop) {
                NSString* sqlkeyname = keydic[key];
                if (dicInfo[key] && ![key isEqualToString:@"userId"]) {
                    //非string类型要转换
                    if ([key isEqualToString:@"sex"]) {
                        NSInteger sex = [dicInfo[key] integerValue] ;
                        [theUser setValue:[NSNumber numberWithInteger:sex] forKey:sqlkeyname];
                        return;
                    }
                    [theUser setValue:dicInfo[key] forKey:sqlkeyname];
                }
            }];
            
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

-(UserInfo_assist*)find:(NSInteger)userID
{
    NSManagedObjectContext *context = [[CoreDataDAO instance] createPrivateObjectContext];

    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:context];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userId = %d", userID];
    
    NSError* error = nil;
    UserInfo* theUser = [[context executeFetchRequest:fetchRequest error:&error]lastObject];
    if(theUser && !error)
    {
        
        return [UserInfo_assist initWithManagedObject:theUser];
    }
    return nil;
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
