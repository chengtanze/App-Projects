//
//  mmDAO.h
//  agent
//
//  Created by LiMing on 14-6-24.
//  Copyright (c) 2014年 bangban. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

typedef void(^OperationResult)(NSError* error);

@interface CoreDataDAO : NSObject
//@property (readonly, strong, nonatomic) NSOperationQueue *queue;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly ,strong, nonatomic) NSManagedObjectContext *bgObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *mainObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(CoreDataDAO*)instance;
-(void) setupEnvModel:(NSString *)model DbFile:(NSString*)filename;
- (NSManagedObjectContext *)createPrivateObjectContext;
-(NSError*)save:(OperationResult)handler;

@end
