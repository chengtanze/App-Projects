//
//  ServiceViewController.m
//  Smartbox
//
//  Created by Mesada on 15/3/25.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

// bobo
// 服务开通情况显示

#import "ServiceViewController.h"
#import "InjuredRescueController.h"
@interface ServiceViewController ()

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeViewFromStatueCode];
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

-(void)changeViewFromStatueCode
{
    if ([_statueCode isEqualToString:@"i2001"]) {//不可用
        _serviceStatusText.text = @"你的人伤救援服务已关闭\n详情请登录ics.car.com.cn\n或致电400-8851-189";
        _serviceStatusText.hidden = FALSE;
        _BkImage.hidden = FALSE;
        _experienceBtn.hidden = TRUE;
    }
    else  if ([_statueCode isEqualToString:@"i3001"]) {//未购买
         _serviceStatusText.text = @"你的人伤救援服务未开通\n详情请登录ics.car.com.cn\n或致电400-8851-189";
        _serviceStatusText.hidden = FALSE;
        _BkImage.hidden = FALSE;
        _experienceBtn.hidden = TRUE;
    }
    else if ([_statueCode isEqualToString:@"i3002"]) {//已过期
         _serviceStatusText.text = @"你的人伤救援服务已过期\n详情请登录ics.car.com.cn\n或致电400-8851-189";
        _serviceStatusText.hidden = FALSE;
        _BkImage.hidden = FALSE;
        _experienceBtn.hidden = TRUE;
    }
    else if([_statueCode isEqualToString:@"i3003"]) {//正常使用
        _serviceStatusText.hidden = TRUE;
        _BkImage.hidden = TRUE;
        _experienceBtn.hidden = FALSE;

    }
}

- (IBAction)goExperience:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController.topViewController performSegueWithIdentifier:@"InjuredSegue" sender:nil];
//    NSLog(@"%@",self.navigationController.viewControllers);
    //
    UIStoryboard* mainStroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InjuredRescueController* Injured = [mainStroyboard instantiateViewControllerWithIdentifier:@"InjuredRescueController"];
    Injured.serviceId = _serviceId;
    
    NSMutableArray * array =[[ NSMutableArray alloc]initWithArray: self .navigationController.viewControllers];
    //删除最后一个，也就是自己
    [array removeObjectAtIndex:array.count-1];
    
    //添加要跳转的controller
    [array addObject:Injured];
    [self.navigationController setViewControllers:array animated: YES ];
    
    
}

@end
