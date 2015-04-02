//
//  MessagesController.h
//  Smartbox
//
//  Created by Mesada on 14/12/27.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
