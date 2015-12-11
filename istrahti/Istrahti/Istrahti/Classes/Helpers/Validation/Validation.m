//
//  Validation.m
//  KaizenCare
//
//  Created by Askar on 11/26/13.
//  Copyright (c) 2013 Askar. All rights reserved.
//

#import "Validation.h"
#import "PXAlertView.h"

//#import "NSDate-Utilities.h"

@implementation Validation

+ (BOOL) validUsername:(NSString *)nameText
{
    if (nameText.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:NSLocalizedString(@"nameReq", @"")
                            cancelTitle:NSLocalizedString(@"ok", @"")
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    //A-Za-z0-9\\sp{Arabic}
    NSString *nameRegix = @"[A-Za-z0-9@\\sp{Arabic}]+";
//    NSString *nameRegix = @"[a-zA-z]+([ '-][a-zA-Z]+)*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegix];
    BOOL valid = [nameTest evaluateWithObject:nameText];
    if (valid) {
        return YES ;
    }else{
        [PXAlertView showAlertWithTitle:nil
                                message:NSLocalizedString(@"validUsername", @"")
                            cancelTitle:NSLocalizedString(@"ok", @"")
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];        return NO;
    }
    
    return YES ;
    
}

/*Valid email*/
+ (BOOL) validEmail:(NSString*) emailString
{
    
    if (emailString.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل البريد الإلكتروني"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    NSString *regExPattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
    if (regExMatches == 0) {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل البريد الإلكتروني بطريقة صحيحة"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO;
    } else
        return YES;
}

/*Name Validation*/
+ (BOOL)validName:(NSString *)nameText
{
    if (nameText.length == 0) {
        [PXAlertView showAlertWithTitle:nil
                                message:NSLocalizedString(@"nameReq", @"")
                            cancelTitle:NSLocalizedString(@"ok", @"")
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [nameText stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        // Text was empty or only whitespace.
        [PXAlertView showAlertWithTitle:nil
                                message:NSLocalizedString(@"nameReq", @"")
                            cancelTitle:NSLocalizedString(@"ok", @"")
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;
}


+ (BOOL)validPhone:(NSString *)phoneText
{
    if (phoneText.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل رقم الهاتف"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }

    NSString *myRegex = @"[0-9]*";
    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", myRegex];
    NSString *string = phoneText;
    BOOL valid = [myTest evaluateWithObject:string];

    if (valid)
    {
        if (phoneText.length < 8) {
            [PXAlertView showAlertWithTitle:nil
                                    message:@"رقم الهاتف لا يجب أن يقل عن ٨ أرقام"
                                cancelTitle:@"تم"
                                 otherTitle:nil
                                 completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                     if (cancelled) {
                                         NSLog(@"Cancel (Blue) button pressed");
                                     } else {
                                         NSLog(@"Other (Red) button pressed");
                                     }
                                 }];
            return NO ;
        }
        return YES ;
    }else{
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل رقم الهاتف بطريقة صحيحة"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
}

+ (BOOL) validPassword:(NSString *)passTxt
{
    if (passTxt.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:NSLocalizedString(@"passReq", @"")
                            cancelTitle:NSLocalizedString(@"ok", @"")
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;
}

+ (BOOL) validCountry:(NSString *)countryTxt
{
    if (countryTxt.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أختر المدينة"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;
}


+ (BOOL) validFromDate:(NSString *)fromDate
{
    if (fromDate.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل التاريخ"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;
}

+ (BOOL) validToDate:(NSString *)toDate
{
    if (toDate.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل التاريخ"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;
}


+ (BOOL) validReservationType:(NSString *)type
{
    if (type.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل نوع الحجز"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;
}

+ (BOOL) validTime:(NSString *)time
{
    if (time.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل الفترة الزمنية"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;
}


+ (BOOL) validSection:(NSString *)section
{
    if (section.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أختر القسم الرئيسي"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;
}

+ (BOOL) validCategory:(NSString *)category
{
    if (category.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أختر القسم الفرعي"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;


}

+ (BOOL) validPrice:(NSString *)price
{
    if (price.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل السعر"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;
}

+ (BOOL) validadTitle:(NSString *)adTitle
{
    if (adTitle.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل اسم الإعلان"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;
}

+ (BOOL) validDetails:(NSString *)details
{
    if (details.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل تفاصيل الإعلان"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    return YES ;
}

+ (BOOL) validWhatsapp:(NSString *)whatsapp
{
    if (whatsapp.length == 0)
    {
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل رقم الهاتف"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
    
    NSString *myRegex = @"[0-9]*";
    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", myRegex];
    NSString *string = whatsapp;
    BOOL valid = [myTest evaluateWithObject:string];
    
    if (valid)
    {
        if (whatsapp.length < 8) {
            [PXAlertView showAlertWithTitle:nil
                                    message:@"رقم الهاتف لا يجب أن يقل عن ٨ أرقام"
                                cancelTitle:@"تم"
                                 otherTitle:nil
                                 completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                     if (cancelled) {
                                         NSLog(@"Cancel (Blue) button pressed");
                                     } else {
                                         NSLog(@"Other (Red) button pressed");
                                     }
                                 }];
            return NO ;
        }
        return YES ;
    }else{
        [PXAlertView showAlertWithTitle:nil
                                message:@"من فضلك أدخل رقم الهاتف بطريقة صحيحة"
                            cancelTitle:@"تم"
                             otherTitle:nil
                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                 if (cancelled) {
                                     NSLog(@"Cancel (Blue) button pressed");
                                 } else {
                                     NSLog(@"Other (Red) button pressed");
                                 }
                             }];
        return NO ;
    }
}

@end
