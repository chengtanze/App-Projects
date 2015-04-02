//
//  PKCell.h
//  Smartbox
//
//  Created by Mesada on 15/1/4.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *IconView;
@property (strong, nonatomic) IBOutlet UILabel *nameView;
@property (strong, nonatomic) IBOutlet UILabel *carNameView;
@property (strong, nonatomic) IBOutlet UILabel *scoreView;
@property (strong, nonatomic) IBOutlet UILabel *mileageView;
@property (strong, nonatomic) IBOutlet UIButton *rankingView;

@end
