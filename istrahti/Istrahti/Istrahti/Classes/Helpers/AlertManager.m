//
//  AlertManager.m
//  CZone
//
//  Created by Ahmed Askar on 9/3/14.
//  Copyright (c) 2014 iOS. All rights reserved.
//

#import "AlertManager.h"

@implementation AlertManager
+(void)showNotificationOfType:(Notificationtype) type title:(NSString *)title message:(NSString *)message inController:(UIViewController *)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"موافق", nil)
                                              otherButtonTitles:nil];
        [alert show];
    });
}

@end
