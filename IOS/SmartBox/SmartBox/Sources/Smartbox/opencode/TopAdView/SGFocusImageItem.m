//
//  SGFocusImageItem.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "SGFocusImageItem.h"

@implementation SGFocusImageItem
@synthesize title = _title;
@synthesize image = _image;
@synthesize tag = _tag;
@synthesize detail;
@synthesize process;
@synthesize website;
@synthesize phoneNumber;
@synthesize bigImage;

- (void)dealloc
{
    self.title = nil;
    self.image = nil;
//    [super dealloc];
}
- (id)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        self.title = title;
        self.image = image;
        self.tag = tag;
    }
    
    return self;
}

- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag
{
    self = [super init];
    if (self)
    {
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            self.title = [dict objectForKey:@"topic"];
            self.process = [dict valueForKey:@"joinProcess"];
            self.website = [dict valueForKey:@"url"];
            self.image = [[dict valueForKey:@"imgurl"] valueForKey:@"small"];
//            NSLog(@"self.image = %@", self.image);
//            self.bigImage = [[dict valueForKey:@"imgurl"] valueForKey:@"big"];
            self.detail = [dict valueForKey:@"detail"];
            
            //...
        }
    }
    return self;
}
@end
