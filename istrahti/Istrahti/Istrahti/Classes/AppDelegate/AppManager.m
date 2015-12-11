//
//  AppManager.m
//  Be3aQ8
//
//  Created by Ahmed Askar on 5/8/15.
//  Copyright (c) 2015 Askar. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

+ (AppManager *)sharedInstance
{
    static AppManager *_sharedInstance = nil ;
    
    static dispatch_once_t oncePredict ;
    
    dispatch_once(&oncePredict, ^{
        _sharedInstance = [[AppManager alloc] init];
    });
    
    return _sharedInstance ;
}


@end