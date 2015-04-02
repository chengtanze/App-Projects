//
//  PKListTotalScoreTableViewController.m
//  Smartbox
//
//  Created by wangsl-iMac on 15/3/10.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "PKListTotalScoreTableViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "PKCell.h"
#import "PublicFunction.h"
@interface PKListTotalScoreTableViewController ()

@end

@implementation PKListTotalScoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (HUD) {
        [HUD removeFromSuperview];
        HUD = nil;
    }
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"获取数据中...";
    [HUD show:YES];
    
    [[AFAppDotNetAPIClient sharedClient] getUserTotalScore:^(NSArray *repondData, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(!error)
        {
            if (repondData != nil) {
                
                self.userInfo = repondData;
                
                [self.tableView reloadData];
                
                NSLog(@"getUserTotalScore callback");
            }
        }
        else{
            [self showMessge:@"网络错误，请稍后重试"];

        }
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)showMessge:(NSString *)mes
{
    if (HUD) {
        [HUD removeFromSuperViewOnHide];
        HUD.hidden = YES;
        HUD = nil;
    }
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.customView = [[UIImageView alloc] init];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = mes;
    [HUD hide:YES afterDelay:2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.userInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PKCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PKCell"];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PKCell" owner:self options:nil]objectAtIndex:0];
        cell.nameView.text = [self.userInfo[indexPath.row] valueForKey:@"nickname"];
        cell.carNameView.text = [self.userInfo[indexPath.row] valueForKey:@"carType"];
        cell.scoreView.text = [self.userInfo[indexPath.row] valueForKey:@"gradeName"];
        cell.mileageView.text = [self.userInfo[indexPath.row] valueForKey:@"score"];
        cell.rankingView = [self.userInfo[indexPath.row] valueForKey:@"rankOrder"];
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static CGFloat cellHeight = 0;
    if (cellHeight == 0) {
        cellHeight = [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
    }
    return cellHeight;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
