//
//  abnormalType.h
//  Smartbox
//
//  Created by Mesada on 15/1/22.
//  Copyright (c) 2015年 mesada. All rights reserved.
//

#ifndef Smartbox_abnormalType_h
#define Smartbox_abnormalType_h
typedef NS_ENUM(NSInteger, abnormalType)
{
    overspeed_travel =0,//超速
    ACC_travel,//加速
    brakes_travel, //急刹车
    sharpturn_travel, //急转弯
    idle_travel,//长怠速
    collision_travel,//碰撞
    fatigue_travel,//疲劳
};

#endif
