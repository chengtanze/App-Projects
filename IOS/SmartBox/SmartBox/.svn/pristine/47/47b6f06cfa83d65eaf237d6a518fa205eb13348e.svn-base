//
//  landscapeTableView.m
//  testTableview
//
//  Created by Mesada on 14/12/10.
//  Copyright (c) 2014年 bobo. All rights reserved.
//

#import "landscapeTableView.h"

@interface landscapeTableView (){

    CGSize landscapeSize;
    CGPoint landscapePoint;
}
@end
@implementation landscapeTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        landscapePoint =self.frame.origin;
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
        self.frame = CGRectMake(landscapePoint.x, landscapePoint.y,self.frame.size.height, self.frame.size.width);
        landscapeSize = self.frame.size;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        landscapeSize = self.frame.size;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        landscapeSize = self.frame.size;
    }
    return self;
}

- (void)reloadData{
    self.frame = CGRectMake(landscapePoint.x, landscapePoint.y, landscapeSize.width,landscapeSize.height);
    [super reloadData];
}

+(void)adjustCell:( UITableViewCell *) cell
{
    //NSLog(@"1cell.frame = [%f,%f]",cell.frame.size.width, cell.frame.size.height);
    cell.transform = CGAffineTransformMakeRotation(-M_PI/2);
   //  NSLog(@"2cell.frame = [%f,%f]",cell.frame.size.width, cell.frame.size.height);
    cell.frame = CGRectMake(0, 0, cell.contentView.frame.size.height, cell.contentView.frame.size.width);
  //  NSLog(@"3cell.frame = [%f,%f]",cell.frame.size.width, cell.frame.size.height);
}




@end
