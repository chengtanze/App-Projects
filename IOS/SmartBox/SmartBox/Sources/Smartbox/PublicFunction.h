//
//  PublicFunction.h
//  houseManage
//
//  Created by zhu xian on 12-3-3.
//  Copyright 2012 z. All rights reserved.
//
#import "PCHHeader.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
//#import "CSqlite.h"

typedef enum{
    fileTypeImages,
    fileTypeRecords,
    fileTypeOthers
}fileType;
typedef enum {
    ShareAppTypeApp,
    ShareAppTypeHealthExcellent,
    ShareAppTypeHealthGood,
    ShareAppTypeHealthBad,
    ShareAppTypeDriveDayLogHight,
    ShareAppTypeDriveDayLogMiddle,
    ShareAppTypeDriveDayLogLow
}ShareAppType;
@interface PublicFunction : NSObject {

}
+ (BOOL)isConnect;
+ (NSString *)getCurYear;
+ (NSString *)getCurMonth;
+ (NSString *)getCurDay;
+ (UIColor *)getColorByImage:(NSString *)imageName;
+ (UIImage *)getImage:(NSString *)imageName;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
+ (NSString *)getCurDateTime;
+ (NSString *)getCurDateTimeNOSeconds;
+ (NSInteger)weekdayStringFromDate:(NSDate*)inputDate;
+ (BOOL)isAlphaNumeric:(NSString *)checkString;

+ (BOOL)isEmail:(NSString *)checkString;

+ (BOOL)isValidInput:(NSString *)checkString;

+ (BOOL)isIdCarNumber:(NSString *)checkString;
+ (BOOL)isFloat:(NSString *)checkString;
+ (BOOL)isNumber:(NSString *)checkString;
+(BOOL) isCarNumber:(NSString *)checkString;
+ (BOOL)isNick:(NSString*)checkString;
+ (void)showMessage:(NSString *)mes;
+ (NSString*)getDateTimeWithDate:(NSDate*)date andFormatterString:(NSString*)formatterStr;

+ (void)addTextField:(UITextField *)textField;
+ (NSString *)replaceString:(NSString *)str;

+ (BOOL)writeToTextFile:(NSString *)str  FileName:(NSString *)fileName;
+ (NSString *)readFromTextFile:(NSString *)fileName;
+ (UIView *)signView:(NSString *)text widthSize:(CGSize)theSize;
+ (UIView *)signView:(NSString *)text widthBackground:(BOOL) hasBG;
+ (NSString *)deviceString;
+ (BOOL)isPhoneNum:(NSString*)checkString;
+ (void)shareApp;
+ (void)shareAppType:(ShareAppType)type andImage:(UIImage *)imge;
+ (void)getAsynacHeadImage:(NSString*)figureurl andObject:(id)obj;
+ (CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps;
+ (void)deleteFileWithFilePath:(NSString*)filePath;
+ (BOOL)isLuanchedIntrudactionWithName:(NSString*)pluginName;
+ (void)setLuanchValueWithPluginName:(NSString*)pluginName andValue:(BOOL)value;

// add by wusj
+ (float)heightForString:(NSString *)string withFontSize:(float)fontSize andWidth:(float)width;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (BOOL) containsChinese:(NSString *)str;
// 判断 车牌号是否正确
+ (BOOL)carNumberIsTrue:(NSString *)carNumber;

+ (void)setBottomBackForCell:(UITableViewCell *)cell;
+ (void)setCenterBackForCell:(UITableViewCell *)cell withHeight:(float)hei;
+ (void)setTopBackForCell:(UITableViewCell *)cell withHeight:(float)hei;
+ (void)setSingleBackForCell:(UITableViewCell *)cell;

+ (NSString *)getDocumentsPath:(fileType)theFileType;



@end

