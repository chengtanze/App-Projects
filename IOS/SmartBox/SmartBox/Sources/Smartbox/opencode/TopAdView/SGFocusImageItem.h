//
//  SGFocusImageItem.h
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//
/*
 
 {
     "activitydate": {
         "date": 4,
         "day": 3,
         "hours": 14,
         "minutes": 0,
         "month": 8,
         "nanos": 0,
         "seconds": 9,
         "time": 1378274409000,
         "timezoneOffset": -480,
         "year": 113
     },
     "activitydateStr": "2013-09-04 14:00",
     "address": "",
     "content": "",
     "detail": "ttt",
     "empName": "",
     "employeeid": 0,
     "id": 650,
     "imgsize": 0,
     "imgurl": {
     "small": "http://testfileservice.365car.com.cn:88/fileService/clb/photo/company/activity/800-480/1376618751283_4f5f51e93451618befd2da36ceb564ae.jpg",
     "big": "http://testfileservice.365car.com.cn:88/fileService/clb/photo/company/activity/800-480/1376618751283_4f5f51e93451618befd2da36ceb564ae.jpg"
     },
     "isdelete": 0,
     "ishome": 1,
     "joinProcess": "aaaaa",
     "latitude": "",
     "longitude": "",
     "merchantid": 0,
     "showPlatform": 2,
     "status": 1,
     "topic": "图片",
     "type": 2,
     "url": "http://www.365car.com.cn"
 }
 
 
 */

#import <Foundation/Foundation.h>

@interface SGFocusImageItem : NSObject

@property (nonatomic, retain)  NSString     *title;
@property (nonatomic, retain)  NSString     *image;
@property (nonatomic, assign)  NSInteger    tag;
@property (nonatomic, retain)  NSString     *detail;
@property (nonatomic, retain)  NSString     *process;
@property (nonatomic, retain)  NSString     *website;
@property (nonatomic, retain)  NSString     *phoneNumber;
@property (nonatomic, retain)  NSString     *bigImage;

- (id)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag;
- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag;
@end
