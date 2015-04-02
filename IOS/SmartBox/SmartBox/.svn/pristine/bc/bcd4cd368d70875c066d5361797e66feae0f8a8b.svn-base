//
//  medalViewController.m
//  Smartbox
//
//  Created by Mesada on 15/1/9.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import "medalViewController.h"
#import "medalCollectionCell.h"

@interface medalViewController ()

@end

@implementation medalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 11;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    medalCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"medalCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"首次使用.png"];
    return cell;
}

-(void)viewDidAppear:(BOOL)animated
{

}
@end
