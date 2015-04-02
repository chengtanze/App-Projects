//
//  QuickMarkViewController.m
//  Smartbox
//
//  Created by Mesada on 14/11/28.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "QuickMarkViewController.h"

@interface QuickMarkViewController (){
    CGRect previewRect;
}

@end

@implementation QuickMarkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    upOrdown = NO;
    num =0;


    previewRect =  CGRectMake(_bgView.frame.origin.x+5, _bgView.frame.origin.y+5, _bgView.frame.size.width-10, _bgView.frame.size.height-10);
        NSLog(@"rect = [%f,%f,%f,%f]", _bgView.frame.origin.x, _bgView.frame.origin.y, _bgView.frame.size.width, _bgView.frame.size.height);
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(previewRect.origin.x,previewRect.origin.y, previewRect.size.width,2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    

    [self setupCamera];
    
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(previewRect.origin.x,previewRect.origin.y+2*num, previewRect.size.width,2);//
        if (2*num >= previewRect.size.height) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(previewRect.origin.x,previewRect.origin.y+2*num, previewRect.size.width,2);
        //CGRectMake(50, 110+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
}

- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = previewRect;//CGRectMake(20,110,280,280);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [timer invalidate];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAVCaptureQuickMark:)]) {
        [self.delegate didAVCaptureQuickMark:stringValue];
    }
    
    [self.navigationController popViewControllerAnimated:YES ];
         NSLog(@"%@",stringValue);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
    [_session stopRunning];
    _preview = nil;
    self.session = nil;
    _output = nil;
    _input = nil;
    _device = nil;

    NSLog(@"QuickMarkViewController dealloc");
}

@end
