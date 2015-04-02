//
//  roadRescuelLogController.m
//  Smartbox
//
//  Created by Mesada on 15/3/28.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "roadRescuelLogController.h"
#import "httpRequest.h"

@interface roadRescuelLogController ()

@end

@implementation roadRescuelLogController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
