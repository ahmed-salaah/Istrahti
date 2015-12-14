//
//  Sharing.m
//  CZone
//
//  Created by Ahmed Askar on 6/27/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "SharingHelper.h"

@implementation SharingHelper

+(void)share:(NSString *)text image:(UIImage *)image controller:(UIViewController *)controller {
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[text, image]
                                      applicationActivities:nil];
    [controller presentViewController:activityViewController
                                       animated:YES
                                     completion:nil];
}
@end
