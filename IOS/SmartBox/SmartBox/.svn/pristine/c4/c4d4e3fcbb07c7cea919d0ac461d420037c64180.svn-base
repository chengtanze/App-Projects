//
//  InjuredRescueLog.m
//  Smartbox
//
//  Created by Mesada on 15/3/26.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "InjuredRescueLog.h"
#import "InjuredEndCell.h"
#import "InjuredProCell.h"
#import "InjuredReqCell.h"
#import "httpRequest.h"

#import <UIKit/UIKit.h>
@implementation InjuredCellData
@end

typedef NS_ENUM(NSInteger, RESCUECOMMENT)
{
    RESCUECOMMENT_BAD = 1001,
    RESCUECOMMENT_NORMAL,
    RESCUECOMMENT_GOOD,
    RESCUECOMMENT_VERYGOOD
};

@interface InjuredRescueLog ()

@end

@implementation InjuredRescueLog

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getComment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
#pragma mark--UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   InjuredCellData* celldata = [_dataSource objectAtIndex:indexPath.row];
    switch (indexPath.row)
    {
        case 0:
           {
            InjuredReqCell* cell = (InjuredReqCell*)[tableView dequeueReusableCellWithIdentifier:@"IRescueReq"];
            [cell setDescriptionTextAndTime:celldata.desc time:celldata.timestr done:celldata.done];
            return cell;
            }
        case 1:
           {
             InjuredProCell* cell = (InjuredProCell*)[tableView dequeueReusableCellWithIdentifier:@"IRescuePro"];
             [cell setDescriptionTextAndTime:celldata.desc time:celldata.timestr done:celldata.done];
            return cell;
           }
            case 2:
           {
             InjuredEndCell* cell = (InjuredEndCell*)[tableView dequeueReusableCellWithIdentifier:@"IRescueEnd"];
             [cell setDescriptionTextAndTime:celldata.desc time:celldata.timestr done:celldata.done];
             return cell;
           }
        default:
         {
            InjuredEndCell* cell = (InjuredEndCell*)[tableView dequeueReusableCellWithIdentifier:@"IRescueEnd"];
            [cell setDescriptionTextAndTime:celldata.desc time:celldata.timestr done:celldata.done];
            return cell;
         }
    }
    return nil;
}
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"IRescueReq"];
            return cell.frame.size.height;
        }
        case 1:
        {
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"IRescuePro"];
            return cell.frame.size.height;
        }
        case 2:
        case 4:
        {
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"IRescueEnd"];
            return cell.frame.size.height;
        }
    }
    return 40.0f;
}

-(void)setRescueLogSource:(NSArray *)rescueLogSource{
    if (rescueLogSource.count==0) {
        [self initdata];
        return;
    }
    _rescueId = [[rescueLogSource[0] objectForKey:@"rescueId"] intValue];
    
//    NSArray* tempdata = @[@{@"请求成功":@""},@{@"救护车出发":@""}, @{@"救援成功":@""}];
    NSArray* tempdata = @[@"申请成功",@"救护车出发",@"救援成功"];
    NSMutableArray* rescueArry = [[NSMutableArray alloc]init];

    
    NSInteger index = rescueLogSource.count-1;
    for (;index>0; --index) {
        NSDictionary*  dic =  rescueLogSource[index];
        if (dic) {
            InjuredCellData* celldata = [[InjuredCellData alloc]init];
            celldata.desc = [dic objectForKey:@"statueText"];
            celldata.timestr = [dic objectForKey:@"time"];
            celldata.done = YES;
            [rescueArry addObject:celldata];
            if ([celldata.desc isEqualToString:@"取消救援"])
            {
                _dataSource = rescueArry;
                return;
            }
        }
    }
    index = tempdata.count - rescueLogSource.count+1;//因为第一个放了resuceid所以+1
    index = index>0?index:0;
    for (; index < tempdata.count ; ++index) {
        InjuredCellData* celldata = [[InjuredCellData alloc]init];
        celldata.desc = tempdata[index];
        celldata.timestr = @"";
        celldata.done = NO;

        [rescueArry addObject:celldata];
    }
    _dataSource = rescueArry;
}

-(void)initdata
{
    NSArray* tempdata = @[@"申请成功",@"救护车出发",@"救援成功"];
    NSMutableArray* rescueArry = [[NSMutableArray alloc]init];
    for (int index = 0; index < tempdata.count ; ++index) {
        InjuredCellData* celldata = [[InjuredCellData alloc]init];
        celldata.desc = tempdata[index];
        celldata.timestr = @"";
        celldata.done = NO;
        
        [rescueArry addObject:celldata];
    }
    _dataSource = rescueArry;
}

- (IBAction)handelGestureRecognizers:(UITapGestureRecognizer*)sender {
    
   UIImageView* imageview = (UIImageView*)sender.view;
    [self commentRescue:imageview.tag-1000];
    NSLog(@"imageview.tag =%d",imageview.tag);

}
-(void)setCommentUI:(NSInteger)CommentType
{
    NSArray* commentedImages = @[@"救援-差评-d",@"救援-一般-d",@"救援-好评-d",@"救援-好评2-d"];
    NSArray* commentImages = @[@"救援-差评-n",@"救援-一般-n",@"救援-好评-n",@"救援-好评2-n"];
    [self.commentImageViews enumerateObjectsUsingBlock:^(UIImageView* view, NSUInteger idx, BOOL *stop) {
        view.image = [UIImage imageNamed:commentImages[idx]];
        UILabel* commentlabel = self.commentLabels[idx];
        commentlabel.textColor =  [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.0f];
    }];
    //
    if (CommentType>1 && CommentType<=4) {
        UIImageView *imageview = [self.commentImageViews objectAtIndex:CommentType-1];
        imageview.image = [UIImage imageNamed:commentedImages[CommentType-1]];
        UILabel* commentlabel = self.commentLabels[CommentType-1];
        commentlabel.textColor =  [UIColor colorWithRed:1.0f green:0.62f blue:0.04f alpha:1.0f];
    }
}

-(void)getComment
{
   [self showLoadingHUB:nil];
   [[AFJsonAPIClient sharedClient]getCommentRescue:1 RescueId:_rescueId complete:^(NSDictionary *repondData, NSError *error) {
       [self hideHUD];
       int comment_Type = [[repondData valueForKeyPath:@"cr.type"] intValue];
       [self setCommentUI:comment_Type];
    }];
}

-(void)commentRescue:(NSInteger)commentType
{
    [self showLoadingHUB:nil];
       __block NSInteger comment_type = commentType;
       [[AFJsonAPIClient sharedClient]commentRescue:1 RescueId:_rescueId commentType:commentType complete:^(NSDictionary *repondData, NSError *error) {
           [self hideHUD];
           if (!error) {
               //评论成功
//               int comment_Type = [[repondData valueForKeyPath:@"cr.type"] intValue];
               [self setCommentUI:comment_type];
           }
        }];
}


@end
