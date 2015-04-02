//
//  MessagesController.m
//  Smartbox
//
//  Created by Mesada on 14/12/27.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "MessagesController.h"
#import "messageCell.h"
@interface MessagesController ()

@end

@implementation MessagesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//   self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- uitableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    messageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    Message* messag = [[Message alloc]init];
    if(indexPath.row == 0)
    {
            messag.content = @"IOS UI v";
    }
    else
    {
                messag.content = @"IOS UI view button 自定义颜色……_iOS基地_新浪博客(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPathIOS UI view button 自定义颜色……_iOS基地_新浪博客(UITableViewCell *)tableView:(UITableView *)IOS UI view button 自定义颜色……_iOS基地_新浪博客(UITableViewCell *)tableView:(UITableView *)";
    }
    messag.icon = @"4-4SMART-BOX-消息_电子围栏";
    cell.message = messag;
    return  cell;
}


//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    messageCell* cell = (messageCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog(@"cell.cellHeight = %f",size.height);
//    return size.height+1;
   return cell.cellHeight;
//   return 200;
    
    
}

@end
