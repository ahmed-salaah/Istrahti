//
//  Sharing.h
//  CZone
//
//  Created by Ahmed Askar on 6/27/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface SharingHelper : NSObject
+(void)share:(NSString *)text image:(UIImage *)image controller:(UIViewController *)controller;
@end
