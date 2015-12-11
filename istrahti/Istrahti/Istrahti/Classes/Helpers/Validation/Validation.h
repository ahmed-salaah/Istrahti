//
//  Validation.h
//  KaizenCare
//
//  Created by Askar on 11/26/13.
//  Copyright (c) 2013 Askar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validation : NSObject

+ (BOOL) validUsername:(NSString *)nameText;
+ (BOOL) validEmail:(NSString*) emailString;
+ (BOOL) validName:(NSString *)nameText;
+ (BOOL) validPhone:(NSString *)phoneText;
+ (BOOL) validPassword:(NSString *)passTxt;
+ (BOOL) validCountry:(NSString *)countryTxt;

+ (BOOL) validFromDate:(NSString *)fromDate;
+ (BOOL) validToDate:(NSString *)toDate;
+ (BOOL) validReservationType:(NSString *)type;
+ (BOOL) validTime:(NSString *)time;

@end