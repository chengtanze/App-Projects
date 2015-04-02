//
//  PublicFunction.m
//  houseManage
//
//  Created by zhu xian on 12-3-3.
//  Copyright 2012 z. All rights reserved.
//

#import "PublicFunction.h"
#import "Reachability.h"
#import <sys/utsname.h>
//#import <ShareSDK/ShareSDK.h>
//#import "URLCache.h"
//#import "URLCacheManager.h"
#import "AppDelegate.h"

@implementation UINavigationBar(CustomImage)

-(void)drawRect:(CGRect)rect{
	UIImage	*image = [UIImage imageNamed:@"标题栏.png"];
	self.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"标题栏.png"]];//[UIColor colorWithRed:12.0f/255.0f green:23.0f/255.0f blue:51.0f/255.0f alpha:0.5];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end
@implementation PublicFunction

+(NSString *)getCurYear
{
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy"];
	NSDate *now = [[NSDate alloc] init];
	NSString *theDate = [dateFormat stringFromDate:now];
	NSString *ret=[NSString stringWithFormat:@"%@",theDate];
//	[dateFormat release];
//	[now release];
    //NSLog(@"%@",ret);
	return ret;
}

+(NSString *)getCurMonth
{
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"MM"];
	NSDate *now = [[NSDate alloc] init];
	NSString *theDate = [dateFormat stringFromDate:now];
	NSString *ret=[NSString stringWithFormat:@"%@",theDate];
//	[dateFormat release];
//	[now release];
    //NSLog(@"%@",ret);
	return ret;
}

+(NSString *)getCurDay
{
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd"];
	NSDate *now = [[NSDate alloc] init];
	NSString *theDate = [dateFormat stringFromDate:now];
	NSString *ret=[NSString stringWithFormat:@"%@",theDate];
//	[dateFormat release];
//	[now release];
    //NSLog(@"%@",ret);
	return ret;
}


+(NSString *)getCurDateTime
{
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd"];
	
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"HH:mm:ss"];
	
	NSDate *now = [[NSDate alloc] init];
	
	NSString *theDate = [dateFormat stringFromDate:now];
	NSString *theTime = [timeFormat stringFromDate:now];
	
	NSString *ret=[NSString stringWithFormat:@"%@ %@",theDate,theTime];
	
//	[dateFormat release];
//	[timeFormat release];
//	[now release];
    //NSLog(@"%@",ret);
	return ret;
}

+(NSString *)getCurDateTimeNOSeconds
{
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd"];
	
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"HH:mm"];
	
	NSDate *now = [[NSDate alloc] init];
	
	NSString *theDate = [dateFormat stringFromDate:now];
	NSString *theTime = [timeFormat stringFromDate:now];
	
	NSString *ret=[NSString stringWithFormat:@"%@ %@",theDate,theTime];
	
//	[dateFormat release];
//	[timeFormat release];
//	[now release];
    //NSLog(@"%@",ret);
	return ret;
}

//boob
+ (NSInteger)weekdayStringFromDate:(NSDate*)inputDate {
    
//    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return theComponents.weekday;
    
}

- (NSUInteger)daysAgo {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components day];
}

//检测email格式
+(BOOL) isIdCarNumber:(NSString *)checkString
{
	NSString *emailRegex = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
	NSString *emailRegex2 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];  
    NSPredicate *emailTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex2];  
    
if ([emailTest evaluateWithObject:checkString]||[emailTest2 evaluateWithObject:checkString]) {
	return TRUE;
}
	else {
		return FALSE ;
	}
	
}
+(UIImage *)getImage:(NSString *)imageName
{
	if ([imageName rangeOfString:@"."].location != NSNotFound) {
		NSArray *names = [imageName componentsSeparatedByString: @"."];
		return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[names objectAtIndex:0] ofType:[names objectAtIndex:1]]];
	}
	else {
		return nil;
	}

	
}
+(UIColor *)getColorByImage:(NSString *)imageName
{
	if ([imageName rangeOfString:@"."].location != NSNotFound) {
		NSArray *names = [imageName componentsSeparatedByString: @"."];
	return [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[names objectAtIndex:0] ofType:[names objectAtIndex:1]]]];
	}
	else {
		return nil;
	}
}
//bobo
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(BOOL) isFloat:(NSString *)checkString
{
	NSString *Regex = @"^(-?\\d+)(\\.\\d+)?$";
    NSPredicate *Test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];  
    return [Test evaluateWithObject:checkString];
}
+(BOOL) isNumber:(NSString *)checkString
{
	NSString *Regex = @"^[0-9]*[1-9][0-9]*$";  
    NSPredicate *Test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];  
    return [Test evaluateWithObject:checkString];
}

+(BOOL) isCarNumber:(NSString *)checkString
{
	NSString *Regex = @"^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}";
    NSPredicate *Test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [Test evaluateWithObject:checkString];
}

//检测数字字母汉字
+(BOOL) isAlphaNumeric:(NSString *)checkString
{
	
	NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
	return [[checkString stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
	
}

//检查输入昵称长度 汉字占6个，英文占12个
+ (BOOL)isNick:(NSString*)checkString
{
    NSInteger zn = 0;
    NSInteger en = 0;
    for (int i = 0; i<checkString.length; i++) {
        unichar c = [checkString characterAtIndex:i];
        if (c >=0x4E00 && c < 0x9FFF) {
            //汉字
            zn += 1;
        } else {
            //英文
            en += 1;
        }
    }
    if (zn > 6 || en >12 ) {
        return FALSE;
    }
    if (en > 12 - zn*2) { //中英文混合情况下 
        return FALSE;
    }
    return TRUE;
}
//检测email格式
+(BOOL) isEmail:(NSString *)checkString
{
	NSString *emailRegex = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";  
	
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];  
    return [emailTest evaluateWithObject:checkString];
}
//检测数字字母下划线
+(BOOL)isValidInput:(NSString *)checkString
{
	
	NSString *stricterFilterString = @"^[A-Z0-9a-z._\u4e00-\u9fa5]+$";
	
	NSString *emailRegex = stricterFilterString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	return [emailTest evaluateWithObject:checkString];
}

+ (BOOL)isPhoneNum:(NSString*)checkString
{
    //  ^((/+86)|(86))?(1)/d{10}$
//    NSString *stricterFilterString = @"^1[0-9]{10}$";
	NSString *stricterFilterString = @"^[1][3-8]+\\d{9}$";
	NSString *emailRegex = stricterFilterString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:checkString];
}

+(void)showMessage:(NSString *)mes
{
	
    UIAlertView *myAlertView=[[UIAlertView alloc] initWithTitle:mes message:nil 
                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
    [myAlertView show];
 //   [myAlertView release];
	
}

//+(void)addTextField:(UITextField *)textField
//{
////	textField.delegate = self;
//	textField.textAlignment = NSTextAlignmentLeft;
//	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//	
//	textField.font=[UIFont fontWithName:@"Arial" size:12.0];
//	textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//	textField.tag=3;
//	textField.layer.cornerRadius=2.0f;
//    textField.layer.masksToBounds=YES;
//    textField.layer.borderColor=[[UIColor grayColor] CGColor];
//    textField.layer.borderWidth= 1.0f;
//	
//	UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 15.0f,30.0f)];
//	UIButton *btnLeftImg = [UIButton buttonWithType:UIButtonTypeCustom];
//	[btnLeftImg setBackgroundImage:[UIImage imageNamed:@"leftPoint.png"] forState:UIControlStateNormal];
//	btnLeftImg.frame = CGRectMake(5.0f, 10.0f, 9.0f,9.0f);
//	[leftView addSubview:btnLeftImg];
//	textField.leftView=leftView;
//	textField.leftViewMode = UITextFieldViewModeAlways;
//	[leftView release];
//	
//	
//}
+(NSString *)replaceString:(NSString *)str
{
	return [str stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}
+(void)addLeftView:(UITextField *)textField
{
	UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 15.0f,30.0f)];
	UIButton *btnLeftImg = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnLeftImg setBackgroundImage:[UIImage imageNamed:@"leftPoint.png"] forState:UIControlStateNormal];
	btnLeftImg.frame = CGRectMake(5.0f, 10.0f, 9.0f,9.0f);
	[leftView addSubview:btnLeftImg];
	textField.leftView=leftView;
	textField.leftViewMode = UITextFieldViewModeAlways;
	//[leftView release];
}

+(BOOL)writeToTextFile:(NSString *)str  FileName:(NSString *)fileName
{
	
	NSError *error = nil;
	//NSString *filePath = [NSHomeDirectory()  stringByAppendingPathComponent:@"Documents/googleResponse.txt"];
	NSString *filePath = [NSHomeDirectory()  stringByAppendingPathComponent:@"Documents/"];
	
	filePath=[filePath stringByAppendingPathComponent:fileName];
	return [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
	
}
+(NSString *)readFromTextFile:(NSString *)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
	if ([paths count]>0) {
		NSString *documentsDirectory = [paths objectAtIndex:0];    
		NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName]; 
		NSData *myData = [[NSData alloc] initWithContentsOfFile:appFile];
		
		NSString *myString = [[NSString alloc] 
							  initWithBytes:[myData bytes] 
							  length:[myData length] 
							  encoding:NSUTF8StringEncoding];
		myData=nil;
//		[myData release];
		
		return myString;
	}
	else {
		return nil;
	}
}

+(BOOL)isConnect
{
	Reachability *r=[Reachability reachabilityWithHostName:@"www.baidu.com"];
	BOOL ret=TRUE;
	switch ([r currentReachabilityStatus])
	{
		case NotReachable:
			return FALSE;
			break;
		default:
			break;
	}
	
	return ret;
}

//+ (UIView *)signView:(NSString *)text widthSize:(CGSize)theSize
//{
//    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
//	returnView.backgroundColor = [UIColor clearColor];
//	
//	UIImage *signImage = [UIImage imageNamed:@"friend_tableView_sign_background.png"];//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"signature_bg" ofType:@"png"]];
//	UIImageView *signImageView = [[UIImageView alloc] initWithImage:[signImage stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
//	
//	UIFont *font ;
//	
//	CGSize size ;
//    font = [UIFont systemFontOfSize:13];//16
//    CGFloat width = screenWidth - theSize.width -40;
//    size = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 32.0f) lineBreakMode:  NSLineBreakByWordWrapping];
//
//	UILabel *signText = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0.0f, size.width+10, size.height+10)];
//	signText.backgroundColor = [UIColor clearColor];
//	signText.font = font;
//	signText.textColor = [UIColor grayColor];
//    
//    signText.font = font;
//    signText.numberOfLines = 2;
//    signText.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
//
//    
//	signText.text = text;
//	
//	if(text!=nil)
//		signImageView.frame = CGRectMake(0.0f, 0.0f, size.width+20, size.height+10);
//	else
//		signImageView.frame = CGRectMake(0.0f, 0.0f, 0, 0);
//	
//    returnView.frame = CGRectMake(screenWidth-(size.width+10)-40, (64.0f-(size.height+10))/2, size.width, size.height+10.0f);
//    
//    [returnView addSubview:signImageView];
//	[signImageView release];
//	[returnView addSubview:signText];
//	[signText release];
//	
//	return [returnView autorelease];
//}

//+ (UIView *)signView:(NSString *)text widthBackground:(BOOL) hasBG{
//	// build single chat bubble cell with given text
//	UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
//	returnView.backgroundColor = [UIColor clearColor];
//	
//	UIImage *signImage = [UIImage imageNamed:@"friend_tableView_sign_background.png"];//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"signature_bg" ofType:@"png"]];
//	UIImageView *signImageView = [[UIImageView alloc] initWithImage:[signImage stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
//	
//	UIFont *font ;
//	
//	CGSize size ;
//	if(hasBG){
//		font = [UIFont systemFontOfSize:13];//16
//		size = [text sizeWithFont:font constrainedToSize:CGSizeMake(150.0f, 32.0f) lineBreakMode:  NSLineBreakByWordWrapping];
//	}
//	else {
//		font = [UIFont systemFontOfSize:16];//16
//		size = [text sizeWithFont:font constrainedToSize:CGSizeMake(200.0f, 1000.0f) lineBreakMode:  NSLineBreakByWordWrapping];
//	}
//	
//	
//	UILabel *signText = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0.0f, size.width+10, size.height+10)];
//	signText.backgroundColor = [UIColor clearColor];
//	signText.font = font;
//	signText.textColor = [UIColor grayColor];
//	
//	if(hasBG)
//	{
//		signText.font = font;
//		signText.numberOfLines = 2;
//		signText.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
//	}
//	else {
////		signText.font= [UIFont systemFontOfSize:16];
//		signText.numberOfLines = 0;
//		signText.lineBreakMode = NSLineBreakByWordWrapping;
//
//	}
//
//	signText.text = text;
//	
//	if(text!=nil)
//		signImageView.frame = CGRectMake(0.0f, 0.0f, size.width+25, size.height+10);
//	else 
//		signImageView.frame = CGRectMake(0.0f, 0.0f, 0, 0);
//	
//	if(hasBG)
//		returnView.frame = CGRectMake(screenWidth-(size.width+10)-40, (64.0f-(size.height+10))/2, size.width+10, size.height+10.0f);
//	else
//		returnView.frame = CGRectMake(screenWidth-(size.width+10)-20, 10.0f, 200.0f, size.height+10.0f);
//	
//	if(hasBG)
//		[returnView addSubview:signImageView];
//	[signImageView release];
//	[returnView addSubview:signText];
//	[signText release];
//	
//	return [returnView autorelease];
//}

#pragma mark Table view methods
//- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf {
//	// build single chat bubble cell with given text
//	UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
//	returnView.backgroundColor = [UIColor clearColor];
//	
//	UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf?@"bubbleSelf":@"bubble" ofType:@"png"]];
//	UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
//	
//	UIFont *font = [UIFont systemFontOfSize:13];
//	CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(150.0f, 1000.0f) lineBreakMode:  NSLineBreakByWordWrapping];
//	
//	UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(21.0f, 14.0f, size.width+10, size.height+10)];
//	bubbleText.backgroundColor = [UIColor clearColor];
//	bubbleText.font = font;
//	bubbleText.numberOfLines = 0;
//	bubbleText.lineBreakMode = NSLineBreakByWordWrapping;
//	bubbleText.text = text;
//	
//	bubbleImageView.frame = CGRectMake(0.0f, 0.0f, 200.0f, size.height+30.0f);
//	if(fromSelf)
//		returnView.frame = CGRectMake(120.0f, 0.0f, 200.0f, size.height+50.0f);
//	else
//		returnView.frame = CGRectMake(0.0f, 0.0f, 200.0f, size.height+50.0f);
//	
//	[returnView addSubview:bubbleImageView];
//	[bubbleImageView release];
//	[returnView addSubview:bubbleText];
//	[bubbleText release];
//	
//	return [returnView autorelease];
//}
//wanglang change 添加设备判断方法。
+(NSString *)deviceString
{
    struct utsname  systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

//分享软件
//+ (void)shareApp
//{
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon" ofType:@"png"];
//    id<ISSContent> publishContent = [ShareSDK content:CONTENTSTRING
//                                       defaultContent:@""
//                                                image:[ShareSDK imageWithPath:imagePath]
//                                                title:@"车友互联"
//                                                  url:@"https://itunes.apple.com/us/app/id469377113"
//                                          description:@""
//                                            mediaType:SSPublishContentMediaTypeNews];
//    
//    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeTencentWeibo, ShareTypeWeixiSession , ShareTypeWeixiTimeline, nil];
//    [ShareSDK showShareActionSheet:nil
//                         shareList:shareList
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions:[ShareSDK defaultShareOptionsWithTitle:@"内容分享"
//                                                          oneKeyShareList:shareList
//                                                           qqButtonHidden:YES
//                                                    wxSessionButtonHidden:NO
//                                                   wxTimelineButtonHidden:NO
//                                                     showKeyboardOnAppear:NO
//                                                        shareViewDelegate:nil
//                                                      friendsViewDelegate:nil
//                                                    picViewerViewDelegate:nil]
//                            result:^(ShareType type, SSPublishContentState state,id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end){
//                                if(state == SSPublishContentStateSuccess){
//                                    NSLog(@"分享成功");
//                                } else if (state == SSPublishContentStateFail) {
//                                    NSLog(@"分享失败，错误代码:[%d],错误描述:[%@]",[error errorCode],[error errorDescription]);
//                                }
//                                
//                            }];
//}

//+ (void)shareApp
//{
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"newAppIcon@2x" ofType:@"png"];
//    // 构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:CONTENTSTRING
//                                       defaultContent:@""
//                                                image:[ShareSDK imageWithPath:imagePath]
//                                                title:@"庞大车管家"
//                                                  url:@"https://itunes.apple.com/us/app/id828824551"
//                                          description:nil
//                                            mediaType:SSPublishContentMediaTypeNews];
//    
//    ///////////////////////
//    // 以下信息为特定平台需要定义分享内容，如果不需要可省略下面的添加方法
//    
//    
//    // 定制微信好友信息
//    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
//                                         content:INHERIT_VALUE
//                                           title:@"庞大车管家"
//                                             url:@"https://itunes.apple.com/us/app/id828824551"
//                                           image:INHERIT_VALUE
//                                    musicFileUrl:nil
//                                         extInfo:nil
//                                        fileData:nil
//                                    emoticonData:nil];
//    
//    // 定制微信朋友圈信息
//    [publishContent addWeixinTimelineUnitWithType:INHERIT_VALUE
//                                          content:INHERIT_VALUE
//                                            title:@"庞大车管家"
//                                              url:@"https://itunes.apple.com/us/app/id828824551"
//                                            image:INHERIT_VALUE
//                                     musicFileUrl:nil
//                                          extInfo:nil
//                                         fileData:nil
//                                     emoticonData:nil];
//    
//    
//    // 创建弹出菜单容器
//    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionUp];
//    
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//                                                         allowCallback:NO
//                                                         authViewStyle:SSAuthViewStyleModal
//                                                          viewDelegate:nil
//                                               authManagerViewDelegate:appDelegate.viewDelegate];
//    // 在授权页面中添加关注官方微博
//    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
//                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
//                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
//                                    nil]];
//    
//    id<ISSShareOptions> shareOptions = [ShareSDK simpleShareOptionsWithTitle:@"内容分享" shareViewDelegate:appDelegate.viewDelegate];
//    
//    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeTencentWeibo, ShareTypeWeixiSession , ShareTypeWeixiTimeline, nil];
//    // 弹出分享菜单
//    [ShareSDK showShareActionSheet:container
//                         shareList:shareList
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:authOptions
//                      shareOptions:shareOptions
//                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                if (state == SSPublishContentStateSuccess)
//                                {
//                                    NSLog(@"分享成功");
//                                }
//                                else if (state == SSPublishContentStateFail)
//                                {
//                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
//                                }
//                            }];
//}

//+ (void)shareAppType:(ShareAppType)type andImage:(UIImage *)imge
//{
//    NSString *contentStr = @"";
//    switch (type) {
//        case ShareAppTypeApp:
//            contentStr = CONTENTSTRING;
//            break;
//        case ShareAppTypeHealthExcellent:
//            contentStr = CONTENTSTRINGHEALTHEXCELLENT;
//            break;
//        case ShareAppTypeHealthGood:
//            contentStr = CONTENTSTRINGHEALTHGOOD;
//            break;
//        case ShareAppTypeHealthBad:
//            contentStr = CONTENTSTRINGHEALTHBAD;
//            break;
//        case ShareAppTypeDriveDayLogHight:
//            contentStr = CONTENTSTRINGDRIVEHIGHT;
//            break;
//        case ShareAppTypeDriveDayLogMiddle:
//            contentStr = CONTENTSTRINGDRIVEMIDDLE;
//            break;
//        case ShareAppTypeDriveDayLogLow:
//            contentStr = CONTENTSTRINGDRIVELOW;
//            break;
//        default:
//            break;
//    }
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
////    NSString *imagePath = nil;
//    id<ISSCAttachment> imageObj = nil;
//    if (imge==nil) {
//        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon" ofType:@"png"];
//        imageObj = [ShareSDK imageWithPath:imagePath];
//    }else{
//        imageObj = [ShareSDK pngImageWithImage:imge];
//    }
////    NSString *
//    // 构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:contentStr
//                                       defaultContent:@""
//                                                image:imageObj
//                                                title:@"庞大车管家"
//                                                  url:@"https://itunes.apple.com/us/app/id469377113"
//                                          description:nil
//                                            mediaType:SSPublishContentMediaTypeNews];
//    
//    ///////////////////////
//    // 以下信息为特定平台需要定义分享内容，如果不需要可省略下面的添加方法
//    
//    
//    // 定制微信好友信息
//    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
//                                         content:INHERIT_VALUE
//                                           title:@"庞大车管家"
//                                             url:@"https://itunes.apple.com/us/app/id469377113"
//                                           image:INHERIT_VALUE
//                                    musicFileUrl:nil
//                                         extInfo:nil
//                                        fileData:nil
//                                    emoticonData:nil];
//    
//    // 定制微信朋友圈信息
//    [publishContent addWeixinTimelineUnitWithType:INHERIT_VALUE
//                                          content:INHERIT_VALUE
//                                            title:@"庞大车管家"
//                                              url:@"https://itunes.apple.com/us/app/id469377113"
//                                            image:INHERIT_VALUE
//                                     musicFileUrl:nil
//                                          extInfo:nil
//                                         fileData:nil
//                                     emoticonData:nil];
//    
//    
//    // 创建弹出菜单容器
//    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionUp];
//    
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//                                                         allowCallback:NO
//                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
//                                                          viewDelegate:nil
//                                               authManagerViewDelegate:appDelegate.viewDelegate];
//    // 在授权页面中添加关注官方微博
//    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
//                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
//                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
//                                    nil]];
//    
//    id<ISSShareOptions> shareOptions = [ShareSDK simpleShareOptionsWithTitle:@"内容分享" shareViewDelegate:appDelegate.viewDelegate];
//    
//    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeTencentWeibo, ShareTypeWeixiSession , ShareTypeWeixiTimeline, nil];
//    // 弹出分享菜单
//    [ShareSDK showShareActionSheet:container
//                         shareList:shareList
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:authOptions
//                      shareOptions:shareOptions
//                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                if (state == SSPublishContentStateSuccess)
//                                {
//                                    NSLog(@"分享成功");
//                                }
//                                else if (state == SSPublishContentStateFail)
//                                {
//                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
//                                }
//                            }];
//}

//获取头像
//+ (void)getAsynacHeadImage:(NSString*)figureurl andObject:(id)obj
//{
//	if(figureurl != nil) {
//		NSString* strFigureUrl = figureurl;
//		if ([URLCache dataWithURL:strFigureUrl]) {
//            if ([obj isKindOfClass:[UIButton class]]) {
//                [obj setImage:[UIImage imageWithData:[URLCache dataWithURL:strFigureUrl]] forState:UIControlStateNormal];
//            } else if ([obj isKindOfClass:[UIImageView class]]) {
//                UIImageView *imageObj = (UIImageView*)(obj);
//                [imageObj setImage:[UIImage imageWithData:[URLCache dataWithURL:strFigureUrl]]];
//            }
//			return;
//		}
//		dispatch_queue_t downloadQueue = dispatch_queue_create("Figure_Downloader0", NULL);
//		dispatch_async(downloadQueue, ^{
//			NSURL* figureURL = [NSURL URLWithString:strFigureUrl];
//			NSData *figureData = [NSData dataWithContentsOfURL:figureURL];
//			dispatch_async(dispatch_get_main_queue(), ^{
//				if (figureData.length > 0) {
//					if ([obj isKindOfClass:[UIButton class]]) {
//                        NSLog(@"uibutton update Image ");
//                        [obj setImage:[UIImage imageWithData:figureData] forState:UIControlStateNormal];
//                    } else if ([obj isKindOfClass:[UIImageView class]]) {
//                        UIImageView *imageObj = (UIImageView*)(obj);
//                        [imageObj setImage:[UIImage imageWithData:figureData]];
//                    }
//					[URLCacheManager cacheData:figureData withURL:figureurl];
//				}
//			});
//		});
//		dispatch_release(downloadQueue);
//	} else {
//		NSLog(@"figureurl == nil");
//	}
//}
+ (NSString *)getDocumentsPath:(fileType)theFileType
{
    NSString *tempPath = nil;
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentsPath objectAtIndex:0];
    switch (theFileType) {
        case fileTypeImages:
            tempPath = @"/images";
            break;
        case fileTypeRecords:
            tempPath = @"/records";
            break;
        case fileTypeOthers:
            tempPath = @"";
            break;
        default:
            tempPath = @"";
            break;
    }
    NSString *filesPath = [documentsDir stringByAppendingFormat:@"%@", tempPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filesPath]) {
        NSError *error = nil;
        if (![fileManager createDirectoryAtPath:filesPath withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Create directory Error:%@, error Code = %d", [error userInfo], [error code]);
        }
    }
    return filesPath;
}
// add by wusj
/*
 * 获取指定宽度字符的高度
 *
 */
+ (float)heightForString:(NSString *)string withFontSize:(float)fontSize andWidth:(float)width {
    if (string == nil || string.length == 0 || [string isEqualToString:@" "]) {
//        string = @"11";
        return 0.0;
    }
    CGSize sizeToFit = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    return sizeToFit.height;
}

+ (UIColor *)colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor redColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor redColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//#pragma mark -
//#pragma mark - Get really Gps
//+ (CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
//{
//    int TenLat=0;
//    int TenLog=0;
//    TenLat = (int)(yGps.latitude*10);
//    TenLog = (int)(yGps.longitude*10);
//    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
//    //    NSLog(sql);
//    CSqlite *m_sqlite1 = [[[CSqlite alloc]init]autorelease];
//    [m_sqlite1 openSqlite];
//    sqlite3_stmt* stmtL = [m_sqlite1 NSRunSql:sql];
//    int offLat=0;
//    int offLog=0;
//    while (sqlite3_step(stmtL)==SQLITE_ROW)
//    {
//        offLat = sqlite3_column_int(stmtL, 0);
//        offLog = sqlite3_column_int(stmtL, 1);
//        
//    }
//    
//    yGps.latitude = yGps.latitude+offLat*0.0001;
//    yGps.longitude = yGps.longitude + offLog*0.0001;
//    //    [m_sqlite1 closeSqlite];
//    return yGps;
//}

+ (void)deleteFileWithFilePath:(NSString*)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager removeItemAtPath:filePath error:(NSError **)&error];
}

+ (BOOL)isLuanchedIntrudactionWithName:(NSString*)pluginName
{
    BOOL isLuanch = FALSE;
    NSUserDefaults* theUserDefaults = [NSUserDefaults standardUserDefaults];
    if (pluginName.length>0) {
        isLuanch = [theUserDefaults boolForKey:pluginName];
    }
    return isLuanch;
}

+ (void)setLuanchValueWithPluginName:(NSString*)pluginName andValue:(BOOL)value
{
    NSUserDefaults *theUserDefaults = [NSUserDefaults standardUserDefaults];
    if (pluginName.length>0) {
        [theUserDefaults setBool:value forKey:pluginName];
    }
}

/**
 *  日期格式转换成字符串
 *
 *  @param date 要转换的日期
 *
 *  @param date 转换的格式 如：yyyy-MM-dd / yyyy-MM-dd HH:mm:ss  .......
 *
 *  @return 转换后的字符串
 */
+ (NSString*)getDateTimeWithDate:(NSDate*)date andFormatterString:(NSString*)formatterStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

/*
 * 为tableview顶上的cell添加分隔线和背景（正常、高亮）
 */
+ (void)setTopBackForCell:(UITableViewCell *)cell withHeight:(float)hei {
    if (hei <= 0) {
        hei = 44;
    }
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    backView.image = [UIImage imageNamed:@"cell_top_normal"];
    cell.backgroundView = backView;
    
    UIImageView *selectedBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    selectedBackView.image = [UIImage imageNamed:@"cell_top_highlight"];
    cell.selectedBackgroundView = selectedBackView;
    
    UIImageView *seprator = [[UIImageView alloc] initWithFrame:CGRectMake(0, hei - 0.5, cell.frame.size.width, 0.5)];
    seprator.image = [UIImage imageNamed:@"cell_seprator"];
    [cell addSubview:seprator];
}

/*
 * 为中间的cell添加分隔线和背景（正常、高亮）
 */
+ (void)setCenterBackForCell:(UITableViewCell *)cell withHeight:(float)hei {
    if (hei <= 0) {
        hei = 44;
    }
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    backView.image = [UIImage imageNamed:@"cell_center_normal"];
    cell.backgroundView = backView;
    
    UIImageView *selectedBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    selectedBackView.image = [UIImage imageNamed:@"cell_center_highlight"];
    cell.selectedBackgroundView = selectedBackView;
    
    UIImageView *seprator = [[UIImageView alloc] initWithFrame:CGRectMake(0, hei - 0.5, cell.frame.size.width, 0.5)];
    seprator.image = [UIImage imageNamed:@"cell_seprator"];
    [cell addSubview:seprator];
}

/*
 * 为tableview底部的cell添加背景，最后一个cell 不要分隔线
 */
+ (void)setBottomBackForCell:(UITableViewCell *)cell {
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    backView.image = [UIImage imageNamed:@"cell_bottom_normal"];
    cell.backgroundView = backView;
    
    UIImageView *selectedBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    selectedBackView.image = [UIImage imageNamed:@"cell_bottom_highlight"];
    cell.selectedBackgroundView = selectedBackView;
}

/*
 * 为单行tableview的cell添加背景，最后一个cell 不要分隔线
 */
+ (void)setSingleBackForCell:(UITableViewCell *)cell {
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    backView.image = [UIImage imageNamed:@"cell_single_normal"];
    cell.backgroundView = backView;
    
    UIImageView *selectedBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    selectedBackView.image = [UIImage imageNamed:@"cell_single_highlight"];
    cell.selectedBackgroundView = selectedBackView;
}

// 判断字符串是否包含汉字
+ (BOOL) containsChinese:(NSString *)str {
    for(int i = 0; i < [str length]; i++) {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            return TRUE;
    }
    
    return FALSE;
}

// 判断车牌号
+ (BOOL)carNumberIsTrue:(NSString *)carNumber {
    if (carNumber.length != 7) {
        return NO;
    }
    
    for(int i = 0; i < [carNumber length]; i++) {
        int a = [carNumber characterAtIndex:i];
        // 第一位为汉字
        if (i == 0) {
            if( a < 0x4e00 || a > 0x9fff) {
                return NO;
            }
        } else if (i == 1) {
         // 第二位必须为字母
            if (!((a >= 65 && a <= 90) || (a >= 97 && a <= 122))) {
                return NO;
            }
        }
    }
    
    return YES;
}

@end
