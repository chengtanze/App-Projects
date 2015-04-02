//
//  PKListTableViewController.m
//  Smartbox
//
//  Created by Mesada on 14/12/31.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "PKListTableViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "PKCell.h"
@interface PKListTableViewController ()

@end

@implementation PKListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[AFAppDotNetAPIClient sharedClient] getUserPointOfDate:^(NSArray *repondData, NSError *error) {
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(!error)
        {
            if (repondData != nil) {
                
                self.userInfo = repondData;
                
                [self.tableView reloadData];
                
                NSLog(@"getUserTotalScore callback");
            }
        }
        else{
            //[self showMessge:@"网络错误，请稍后重试"];
            
        }
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
        cell.scoreView.text = [self.userInfo[indexPath.row] valueForKey:@"score"];
        cell.mileageView.text = [self.userInfo[indexPath.row] valueForKey:@"mileage"];
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
