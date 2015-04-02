//
//  QuickMarkViewController.h
//  Smartbox
//
//  Created by Mesada on 14/11/28.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@protocol didAVCaptureQuickMarkdelegate<NSObject>
@optional
-(void)didAVCaptureQuickMark:(NSString*)code;
@end

@interface QuickMarkViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (weak,nonatomic)id<didAVCaptureQuickMarkdelegate> delegate;
@property (strong,nonatomic)
AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (strong, nonatomic) IBOutlet UIImageView *bgView;

@end
