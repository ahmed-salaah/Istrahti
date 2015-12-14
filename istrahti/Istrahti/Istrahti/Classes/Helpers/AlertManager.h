//
//  AlertManager.h
//  CZOne
//
//  Created by Ahmed Askar on 9/3/14.
//  Copyright (c) 2014 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    NotificationtypeSucess,
    NotificationtypeFailed
} Notificationtype;

@interface AlertManager : NSObject
+(void)showNotificationOfType:(Notificationtype)type
                        title:(NSString *)title
                      message:(NSString *)message
                 inController:(UIViewController *)controller;
@end
