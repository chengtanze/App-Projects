//
//  medalViewController.h
//  Smartbox
//
//  Created by Mesada on 15/1/9.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myCircularView.h"
@interface medalViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet myCircularView *medaldateView;

@end
